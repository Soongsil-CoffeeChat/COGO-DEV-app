import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/features/home/home/view_model/home_view_model.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/common/widgets/widgets.dart';

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
        return const MentorProfileDialog();
      },
    );
  }
}