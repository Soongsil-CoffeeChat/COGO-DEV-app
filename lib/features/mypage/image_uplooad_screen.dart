import 'dart:developer';
import 'dart:typed_data';

import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import 'image_upload_view_model.dart';

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
                '최근 항목',
                style: CogoTextStyle.bodySB20,
              ),
              leading: IconButton(
                icon: SvgPicture.asset("assets/icons/button/chevron_left.svg"),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                TextButton(
                  onPressed: viewModel.selectedAsset == null
                      ? null
                      : () async {
                          final file = await viewModel.selectedAsset!.file;
                          if (file != null && context.mounted) {
                            Navigator.pop(context, [file]);
                          }
                        },
                  child: Text(
                    '완료',
                    style: CogoTextStyle.body16.copyWith(
                      color: viewModel.selectedAsset == null
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
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: viewModel.assets.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () => viewModel.pickFromCamera(context),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/button/camera_icon.svg",
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(height: 8),
                            const Text("사진 찍기", style: CogoTextStyle.body16),
                          ],
                        ),
                      ),
                    );
                  }

                  final asset = viewModel.assets[index - 1];
                  final isSelected = viewModel.isSelected(asset);

                  return FutureBuilder<Uint8List?>(
                    future: asset.thumbnailDataWithSize(
                      const ThumbnailSize(200, 200),
                    ) as Future<Uint8List?>?,
                    builder: (context, snapshot) {
                      final bytes = snapshot.data;
                      if (bytes == null) return const SizedBox();

                      return GestureDetector(
                        onTap: () => viewModel.toggleSelection(asset),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                child: Image.memory(
                                  bytes,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CogoColor.systemGray05,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            if (isSelected)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CogoColor.systemGray05,
                                    width: 3,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}
