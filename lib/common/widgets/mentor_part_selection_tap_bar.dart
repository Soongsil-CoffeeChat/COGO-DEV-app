import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/home/home_view_model.dart';

class MentorPartSelectionTapBar extends StatelessWidget {
  final TabController tabController;

  const MentorPartSelectionTapBar({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      tabs: const [
        Tab(text: 'FE'),
        Tab(text: 'MOBILE'),
        Tab(text: 'BE'),
        Tab(text: 'PM'),
        Tab(text: 'DESIGN'),
      ],
      onTap: (index) {
        /// 탭을 클릭했을 때 파트별 호출
        Provider.of<HomeViewModel>(context, listen: false).getProfilesForPart(
          context,
          ['FE', 'MOBILE', 'BE', 'PM', 'DESIGN'][index],
        );
      },

      /// 선택된 탭의 텍스트
      labelColor: CogoColor.systemGray05,
      labelStyle: CogoTextStyle.bodySB14,

      /// 선택되지 않은 탭의 텍스트
      unselectedLabelColor: CogoColor.systemGray03,
      unselectedLabelStyle: CogoTextStyle.bodySB14,

      /// 인디케이터 설정
      indicatorSize: TabBarIndicatorSize.label,
      indicator: const BoxDecoration(
        shape: BoxShape.circle,
        color: CogoColor.systemGray05,
      ),
      indicatorPadding: const EdgeInsets.only(bottom: 43.0), // 상단 점의 위치 잡기
    );
  }
}
