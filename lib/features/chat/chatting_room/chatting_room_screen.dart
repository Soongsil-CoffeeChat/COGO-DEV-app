import 'package:cogo/features/chat/chatting_room/chatting_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'widgets/sender_message.dart';
import 'widgets/receiver_message.dart';

class ChattingRoomScreen extends StatelessWidget {
  final int roomId;
  final String profileUrl;
  final String title;
  final String image;

  const ChattingRoomScreen(
      {super.key,
      required this.roomId,
      required this.profileUrl,
      required this.title,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => ChattingRoomViewModel(
          roomId: roomId, profileUrl: profileUrl, title: title, image: image),
      //..loadChatting(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('채팅방'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
              icon: SvgPicture.asset("assets/svg/arrow_back.svg"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Consumer<ChattingRoomViewModel>(
          builder: (context, viewModel, _) {
            return Column(
              children: [
                /// 상품 정보 영역
                Container(
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFFF6F6F6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        viewModel.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${viewModel.title}'),
                          Text('무료나눔'),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),

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
                          horizontal: 16, vertical: 8),
                      itemCount: viewModel.messages.length,
                      itemBuilder: (context, index) {
                        final msg = viewModel.messages[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
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

                // 입력창
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/chatting_add.svg',
                          width: 24, height: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _controller, // ✅ 입력값 바인딩
                            decoration: const InputDecoration(
                              hintText: '메시지 보내기',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),

// 보내기 버튼 수정
                      GestureDetector(
                        onTap: () {
                          final text = _controller.text.trim();
                          if (text.isNotEmpty) {
                            context
                                .read<ChattingRoomViewModel>()
                                .sendMessage(text);
                            _controller.clear(); // 입력창 비우기
                          }
                        },
                        child: SvgPicture.asset('assets/svg/chatting_send.svg',
                            width: 24, height: 24),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
