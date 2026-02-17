import 'dart:async';

import 'package:cogo/common/navigator/bottom_navigation_bar_view_model.dart';
import 'package:cogo/common/widgets/atoms/image/network_image_with_fallback.dart';
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:cogo/features/chat/chat_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:cogo/data/dto/response/chat/chat_room_response.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatViewModel _chatViewModel;
  late BottomNavigationViewModel _bottomVM;
  int _lastSelectedIndex = -1;
  StreamSubscription<RemoteMessage>? _fcmSubscription;

  @override
  void initState() {
    super.initState();
    _chatViewModel = ChatViewModel();

    _bottomVM = context.read<BottomNavigationViewModel>();
    _bottomVM.addListener(_onBottomNavChange);

    // FCM 메시지 수신 시 채팅 목록 자동 새로고침
    _fcmSubscription = FirebaseMessaging.onMessage.listen((_) {
      _chatViewModel.refreshChatRooms();
    });
  }

  void _onBottomNavChange() {
    if (_bottomVM.selectedIndex == 2) {
      _chatViewModel.refreshChatRooms();
    }
  }

  @override
  void dispose() {
    _fcmSubscription?.cancel();
    _bottomVM.removeListener(_onBottomNavChange);
    _chatViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _chatViewModel,
      child: Consumer<BottomNavigationViewModel>(
        builder: (context, bottomVM, _) {
          if (bottomVM.selectedIndex == 2 && _lastSelectedIndex != 2) {
            _lastSelectedIndex = 2;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _chatViewModel.refreshChatRooms();
            });
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: const Text('채팅', style: CogoTextStyle.bodySB20),
            ),
            body: Consumer<ChatViewModel>(
              builder: (context, vm, _) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final rooms = vm.rooms;

                if (rooms.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/3d_img/empty.png',
                          height: 150,
                        ),
                        const SizedBox(height: 20),
                        Text('멘토에게 보낸 코고 신청이 수락되면\n자동으로 채팅방이 생성됩니다',
                            textAlign: TextAlign.center,
                            style: CogoTextStyle.body14
                                .copyWith(color: CogoColor.systemGray03)),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];

                    return Column(
                      children: [
                        _ChatRoomTile(room: room),
                        if (index != rooms.length - 1)
                          const Padding(
                            padding: EdgeInsets.only(left: 80, right: 16),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ChatRoomTile extends StatelessWidget {
  const _ChatRoomTile({required this.room});
  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: () async {
        await context.push(Paths.chattingRoom, extra: room);
        if (context.mounted) {
          context.read<ChatViewModel>().refreshChatRooms();
        }
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: _CircleAvatarPlaceholder(
        imageUrl: room.participants.first.profileImage,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              room.participants.first.isDeleted
                  ? '(알 수 없음)' : (room.participants.first.name ?? ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatKoreanDate(room.updatedAt),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          room.lastChat ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium,
        ),
      ),
      //trailing: const _UnreadBadge(count: 1), // 서버 unreadCount 생기면 교체
    );
  }
}

class _CircleAvatarPlaceholder extends StatelessWidget {
  const _CircleAvatarPlaceholder({required this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: NetworkImageWithFallback(
        url: imageUrl,
        fallbackAsset: 'assets/image/empty_chat_img.svg',
        width: 44,
        height: 44,
        fit: BoxFit.cover,
      ),
    );
  }
}
/*
class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const ShapeDecoration(
        color: Colors.red,
        shape: StadiumBorder(),
      ),
      child: Text(
        '$count',
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
*/

String _formatKoreanDate(DateTime dt) => '${dt.month}월 ${dt.day}일';
