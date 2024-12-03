import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<String> parts = ['FE', 'MOBILE', 'BE', 'PM', 'DESIGN'];
  late TabController _tabController;
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();

    /// 컨트롤러 초기화
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);

    /// 초기 데이터 로드 (첫번째 탭인 FE 호출)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<HomeViewModel>(context, listen: false);
      viewModel.getProfilesForPart(context, 'FE');
    });

    /// 인덱스가 변화할때마다 api 재호출
    int previousIndex = _tabController.index;
    _tabController.addListener(() {
      if (_tabController.index != previousIndex) {
        previousIndex = _tabController.index;
        final viewModel = Provider.of<HomeViewModel>(context, listen: false);
        final part =
            ['FE', 'MOBILE', 'BE', 'PM', 'DESIGN'][_tabController.index];
        viewModel.getProfilesForPart(context, part);
      }
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
      tabs: parts
          .map((part) => Tab(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(part),
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
              5,
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
                  'assets/icons/3d_img/3d_empty.png',
                  height: 130,
                ),
                const SizedBox(height: 20),
                const Text(
                  '멘토 정보가 없습니다',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
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