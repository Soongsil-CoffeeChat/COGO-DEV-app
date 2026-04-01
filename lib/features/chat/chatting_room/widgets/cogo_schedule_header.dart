import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/chat/chatting_room/chatting_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CogoScheduleHeader extends StatelessWidget {
  const CogoScheduleHeader({super.key, required this.otherPartyName});

  final String? otherPartyName;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChattingRoomViewModel>(
      builder: (context, viewModel, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      '${viewModel.formattedDate} eea cafe ${viewModel.formattedTime}',
                      style: CogoTextStyle.bodyR12
                          .copyWith(color: CogoColor.systemGray04),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(
                    Paths.matchedCogoDetail,
                    extra: {
                      'applicationId': viewModel.applicationId,
                      'otherPartyName': otherPartyName,
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    viewModel.role == Role.ROLE_MENTOR.name
                        ? '받은 코고 보러가기'
                        : '보낸 코고 보러가기',
                    style:
                        CogoTextStyle.body12.copyWith(color: CogoColor.white50),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
