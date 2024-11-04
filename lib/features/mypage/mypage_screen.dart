import 'package:cogo/common/widgets/tag_list.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/mypage/mypage_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MypageScreen extends StatelessWidget {
  var a = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MypageViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // 키보드 오버 플로우 해결
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '유진 멘토님',
                      style: CogoTextStyle.body18,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Consumer<MypageViewModel>(
                        builder: (context, viewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/image/img_image.svg', // SVG 파일 경로
                          ),

                          const Center(
                            child: TagList(tags: [
                              "야호",
                              "야호야"
                            ]), // Centering the Tag widget
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            title: const Text(
                              '내 정보 관리',
                              style: CogoTextStyle.body16,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              viewModel
                                  .navigateToMyInformationManagement(context);
                            },
                          ),
                          // const SizedBox(height: 5),
                          const Divider(
                              height: 0.2, color: CogoColor.systemGray02),
                          // const SizedBox(height: 5),

                          /**
                           * 멘토에게만 필요한 기능이므로 조건문을 걸어줍니다.
                           */
                          a == true
                              // FlutterConfig.get("role") == "mentor"
                              ? Column(
                                  children: [
                                    ListTile(
                                      title: const Text(
                                        '자기소개 관리',
                                        style: CogoTextStyle.body16,
                                      ),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () {
                                        viewModel
                                            .navigateToMentorIntroduceManagement(
                                                context);
                                      },
                                    ),
                                    const Divider(
                                        height: 0.2,
                                        color: CogoColor.systemGray02),
                                    // const SizedBox(height: 5),
                                    ListTile(
                                      title: const Text(
                                        '시간 설정',
                                        style: CogoTextStyle.body16,
                                      ),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () {
                                        viewModel.navigateToMentorTimeSetting(
                                            context);
                                      },
                                    ),
                                  ],
                                )
                              : Container(), // 조건이 false일 때 빈 컨테이너 반환
                        ],
                      );
                    })
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
