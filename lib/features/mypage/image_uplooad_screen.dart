import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_upload_view_model.dart';

class ImageUploadScreen extends StatelessWidget {
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
              return Column(
                children: [
                  if (viewModel.selectedImage != null)
                    Image.file(
                      viewModel.selectedImage!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: viewModel.pickImage,
                    child: Text("Pick Image from Gallery"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:
                        viewModel.isUploading ? null : viewModel.uploadToS3,
                    child: viewModel.isUploading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Upload to S3"),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
