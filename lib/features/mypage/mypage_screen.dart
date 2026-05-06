import 'dart:developer';

import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/tag_list.dart';
import 'package:cogo/common/widgets/widgets.dart'; // BasicButton, TwoButtonDialog, CogoTextStyle 등
import 'package:cogo/constants/constants.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/cogo/cogo_view_model.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:cogo/features/mypage/mypage_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                        context.go(Paths.login);
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
                      title: const Text('내 정보 관리', style: CogoTextStyle.body16),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.safePush(Paths.myInfo),
                    ),
                    if (user?.role == Role.ROLE_MENTOR.name) ...[
                      ListTile(
                        title:
                            const Text('자기소개 관리', style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.safePush(Paths.myMentorIntroduce),
                      ),
                      ListTile(
                        title: const Text('시간 설정', style: CogoTextStyle.body16),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.safePush(Paths.timeSetting),
                      ),
                    ],
                    ListTile(
                      title: const Text('알림 설정', style: CogoTextStyle.body16),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.safePush(Paths.notificationSetting),
                    ),
                    ListTile(
                      title: const Text('로그아웃', style: CogoTextStyle.body16),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showLogoutDialog(context, viewModel),
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

    return Column(
      children: [
        GestureDetector(
          onTap: viewModel.isUploading
              ? null
              : () {
                  final oldUrl = imageUrl;
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => _ProfileImagePickerSheet(
                      viewModel: viewModel,
                      oldImageUrl: oldUrl,
                    ),
                  );
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
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            log("이미지 로드 실패: $imageUrl");
                            return SvgPicture.asset(
                              'assets/image/empty_profile_img.svg',
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : SvgPicture.asset(
                          'assets/image/empty_profile_img.svg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              // 2층: 카메라 아이콘 (이미지 없을 때만)
              if (!hasImage)
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

              // 3층: 업로드 중 오버레이
              if (viewModel.isUploading)
                const Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: ColoredBox(
                      color: Colors.black54,
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // 업로드 에러 메시지
        if (viewModel.uploadError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              viewModel.uploadError!,
              style: CogoTextStyle.body14.copyWith(color: CogoColor.systemRed),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext outerContext, MypageViewModel viewModel) {
    showDialog(
      context: outerContext,
      builder: (BuildContext dialogContext) {
        return TwoButtonDialog(
          title: "로그아웃 하시겠어요?",
          subtitle: '로그아웃 후 다시 로그인할 수 있습니다.',
          imagePath: 'assets/icons/3d_img/trash.png',
          firstButtonText: '취소하기',
          secondButtonText: '로그아웃',
          firstOnPressed: () => Navigator.of(dialogContext).pop(),
          secondOnPressed: () async {
            Navigator.of(dialogContext).pop();
            await viewModel.logOut();
            if (outerContext.mounted) {
              outerContext.read<CogoViewModel>().reset();
              outerContext.read<HomeViewModel>().reset();
              Future.microtask(() => outerContext.go(Paths.login));
            }
          },
        );
      },
    );
  }

  void _showMentorProfileDialog(
      BuildContext outerContext, MypageViewModel viewModel) {
    showDialog(
      context: outerContext,
      builder: (BuildContext dialogContext) {
        return TwoButtonDialog(
          title: "정말 탈퇴하시겠어요?",
          subtitle: '탈퇴 후 계정은 삭제되지만, 7일 이내 재가입 시 복구할 수 있습니다.',
          imagePath: 'assets/icons/3d_img/trash.png',
          firstButtonText: '취소하기',
          secondButtonText: '탈퇴하기',
          firstOnPressed: () => Navigator.of(dialogContext).pop(),
          secondOnPressed: () async {
            await viewModel.signOut(dialogContext);
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop();
            }
            if (outerContext.mounted) {
              Future.microtask(() => outerContext.go(Paths.login));
            }
          },
        );
      },
    );
  }
}

class _ProfileImagePickerSheet extends StatelessWidget {
  final MypageViewModel viewModel;
  final String? oldImageUrl;

  const _ProfileImagePickerSheet({
    required this.viewModel,
    this.oldImageUrl,
  });

  void _pick(BuildContext context, ImageSource source) {
    viewModel.pickAndUpload(
      source,
      onPicked: () {
        // 이미지 선택 직후: 캐시 제거 후 바텀시트 닫기
        if (oldImageUrl != null && oldImageUrl!.isNotEmpty) {
          imageCache.evict(NetworkImage(oldImageUrl!));
        }
        if (context.mounted) Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 핸들 바
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: CogoColor.systemGray03,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/button/camera_icon.svg',
                width: 24,
                height: 24,
              ),
              title: const Text('사진 촬영', style: CogoTextStyle.body16),
              onTap: () => _pick(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined,
                  size: 24, color: Colors.black),
              title: const Text('앨범에서 선택', style: CogoTextStyle.body16),
              onTap: () => _pick(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
