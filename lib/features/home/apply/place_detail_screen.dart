import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlaceDetailScreen extends StatelessWidget {
  final int mentorId;

  const PlaceDetailScreen({super.key, required this.mentorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Header(
                  title: '코고를 진행할 장소예요.',
                  subtitle: '장소는 변경 불가하오니 이 점 참고하여 커피챗 시간을 선택해주세요.',
                  onBackButtonPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 10),
              const Expanded(
                child: SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: BasicButton(
                    text: '다음',
                    isClickable: true,
                    onPressed: () => context.push(
                      Paths.schedule,
                      extra: {'mentorId': mentorId},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
