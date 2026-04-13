import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/dto/response/chat/chat_room_response.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:cogo/data/service/coupon_service.dart';
import 'package:cogo/features/chat/chatting_room/chatting_room_view_model.dart';
import 'package:cogo/features/chat/chatting_room/widgets/attachment_panel.dart';
import 'package:cogo/features/chat/chatting_room/widgets/chat_input_bar.dart';
import 'package:cogo/features/chat/chatting_room/widgets/cogo_schedule_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'widgets/sender_message.dart';
import 'widgets/receiver_message.dart';

class ChattingRoomScreen extends StatefulWidget {
  const ChattingRoomScreen({super.key, required this.room});

  final ChatRoom room;

  @override
  State<ChattingRoomScreen> createState() => _ChattingRoomScreenState();
}

class _ChattingRoomScreenState extends State<ChattingRoomScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final CouponService _couponService = CouponService();

  // ── 패널 애니메이션 ──────────────────────────────────────────
  bool _isPanelOpen = false;
  late final AnimationController _panelController;

  static const double _panelHeight = 200.0;

  @override
  void initState() {
    super.initState();
    _panelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  void _togglePanel() {
    setState(() => _isPanelOpen = !_isPanelOpen);
    if (_isPanelOpen) {
      _panelController.forward();
      FocusScope.of(context).unfocus();
    } else {
      _panelController.reverse();
    }
  }

  Future<void> _onCouponTap(
      BuildContext context, ChattingRoomViewModel viewModel) async {
    _closePanel();

    final applicationId = viewModel.applicationId;
    if (applicationId == null) return;

    try {
      final eligibility = await _couponService.checkEligibility(applicationId);

      if (!mounted) return;

      if (!eligibility.canIssue) {
        final message = eligibility.alreadyIssued
            ? '이미 발급된 쿠폰입니다.'
            : eligibility.limitExceeded
                ? '쿠폰 발급 횟수를 초과했습니다.'
                : '쿠폰을 발급할 수 없습니다.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        return;
      }

      // canIssue == true
      if (viewModel.role == Role.ROLE_MENTOR.name) {
        context.safePush(Paths.qr, extra: applicationId);
      } else {
        context.safePush(Paths.qrScanner, extra: applicationId);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('쿠폰 발급 자격 확인 중 오류가 발생했습니다.')),
      );
    }
  }

  void _closePanel() {
    if (_isPanelOpen) {
      setState(() => _isPanelOpen = false);
      _panelController.reverse();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _panelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChattingRoomViewModel(ChatService(), widget.room),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _buildAppBar(context),
            body: Consumer<ChattingRoomViewModel>(
              builder: (context, viewModel, _) {
                _scrollToBottom();
                return Column(
                  children: [
                    CogoScheduleHeader(
                      otherPartyName: widget.room.participants.first.name,
                    ),
                    const Divider(
                        height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                    _buildMessageList(viewModel),
                    _buildInputBar(context),
                    SizeTransition(
                      sizeFactor: _panelController,
                      axisAlignment: 1,
                      child: SizedBox(
                        height: _panelHeight,
                        child: AttachmentPanel(
                          onImageTap: () {
                            _closePanel();
                            // TODO: 이미지 첨부 동작
                          },
                          onCouponTap: () => _onCouponTap(context, viewModel),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Consumer<ChattingRoomViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                widget.room.participants.first.isDeleted
                    ? '(알 수 없음)'
                    : (widget.room.participants.first.name ?? ''),
                style: CogoTextStyle.bodySB20,
              ),
              const SizedBox(width: 5),
              Transform.translate(
                offset: const Offset(0, 1),
                child: Text(
                  viewModel.role == Role.ROLE_MENTOR.name ? '멘티님' : '멘토님',
                  style: CogoTextStyle.body16,
                ),
              ),
            ],
          );
        },
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {
            final viewModel = context.read<ChattingRoomViewModel>();
            showModalBottomSheet(
              context: context,
              backgroundColor: CogoColor.white50,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (BuildContext context) {
                return _buildBottomSheetContent(context, viewModel);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildMessageList(ChattingRoomViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Expanded(
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerMove: (event) {
          // 아래 방향 드래그 시 키보드 내리기 (스크롤 불가 상황에서도 동작)
          if (event.delta.dy > 0) {
            _closePanel();
            FocusScope.of(context).unfocus();
          }
        },
        child: GestureDetector(
          onTap: () {
            _closePanel();
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.translucent,
          child: ListView.builder(
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          itemCount: viewModel.messages.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return _buildNoticeItem();

            final msgIndex = index - 1;
            final msg = viewModel.messages[msgIndex];
            final bool showDateHeader = viewModel.isNewDate(msgIndex);

            return Column(
              children: [
                if (showDateHeader)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 8),
                    child: Center(
                      child: Text(
                        viewModel.getDateHeader(msgIndex),
                        style: CogoTextStyle.body12
                            .copyWith(color: CogoColor.systemGray03),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: msg.isMe
                      ? ReceiverMessage(
                          text: msg.text,
                          time: msg.time,
                          isRead: msg.isRead,
                        )
                      : SenderMessage(
                          text: msg.text,
                          time: msg.time,
                          profileUrl: msg.profileUrl ?? '',
                        ),
                ),
              ],
            );
          },
        ),
        ),
      ),
    );
  }

  Widget _buildNoticeItem() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      decoration: BoxDecoration(
        color: CogoColor.systemGray01,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '부적절한 표현이나 비속어 사용 시 신고 및 이용 제한이 있을 수 있습니다.',
        style: CogoTextStyle.body12.copyWith(color: CogoColor.systemGray03),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: ChatInputBar(
        controller: _controller,
        onTapPlus: _togglePanel,
        isPanelOpen: _isPanelOpen,
        onSend: (text) {
          _closePanel();
          context.read<ChattingRoomViewModel>().sendMessage(text);
        },
      ),
    );
  }

  Widget _buildBottomSheetContent(
      BuildContext context, ChattingRoomViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('신고하기', style: CogoTextStyle.body16),
            onTap: () => viewModel.report(context),
          ),
        ],
      ),
    );
  }
}
