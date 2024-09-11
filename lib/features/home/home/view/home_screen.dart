import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/common/widgets/horizontal_button_list.dart';
import 'package:cogo/common/widgets/profile_card.dart';
import 'package:cogo/features/home/home/view_model/home_view_model.dart';
import 'package:cogo/constants/paths.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              children:[
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
      scrolledUnderElevation: 0, // appbar 컬러 오류 해결
      backgroundColor: Colors.white,
      elevation: 0,
      title: SvgPicture.asset(
        'assets/cogo_logo.svg',
        height: 18,
      ),
      centerTitle: false,
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: IconButton(
            icon: SvgPicture.asset('assets/icons/button/search.svg'),
            onPressed: () {
              Provider.of<HomeViewModel>(context, listen: false).onSearchPressed(context);
            },
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
          ),
        ),
        const SizedBox(width: 16),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Column(
          children: [
            HorizontalButtonList(
              buttonTitles: const ['기획', '디자인', 'FE', 'BE'],
              onButtonPressed: (title) {
                Provider.of<HomeViewModel>(context, listen: false).onButtonPressed(title);
              },
            ),
            const SizedBox(height: 10),
            Divider(
              height: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
  

  Widget _buildProfileCardList(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(), // Nested scroll 방지
          shrinkWrap: true, // 리스트 크기 고정
          scrollDirection: Axis.vertical, // 세로로 스크롤
          itemCount: viewModel.profiles.length,
          itemBuilder: (context, index) {
            final profile = viewModel.profiles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // 세로와 양쪽 마진 추가
              child: ProfileCard(
                imagePath: profile['imagePath'],
                name: profile['name'],
                tittle: profile['tittle'],
                description: profile['description'],
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
        );
      },
    );
  }

}
