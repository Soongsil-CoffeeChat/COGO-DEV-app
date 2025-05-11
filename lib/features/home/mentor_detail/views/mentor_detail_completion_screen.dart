import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:cogo/features/home/mentor_detail/mentor_introduction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MentorDetailCompletionScreen extends StatelessWidget {
  const MentorDetailCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorIntroductionViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  title: '축하해요!',
                  subtitle: '앞으로의 활동을 COGO가 응원해요!',
                  onBackButtonPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/3d_img/coffee.png',
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
                const Spacer(),
                Consumer<MentorIntroductionViewModel>(
                  builder: (context, viewModel, _) {
                    return BasicButton(
                      text: '프로필 작성 완료하기',
                      isClickable: true,
                      size: BasicButtonSize.LARGE,
                      onPressed: () async {
                        final homeViewModel =
                            Provider.of<HomeViewModel>(context, listen: false);
                        await homeViewModel.fetchIntroductionData();
                        context.go(Paths.home);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
