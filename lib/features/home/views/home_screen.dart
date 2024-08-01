// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/horizontal_button_list.dart';
import 'package:cogo/common/widgets/profile_card.dart';
import 'package:cogo/features/home/view_models/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _customAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding( padding: const EdgeInsets.all(20.0),
                child: _text(),
              ),
              const SizedBox(height: 20),
              _buildProfileCardList(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'COGO',
        style: TextStyle(
          fontFamily: 'PretendardMedium',
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: IconButton(
            icon: SvgPicture.asset('assets/icons/button/search.svg'),
            onPressed: () {
              Provider.of<HomeViewModel>(context, listen: false).onSearchPressed();
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
                Provider.of<HomeViewModel>(context, listen: false).onButtonPressed(title);
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
          style: TextStyle(
            fontFamily: 'PretendardMedium',
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '동아리별 코고 선배 알아보기',
          style: TextStyle(
            fontFamily: 'PretendardMedium',
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCardList() {
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
                child: ProfileCard(
                  imagePath: profile['imagePath'],
                  name: profile['name'],
                  clubName: profile['clubName'],
                  tags: profile['tags'],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
