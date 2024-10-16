import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/home/profile/view_model/profile_detail_view_model.dart';

class ProfileDetailScreen extends StatelessWidget {
  final String mentorId;

  const ProfileDetailScreen({Key? key, required this.mentorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileDetailViewModel(mentorId), // Pass mentorId to ViewModel
      child: Scaffold(
        backgroundColor: CogoColor.white50,
        resizeToAvoidBottomInset: true, // 키보드 오버 플로우 해결
        appBar: AppBar(
          backgroundColor: CogoColor.white50,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Consumer<ProfileDetailViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                //api 호출 중일때(로딩중)
                return const Text(
                  '',
                );
              }
              final profile = viewModel.profile;
              return Text(
                profile != null ? '${profile.mentorName} 멘토님' : '멘토 정보 없음',
                style: CogoTextStyle.body20,
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
                  if (viewModel.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(), // 로딩 스피너 표시
                    );
                  }

                  final profile = viewModel.profile;

                  if (profile == null) {
                    return const Center(
                      child: Text('프로필 정보를 불러올 수 없습니다.'),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(
                          profile.imageUrl,
                          width: double.infinity,
                          height: 150, // 이미지 높이
                          fit: BoxFit.cover, // 이미지 꽉 채우기
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTag(profile.part),
                            _buildTag(profile.club),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTitleText(profile.introductionTitle),
                      const SizedBox(height: 8),
                      _buildProfileIntro(profile.introductionDescription),
                      const SizedBox(height: 30),
                      _buildTitleText('질문질문... 자기소개 유도 질문...'),
                      const SizedBox(height: 8),
                      _buildProfileDescription(profile.introductionAnswer1),
                      const SizedBox(height: 30),
                      _buildTitleText('질문질문... 자기소개 유도 질문...'),
                      const SizedBox(height: 8),
                      _buildProfileDescription(profile.introductionAnswer2),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.applyForCogo(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CogoColor.main,
                          foregroundColor: CogoColor.white50,
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
          color: CogoColor.main,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: CogoTextStyle.tag,
        ),
      ),
    );
  }

  Widget _buildTitleText(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: CogoTextStyle.body16,
      ),
    );
  }

  Widget _buildProfileDescription(String description) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CogoColor.systemGray01,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          description,
          style: CogoTextStyle.body12,
        ),
      ),
    );
  }

  Widget _buildProfileIntro(String description) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        description,
        style: CogoTextStyle.intro,
      ),
    );
  }
}
