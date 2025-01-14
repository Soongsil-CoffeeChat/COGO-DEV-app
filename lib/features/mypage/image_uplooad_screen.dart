import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_upload_view_model.dart';

class ImageUploadScreen extends StatelessWidget {
  const ImageUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageUploadViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text("Image Uploader")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ImageUploadViewModel>(
            builder: (context, viewModel, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (viewModel.selectedImage != null)
                      Image.file(
                        viewModel.selectedImage!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: viewModel.pickImageFromGallery,
                            child: const Text("갤러리")),
                        ElevatedButton(
                            onPressed: viewModel.takeImageFromCamera,
                            child: const Text("카메라")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async => {
                        log("사진을 바꿔요"),
                        viewModel.uploadImage(),
                        if (viewModel.isUpload) {Navigator.of(context).pop()}
                      },
                      child: viewModel.isUploading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("저장하기"),
                    ),
                    if (viewModel.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          viewModel.errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
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
