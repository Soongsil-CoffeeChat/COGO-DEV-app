// chat_screen.dart
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:cogo/features/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:cogo/data/dto/response/chat/chat_room_response.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(ChatService()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('채팅', style: CogoTextStyle.bodySB20),
        ),
        body: Consumer<ChatViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final rooms = vm.rooms; // List<ChatRoom>

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
      onTap: () {
        context.push(Paths.chattingRoom, extra: room);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: const _CircleAvatarPlaceholder(),
      title: Row(
        children: [
          Expanded(
            child: Text(
              room.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatKoreanDate(room.createdAt),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          room.message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium,
        ),
      ),
      // 스샷처럼 우측 미니 썸네일/뱃지 필요하면 trailing에 추가
      trailing: const _UnreadBadge(count: 1), // 서버 unreadCount 생기면 교체
    );
  }
}

class _CircleAvatarPlaceholder extends StatelessWidget {
  const _CircleAvatarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey,
      child: Icon(Icons.person, color: Colors.white),
    );
  }
}

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

String _formatKoreanDate(DateTime dt) => '${dt.month}월 ${dt.day}일';
