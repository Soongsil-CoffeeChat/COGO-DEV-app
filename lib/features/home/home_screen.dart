import 'dart:developer';

import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/enums/interest.dart'; // Interest import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();

    /// 컨트롤러 초기화
    _tabController = TabController(
        length: Interest.values.length, vsync: this, initialIndex: 0);

    /// 초기 데이터 로드 (첫번째 탭인 FE 호출)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<HomeViewModel>(context, listen: false);

      // ViewModel 초기화 완료될 때까지 기다림
      while (!viewModel.isInitialized) {
        await Future.delayed(Duration(milliseconds: 50));
      }

      // 자기소개 안 했으면 다이얼로그 띄우기
      if (viewModel.shouldShowDialog) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => OneButtonDialog(
            title: "멘토 활동을 시작하려면\n프로필 작성을 완료해주세요",
            subtitle: "입력하신 정보는 하단의 MY에서 수정이 가능해요",
            imagePath: "assets/icons/3d_img/heart.png",
            buttonText: "멘토 프로필 작성하기",
            onPressed: () {
              Navigator.of(context).pop();
              Future.microtask(() => context.push(Paths.mentorIntroduction));
            },
          ),
        );
      }

      /// 인덱스가 변화할때마다 api 재호출
      int previousIndex = _tabController.index;
      _tabController.addListener(() {
        if (_tabController.index != previousIndex) {
          previousIndex = _tabController.index;
          final viewModel = Provider.of<HomeViewModel>(context, listen: false);
          final part = Interest.values[_tabController.index].name;
          viewModel.getProfilesForPart(part);
        }
      });

      // 기본 프로필 로드
      viewModel.getProfilesForPart(Interest.FE.name);
    });
  }

  /// TabController 메모리 해제
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _customAppBar(context),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              _buildTabBarView(context),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _customAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      title: SvgPicture.asset(
        'assets/cogo_logo.svg',
        height: 18,
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: SizedBox(
          height: AppBar().preferredSize.height,
          width: Size.infinite.width,
          child: Align(alignment: Alignment.centerLeft, child: _buildTabBar()),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: false,
      tabs: Interest.values
          .map((interest) => Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(interest.name),
                ),
              ))
          .toList(),

      /// 선택된 탭의 텍스트
      labelColor: CogoColor.systemGray05,
      labelStyle: CogoTextStyle.bodySB14,

      /// 선택되지 않은 탭의 텍스트
      unselectedLabelColor: CogoColor.systemGray03,
      unselectedLabelStyle: CogoTextStyle.bodySB14,

      /// 인디케이터 설정
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const BoxDecoration(
        shape: BoxShape.circle,
        color: CogoColor.systemGray05,
      ),
      indicatorPadding: const EdgeInsets.only(bottom: 43.0), // 상단 점의 위치 잡기
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return Expanded(
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return TabBarView(
            controller: _tabController,
            children: List.generate(
              Interest.values.length,
              (index) => _buildProfileCardList(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCardList(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final profiles = viewModel.profiles;

        if (profiles == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (profiles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/3d_img/empty.png',
                  height: 150,
                ),
                const SizedBox(height: 20),
                Text('등록된 코고 멘토가 없어요',
                    style: CogoTextStyle.body14
                        .copyWith(color: CogoColor.systemGray03)),
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            final profileCard = profiles[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ProfileCard(
                picture: profileCard.picture,
                mentorName: profileCard.mentorName,
                tags: profileCard.tags,
                username: profileCard.username,
                mentorId: profileCard.mentorId,
                title: profileCard.title,
                description: profileCard.description,
                onTap: () {
                  viewModel.onProfileCardTapped(context, profileCard.mentorId);
                },
              ),
            );
          },
        );
      },
    );
  }
}
