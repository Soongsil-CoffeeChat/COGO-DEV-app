import 'dart:developer';

import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/tag_list.dart';
import 'package:cogo/common/widgets/widgets.dart'; // BasicButton, TwoButtonDialog, CogoTextStyle 등
import 'package:cogo/constants/constants.dart';
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<MypageViewModel>(
            builder: (context, viewModel, child) {
              final state = viewModel.state;

              // 1. 로딩 상태
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // 2. 에러 상태
              if (state.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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

              // 3. 정상 데이터 표시
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

                      // 프로필 이미지 위젯
                      _buildProfileImage(
                        context,
                        imageUrl: user?.picture,
                        viewModel: viewModel,
                      ),

                      const SizedBox(height: 13),
                      Center(
                        child: TagList(tags: user?.tags ?? []),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        title:
                        const Text('내 정보 관리', style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push(Paths.myInfo),
                      ),
                      if (user?.role == Role.ROLE_MENTOR.name) ...[
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
                        title: const Text('로그아웃', style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          await viewModel.logOut();
                          if (context.mounted) {
                            context.go(Paths.login);
                          }
                        },
                      ),
                      ListTile(
                        title: const Text('탈퇴하기', style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _showMentorProfileDialog(context, viewModel),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
    );
  }

  /// 프로필 이미지를 그리는 공통 메서드 (이미지 유무 상관없이 Stack 구조 유지)
  Widget _buildProfileImage(
      BuildContext context, {
        String? imageUrl,
        required MypageViewModel viewModel,
      }) {
    final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return GestureDetector(
      onTap: () async {
        // 이미지 수정 페이지로 이동
        await context.push(Paths.image);

        // 돌아왔을 때 데이터 갱신 (사진 변경 반영)
        if (context.mounted) {
          log("이미지 화면에서 복귀 -> 데이터 갱신 요청");
          await viewModel.refreshMyPage();
        }
      },
      child: Stack(
        children: [
          // 1층: 이미지 (네트워크 이미지 or 기본 SVG)
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: hasImage
                  ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  log("이미지 로드 실패: $imageUrl");
                  // 로드 실패 시 기본 이미지
                  return SvgPicture.asset(
                    'assets/image/empty_profile_img.svg',
                    fit: BoxFit.cover,
                  );
                },
              )
                  : SvgPicture.asset(
                // URL이 없을 때 기본 이미지
                'assets/image/empty_profile_img.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2층: 카메라 아이콘 (항상 위에 표시)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: CogoColor.systemGray03,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMentorProfileDialog(BuildContext context, MypageViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TwoButtonDialog(
          title: "정말 탈퇴하시겠어요?",
          subtitle: '탈퇴 후 계정은 삭제되지만, 7일 이내 재가입 시 복구할 수 있습니다.',
          imagePath: 'assets/icons/3d_img/trash.png',
          firstButtonText: '취소하기',
          secondButtonText: '탈퇴하기',
          firstOnPressed: () => Navigator.of(context).pop(),
          secondOnPressed: () async {
            await viewModel.signOut(context);
            if (context.mounted) {
              context.go(Paths.login);
            }
          },
        );
      },
    );
  }
}