import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/data/dto/response/chat/chat_room_response.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:cogo/features/chat/chatting_room/chatting_room_view_model.dart';
import 'package:cogo/features/chat/chatting_room/widgets/chat_input_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/sender_message.dart';
import 'widgets/receiver_message.dart';

class ChattingRoomScreen extends StatelessWidget {
  const ChattingRoomScreen({super.key, required this.room});

  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => ChattingRoomViewModel(ChatService()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                    room.participants.first.name,
                    style: CogoTextStyle.bodySB20,
                  ),
                  const SizedBox(width: 5),
                  Transform.translate(
                    offset: const Offset(0, 1),
                    child: Text(
                      viewModel.role == Role.ROLE_MENTOR.name ? '멘토님' : '멘티님',
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
              onPressed: () {},
            ),
          ],
        ),
        body: Consumer<ChattingRoomViewModel>(
          builder: (context, viewModel, _) {
            return Column(
              children: [
                // 코고 정보
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '코고 일정',
                              style: CogoTextStyle.body16,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '2025년 4월 30일 커피나무 숭실대점 9시',
                              style: CogoTextStyle.bodyR12
                                  .copyWith(color: CogoColor.systemGray04),
                            ),
                          ],
                        ),
                      ),

                      /// 보러가기 버튼
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '보낸 코고 보러가기',
                          style: CogoTextStyle.body12
                              .copyWith(color: CogoColor.white50),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                    height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

                /// 메시지 목록
                if (viewModel.isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      reverse: false,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      itemCount: viewModel.messages.length + 1, // 날짜 구분선 포함
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Center(
                              child: Text(
                                //TODO 채팅방 날짜 구현
                                '2025년 4월 14일 월요일',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          );
                        }

                        final msg = viewModel.messages[index - 1];
                        return Padding(
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
                        );
                      },
                    ),
                  ),

                /// 입력창
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                    ),
                  ),
                  child: ChatInputBar(
                    controller: _controller,
                    onTapPlus: () {
                      //TODO 플러스 버튼 동작(파일 첨부, 사진 등)
                    },
                    onSend: (text) {
                      //TODO send action 구현
                      context.read<ChattingRoomViewModel>().sendMessage(text);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
