import 'package:cogo/common/enums/role.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(
    length: 5,
    vsync: this,
    initialIndex: 0,
  ); // TabController 추가

  @override
  void initState() {
    super.initState();

    // 화면이 로드된 후에 Provider에 접근
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<HomeViewModel>(context, listen: false);

      /// ViewModel의 role과 isIntroductionComplete 값으로 다이얼로그 표시 여부 결정
      if (viewModel.role == Role.MENTOR.name &&
          !viewModel.isIntroductionComplete) {
        _showMentorProfileDialog(context);
      }
    });

    /// TabController 초기화
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // TabController 메모리 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel()..getProfilesForPart(context, 'FE'),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _customAppBar(context),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
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
      title: SvgPicture.asset(
        'assets/cogo_logo.svg',
        height: 18,
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Column(
          children: [
            // CustomTabBar로 변경
            MentorPartSelectionTapBar(tabController: _tabController),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCardList(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final profiles = viewModel.profiles;

        if (profiles == null || profiles.isEmpty) {
          return const Center(child: Text('멘토 정보가 없습니다'));
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
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
                  // role이 mentor이고, 자기소개가 완료되지 않았다면 다이얼로그 띄우기
                  if (viewModel.role == Role.MENTOR.name &&
                      !viewModel.isIntroductionComplete) {
                    _showMentorProfileDialog(context);
                  } else {
                    viewModel.onProfileCardTapped(
                        context, profileCard.mentorId);
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  /// 멘토 프로필 작성 유도 다이얼로그
  void _showMentorProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MentorProfileReminderDialog();
      },
    );
  }
}
