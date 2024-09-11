import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/home/profile/view_model/profile_detail_view_model.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileDetailViewModel(), // ViewModel 생성
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Consumer<ProfileDetailViewModel>(
            builder: (context, viewModel, child) {
              return Text(
                '${viewModel.profile.name} 멘토님',
                style: const TextStyle(
                  fontFamily: 'PretendardSemiBold',
                  fontSize: 20,
                  color: Colors.black,
                ),
              );
            },
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<ProfileDetailViewModel>(
                builder: (context, viewModel, child) {
                  final profile = viewModel.profile;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          profile.imagePath,
                          width: double.infinity,
                          height: 150, // 이미지 높이
                          fit: BoxFit.cover, // 이미지 꽉 채우기
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: profile.tags.map((tag) => _buildTag(tag)).toList(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTitleText('아픈건 딱 질색이니까'),
                      const SizedBox(height: 8),
                      _buildProfileIntro(profile.intro),
                      const SizedBox(height: 30),
                      _buildTitleText('질문질문... 자기소개 유도 질문...'),
                      const SizedBox(height: 8),
                      _buildProfileDescription(profile.description1),
                      const SizedBox(height: 30),
                      _buildTitleText('질문질문... 자기소개 유도 질문...'),
                      const SizedBox(height: 8),
                      _buildProfileDescription(profile.description2),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.applyForCogo(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontFamily: 'PretendardMedium',
                            fontSize: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('코고 신청하기'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'PretendardMedium',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'PretendardMedium',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildProfileDescription(String description) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          description,
          style: const TextStyle(
            fontFamily: 'PretendardLight',
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileIntro(String description) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        description,
        style: const TextStyle(
          fontFamily: 'PretendardLight',
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }
}
