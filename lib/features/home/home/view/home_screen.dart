import 'package:cogo/common/db/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/widgets/horizontal_button_list.dart';
import 'package:cogo/common/widgets/horizontal_profile_card.dart';
import 'package:cogo/features/home/home/view_model/home_view_model.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/common/widgets/atoms/texts/texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // 화면이 로드된 후에 Provider에 접근
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<HomeViewModel>(context, listen: false);

      // ViewModel의 role과 isIntroductionComplete 값으로 다이얼로그 표시 여부 결정
      if (viewModel.selectedRole == 'mentor' && !viewModel.isIntroductionComplete) {
        _showMentorProfileDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _customAppBar(context),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _text(),
                ),
                const SizedBox(height: 20),
                _buildProfileCardList(context),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _customAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'COGO',
        style: CogoTextStyle.header1,
      ),
      centerTitle: false,
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: IconButton(
            icon: SvgPicture.asset('assets/icons/button/search.svg'),
            onPressed: () {
              Provider.of<HomeViewModel>(context, listen: false)
                  .onSearchPressed(context);
            },
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
          ),
        ),
        const SizedBox(width: 16),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Column(
          children: [
            HorizontalButtonList(
              buttonTitles: const ['기획', '디자인', 'FE', 'BE'],
              onButtonPressed: (title) {
                Provider.of<HomeViewModel>(context, listen: false)
                    .onButtonPressed(context, title);
              },
            ),
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }

  Widget _text() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '어떤 동아리 선배가 있을까요?',
          style: CogoTextStyle.header2,
        ),
        SizedBox(height: 4),
        Text(
          '동아리별 코고 선배 알아보기',
          style: CogoTextStyle.caption2,
        ),
      ],
    );
  }

  Widget _buildProfileCardList(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.profiles.length,
            itemBuilder: (context, index) {
              final profile = viewModel.profiles[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: HorizontalProfileCard(
                  imagePath: profile['imagePath'],
                  name: profile['name'],
                  clubName: profile['clubName'],
                  tags: profile['tags'],
                  onTap: () {
                    // role이 mentor이고, 자기소개가 완료되지 않았다면 다이얼로그 띄우기
                    if (viewModel.selectedRole == 'mentor' &&
                        !viewModel.isIntroductionComplete) {
                      _showMentorProfileDialog(context);
                    } else {
                      // 자기소개가 완료되었으면 해당 프로필 상세 페이지로 이동
                      context.push(
                        Paths.profileDetail,
                        extra: profile,
                      );
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

// 다이얼로그 띄우는 함수
  void _showMentorProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final double screenWidth = MediaQuery
            .of(context)
            .size
            .width;

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: screenWidth - 20,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '멘토 활동을 시작하려면\n프로필 작성을 완료해주세요',
                      textAlign: TextAlign.left,
                      style: CogoTextStyle.header2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '입력하신 정보는 하단의 MY에서 수정이 가능해요',
                      textAlign: TextAlign.left,
                      style: CogoTextStyle.caption2,
                    ),
                  ),
                  const SizedBox(height: 130),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(Paths.mentorIntroduction);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CogoColor.buttonBackground,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        '멘토 프로필 작성하기',
                        style: CogoTextStyle.buttonText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}