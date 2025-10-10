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

  const ChattingRoomScreen({
    super.key,
    required this.roomId,
    required this.profileUrl,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => ChattingRoomViewModel(
        roomId: roomId,
        profileUrl: profileUrl,
        title: title,
        image: image,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                '멘토님',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
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
                // 상품 정보 영역
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      // 상품 이미지
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          viewModel.image,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // 상품 정보
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              '2025년 4월 30일 커피나무 숭실대점 9시',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 보러가기 버튼
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '보낸 코고 보러가기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                    height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

                // 메시지 목록
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
                        // 첫 번째 아이템은 날짜 구분선
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Center(
                              child: Text(
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

                // 입력창
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        // 추가 버튼
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.grey,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 입력창
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: '메시지 보내기',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 보내기 버튼
                        GestureDetector(
                          onTap: () {
                            final text = _controller.text.trim();
                            if (text.isNotEmpty) {
                              context
                                  .read<ChattingRoomViewModel>()
                                  .sendMessage(text);
                              _controller.clear();
                            }
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.grey,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
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
