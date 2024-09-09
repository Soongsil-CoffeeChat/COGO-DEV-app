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

    // 화면이 로드되면 다이얼로그를 띄움
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showMentorProfileDialog();
    });
  }

  void _showMentorProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // 화면의 전체 너비를 가져옴
        final double screenWidth = MediaQuery.of(context).size.width;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            // 좌우 마진을 10으로 설정
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: screenWidth - 20, // 좌우 마진을 제외한 너비
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  // 텍스트 왼쪽 정렬
                children: [
                  const SizedBox(height: 20),  // 다이얼로그 상단과 첫 번째 텍스트 사이의 마진
                  const Padding(
                    padding: EdgeInsets.only(left: 10),  // 첫 번째 텍스트 왼쪽 마진
                    child: Text(
                      '멘토 활동을 시작하려면\n프로필 작성을 완료해주세요',
                      textAlign: TextAlign.left,
                      style: CogoTextStyle.header2,
                    ),
                  ),
                  const SizedBox(height: 5),  // 두 번째 텍스트와 첫 번째 텍스트 사이의 마진
                  const Padding(
                    padding: EdgeInsets.only(left: 10),  // 두 번째 텍스트 왼쪽 마진
                    child: Text(
                      '입력하신 정보는 하단의 MY에서 수정이 가능해요',
                      textAlign: TextAlign.left,
                      style: CogoTextStyle.caption2,
                    ),
                  ),
                  const SizedBox(height: 130),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),  // 버튼 좌우 마진
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CogoColor.buttonBackground,
                        minimumSize: const Size(double.infinity, 50),  // 버튼 가로 너비를 채움
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
        style: CogoTextStyle.header1,  // CogoTextStyle.header1 사용
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
                    .onButtonPressed(title);
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
          style: CogoTextStyle.header2,  // CogoTextStyle.header2 사용
        ),
        SizedBox(height: 4),
        Text(
          '동아리별 코고 선배 알아보기',
          style: CogoTextStyle.caption2,  // CogoTextStyle.caption2 사용
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
                    context.push(
                      Paths.profileDetail,
                      extra: profile,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
