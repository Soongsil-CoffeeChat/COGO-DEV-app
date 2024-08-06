import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/home/profile/view_model/profile_detail_view_model.dart';

class ProfileDetailScreen extends StatelessWidget {
  final String imagePath;
  final String name;
  final String clubName;
  final List<String> tags;

  const ProfileDetailScreen({
    super.key,
    required this.imagePath,
    required this.name,
    required this.clubName,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileDetailViewModel(
        imagePath: imagePath,
        name: name,
        clubName: clubName,
        tags: tags,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0, // appbar 컬러 오류 해결
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'), // SVG 이미지 사용
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Consumer<ProfileDetailViewModel>(
            builder: (context, viewModel, child) {
              return Text(
                '${viewModel.name} 멘토님',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(imagePath),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: tags.map((tag) => _buildTag(tag)).toList(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTitleText('아픈건 딱 질색이니까'),
                  const SizedBox(height: 8),
                  _buildProfileIntro(
                    '오늘도 아침엔 일에 밥을 먹고 똑같이 하루를 시작하고 운동일 한 손엔 아이스 아메리카노. 피곤해 죽겠네',
                  ),
                  const SizedBox(height: 30),
                  _buildTitleText('질문질문... 자기소개 유도 질문...'),
                  const SizedBox(height: 8),
                  _buildProfileDescription(
                    '오늘도 아침엔 일에 밥을 먹고 똑같이 하루를 시작하고 운동일 한 손엔 아이스 아메리카노. 피곤해 죽겠네',
                  ),
                  const SizedBox(height: 30),
                  _buildTitleText('질문질문... 자기소개 유도 질문...'),
                  const SizedBox(height: 8),
                  _buildProfileDescription(
                    '오늘도 아침엔 일에 밥을 먹고 똑같이 하루를 시작하고 운동일 한 손엔 아이스 아메리카노. 피곤해 죽겠네',
                  ),
                  const SizedBox(height: 30),
                  Consumer<ProfileDetailViewModel>(
                    builder: (context, viewModel, child) {
                      return ElevatedButton(
                        onPressed: () {
                          viewModel.applyForCogo();
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
                          minimumSize: const Size(double.infinity, 50), // 버튼 크기 조절
                        ),
                        child: const Text('코고 신청하기'),
                      );
                    },
                  ),
                ],
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
            fontFamily: 'PretendardMedium',
            fontSize: 12,
            color: Colors.grey,
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
          fontFamily: 'PretendardMedium',
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }
}
