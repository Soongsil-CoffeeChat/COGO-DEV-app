import 'dart:developer';

import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/home/profile/profile_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileDetailScreen extends StatelessWidget {
  final int mentorId;

  const ProfileDetailScreen({Key? key, required this.mentorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ProfileDetailViewModel(mentorId), // Pass mentorId to ViewModel
      child: Scaffold(
        backgroundColor: CogoColor.white50,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: CogoColor.white50,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: CogoColor.white50,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (BuildContext context) {
                      return _buildBottomSheetContent(context);
                    },
                  );
                },
                icon: const Icon(Icons.more_vert))
          ],
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            profile.imageUrl.isNotEmpty
                                ? profile.imageUrl
                                : '', // 빈 문자열로 설정해 에러를 유도
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              log("===이미지 에러===");
                              return Image.asset(
                                'assets/default_img.png', // 로컬 기본 이미지
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              );
                            },
                          )),
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
                      _buildTitleText('이런 분야에서 멘토링이 가능해요'),
                      const SizedBox(height: 8),
                      _buildProfileDescription(profile.introductionAnswer1),
                      const SizedBox(height: 30),
                      _buildTitleText('이런 경험들을 해왔어요'),
                      const SizedBox(height: 8),
                      _buildProfileDescription(profile.introductionAnswer2),
                      const SizedBox(height: 30),
                      if (viewModel.role == Role.ROLE_MENTEE.name)
                        BasicButton(
                          text: '코고 신청하기',
                          isClickable: true,
                          size: BasicButtonSize.LARGE,
                          onPressed: () {
                            viewModel.applyForCogo(context, mentorId);
                          },
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
        style: CogoTextStyle.bodyL12,
      ),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text(
              '신고하기',
              style: CogoTextStyle.body16,
            ),
            onTap: () {
              context.push(Paths.report);
              // 설정 메뉴 선택
            },
          ),
        ],
      ),
    );
  }
}
