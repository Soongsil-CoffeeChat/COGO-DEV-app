import 'dart:io';

import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/features/mypage/image/image_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ImageUploadScreen extends StatelessWidget {
  const ImageUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageUploadViewModel(),
      child: Consumer<ImageUploadViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text(
                '이미지 업로드',
                style: CogoTextStyle.bodySB20,
              ),
              leading: IconButton(
                icon: SvgPicture.asset("assets/icons/button/chevron_left.svg"),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                TextButton(
                  onPressed: viewModel.selectedFile== null || viewModel.isUploading
                      ? null
                      : () async {
                    await viewModel.uploadImage(
                      onSuccess: () {
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    );
                    if (viewModel.errorMessage != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(viewModel.errorMessage!)),
                      );
                    }
                  },
                  child: Text(
                    viewModel.isUploading ? '업로드 중' : '완료',
                    style: CogoTextStyle.body16.copyWith(
                      color: viewModel.selectedFile == null || viewModel.isUploading
                          ? CogoColor.systemGray03
                          : CogoColor.systemGray05,
                    ),
                  ),
                ),
              ],
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(
                  height: 1,
                  color: CogoColor.systemGray03,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. 이미지 미리보기 영역
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: CogoColor.systemGray01, // 배경색 (필요시 수정)
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: CogoColor.systemGray03),
                      ),
                      child: viewModel.selectedFile != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(viewModel.selectedFile!.path),
                          fit: BoxFit.contain, // 혹은 cover
                        ),
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image_outlined,
                            size: 60,
                            color: CogoColor.systemGray03,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "사진을 선택해주세요",
                            style: CogoTextStyle.body16.copyWith(
                              color: CogoColor.systemGray03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. 버튼 영역 (카메라 / 갤러리)
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          iconPath: "assets/icons/button/camera_icon.svg", // 아이콘 경로 확인 필요
                          label: "사진 촬영",
                          onTap: () => viewModel.pickFromCamera(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ActionButton(
                          icon: Icons.photo_library_outlined, // SVG 대신 기본 아이콘 사용 예시
                          label: "앨범에서 선택",
                          onTap: () => viewModel.pickImage(),
                          isPrimary: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}

// 버튼 컴포넌트 (내부 사용용)
class _ActionButton extends StatelessWidget {
  final String? iconPath;
  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ActionButton({
    this.iconPath,
    this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isPrimary ? CogoColor.systemGray05 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CogoColor.systemGray05,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null)
              SvgPicture.asset(
                iconPath!,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isPrimary ? Colors.white : CogoColor.systemGray05,
                  BlendMode.srcIn,
                ),
              )
            else if (icon != null)
              Icon(
                icon,
                color: isPrimary ? Colors.white : CogoColor.systemGray05,
                size: 24,
              ),
            const SizedBox(width: 8),
            Text(
              label,
              style: CogoTextStyle.body16.copyWith(
                color: isPrimary ? Colors.white : CogoColor.systemGray05,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}