import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/tag_list.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/mypage/mypage_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MypageViewModel()..initialize,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<MypageViewModel>(
            builder: (context, viewModel, child) {
              final state = viewModel.state;

              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
                    crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
                    children: [
                      const Text(
                        '데이터를 불러오는 중 오류가 발생했습니다.',
                        style: TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 30),
                      BasicButton(
                        text: "로그인 화면으로 돌아가기",
                        isClickable: true,
                        onPressed: () {
                          viewModel.navigateToLoginScreen(context);
                        },
                      ),
                      const SizedBox(height: 30),
                      BasicButton(
                        text: "다시 시도하기",
                        isClickable: true,
                        onPressed: () {
                          viewModel.initialize();
                        },
                      )
                    ],
                  ),
                );
              }

              final user = state.myPageInfo;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 13),
                    Text(
                      '${user?.name ?? "사용자"}님',
                      style: CogoTextStyle.bodySB20,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 13),
                    Image.network(
                      user!.picture!,
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                            'assets/image/img_image.svg'); // 로드 실패 시 기본 이미지
                      },
                    ),
                    const SizedBox(height: 13),
                    Center(
                      child: TagList(tags: user.tags),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: const Text('내 정보 관리', style: CogoTextStyle.body16),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => viewModel
                          .navigateToMyInformationManagementScreen(context),
                    ),
                    if (state.role == Role.MENTOR.name) ...[
                      ListTile(
                        title:
                            const Text('자기소개 관리', style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => viewModel
                            .navigateToMentorIntroduceManagementScreen(context),
                      ),
                      ListTile(
                        title: const Text('시간 설정', style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => viewModel
                            .navigateToMentorTimeSettingScreen(context),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
