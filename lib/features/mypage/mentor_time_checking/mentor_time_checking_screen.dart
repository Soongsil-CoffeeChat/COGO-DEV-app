import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/mypage/mentor_time_checking/mentor_time_checking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MentorTimeCheckingScreen extends StatefulWidget {
  const MentorTimeCheckingScreen({super.key});

  @override
  _MentorTimeCheckingScreenState createState() =>
      _MentorTimeCheckingScreenState();
}

class _MentorTimeCheckingScreenState extends State<MentorTimeCheckingScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorTimeCheckingViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Header(
                    title: 'COGO 시간',
                    subtitle: 'COGO를 진행하기 편한 시간 대를 알려주세요.',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
