import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cogo/common/widgets/horizontal_button_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _customAppBar(context),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your other widgets here
          ],
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
              // TODO : 검색창 페이지로 넘기기
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
                print('Button pressed: $title');
                // TODO : 버튼 액션 구현
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
}
