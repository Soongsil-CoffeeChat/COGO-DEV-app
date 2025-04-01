import 'dart:developer';

import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/tag_list.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/mypage/mypage_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
                          context.push(Paths.login);
                        },
                        size: BasicButtonSize.SMALL,
                      ),
                      const SizedBox(height: 30),
                      BasicButton(
                        text: "다시 시도하기",
                        isClickable: true,
                        onPressed: () {
                          viewModel.initialize();
                        },
                        size: BasicButtonSize.SMALL,
                      )
                    ],
                  ),
                );
              }

              final user = state.myPageInfo;

              return SingleChildScrollView(
                child: Padding(
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
                      if (user?.picture != null &&
                          user!.picture!.isNotEmpty) ...[
                        GestureDetector(
                            onTap: () {
                              context.push(Paths.image);
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Image.network(
                                    user.picture?.isNotEmpty == true
                                        ? user.picture!
                                        : '',
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      // 이미지를 로딩 중일 때, 아이콘을 항상 위에 놓음
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      log("===이미지 에러===");
                                      return Image.asset(
                                        'assets/default_img.png', // 로컬 기본 이미지
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Align(
                                    alignment: Alignment.center, // 중앙에 배치
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 48,
                                      color: Colors.grey
                                          .withOpacity(0.6), // 투명도 조절
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ] else ...[
                        GestureDetector(
                          onTap: () {
                            context.push(Paths.image);
                          },
                          child: SvgPicture.asset(
                            'assets/image/img_image.svg', // 기본 로컬 이미지
                          ),
                        ),
                      ],
                      const SizedBox(height: 13),
                      Center(
                        child: TagList(tags: user!.tags),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        title:
                            const Text('내 정보 관리', style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push(Paths.myInfo),
                      ),
                      if (user.role == Role.ROLE_MENTOR.name) ...[
                        ListTile(
                          title: const Text('자기소개 관리',
                              style: CogoTextStyle.body16),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push(Paths.myMentorIntroduce),
                        ),
                        ListTile(
                          title:
                              const Text('시간 설정', style: CogoTextStyle.body16),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push(Paths.timeSetting),
                        ),
                      ],
                      ListTile(
                          title:
                              const Text('로그아웃', style: CogoTextStyle.body16),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => {
                                viewModel.logOut(),
                                context.go(Paths.login), //라우팅 히스토리를 다 지움
                              }),
                      ListTile(
                          title:
                              const Text('탈퇴하기', style: CogoTextStyle.body16),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => {
                                viewModel.signOut(context),
                                context.go(Paths.login), //라우팅 히스토리를 다 지움
                              }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showMentorProfileDialog(BuildContext context) {
    final viewModel = Provider.of<MypageViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TwoButtonDialog(
          title: "정말 탈퇴하시겠어요?",
          subtitle: '탈퇴가 진행시 계정은 삭제되며, 계정은 복구되지 않습니다.',
          imagePath: 'assets/icons/3d_img/trash.png',
          firstButtonText: '취소하기',
          secondButtonText: '탈퇴하기',
          firstOnPressed: () => Navigator.of(context).pop(),
          secondOnPressed: () {
            viewModel.signOut(context);
          },
        );
      },
    );
  }
}
