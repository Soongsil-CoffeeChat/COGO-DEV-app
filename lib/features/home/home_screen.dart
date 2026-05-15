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
  int _lastSelectedIndex = -1;

  void _onViewModelChanged() {
    if (viewModel.showReportSuccessDialog) {
      viewModel.clearReportSuccess();
      viewModel.refreshHome();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => OneButtonDialog(
            title: "신고가 완료되었습니다",
            subtitle: "유저 차단이 완료되었습니다.\n신고 내역에 따라 해당 유저에게 안내가 이루어질 예정입니다.",
            imagePath: "assets/icons/3d_img/caution.png",
            buttonText: "확인",
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      });
    }

    if (viewModel.showEventDialog) {
      viewModel.clearEventDialog();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => OneButtonDialog(
            title: "멘토에게 코고 커피챗 신청하고,\n무료 커피 받아가요!",
            subtitle:
                "코고 신청 후 생성된 코고 메세지 > ‘+‘ 버튼 > 커피쿠폰 발급 받기에서 받아보실 수 있습니다.\n*준비된 소량이 소진될 경우, 이벤트가 조기 마감될 수 있습니다.",
            imagePath: "assets/image/coffee_img.png",
            buttonText: "멘토 프로필 둘러보기",
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        length: Interest.values.length + 1, vsync: this, initialIndex: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      viewModel = Provider.of<HomeViewModel>(context, listen: false);
      viewModel.addListener(_onViewModelChanged);

      // 뷰모델 초기화 완료될떄까지 기다림
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
              Future.microtask(() => context.safePush(Paths.mentorIntroduction));
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
          final part = _tabController.index == 0
              ? HomeViewModel.allParts
              : Interest.values[_tabController.index - 1].name;
          viewModel.getProfilesForPart(part);
        }
      });

      /// 인덱스 0번(전체)일 때만 refreshHome 호출
      _tabController.addListener(() {
        if (_tabController.index == 0 && _lastSelectedIndex != 0) {
          _lastSelectedIndex = 0;
          final viewModel = Provider.of<HomeViewModel>(context, listen: false);
          viewModel.refreshHome();
        } else if (_tabController.index != 0) {
          _lastSelectedIndex = -1;
        }
      });

      // 기본 프로필 로드 (전체 탭)
      viewModel.getProfilesForPart(HomeViewModel.allParts);
    });
  }

  /// TabController 메모리 해제
  @override
  void dispose() {
    viewModel.removeListener(_onViewModelChanged);
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
    final tabLabels = ['전체', ...Interest.values.map((i) => i.name)];
    return TabBar(
      controller: _tabController,
      isScrollable: false,
      tabs: tabLabels
          .map((label) => Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(label),
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
              Interest.values.length + 1,
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
          return RefreshIndicator(
            onRefresh: () => viewModel.refreshHome(),
            color: Colors.black,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(
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
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => viewModel.refreshHome(),
          color: Colors.black,
          child: ListView.builder(
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
          ),
        );
      },
    );
  }
}
