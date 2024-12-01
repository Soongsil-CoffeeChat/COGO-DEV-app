import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/home/search/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.only(bottom: 10.0), // SafeArea 하단 10
          child: Consumer<SearchViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 검색어 입력 및 태그 표시
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(color: Colors.black),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      spacing: 5.0,
                                      runSpacing: 5.0,
                                      children: viewModel.selectedTags
                                          .map((tag) => _buildTagChip(context,
                                              viewModel, tag)) // tag 함수
                                          .toList(),
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                        'assets/icons/button/search.svg'),
                                    onPressed: () {
                                      // 검색 버튼 클릭 시 검색 실행
                                      if (viewModel.selectedTags.isEmpty) {
                                        viewModel
                                            .clearSearch(); // 태그가 없으면 검색 초기화
                                      } else {
                                        viewModel.search(
                                            viewModel.selectedTags.join(' '));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 선택된 태그가 없으면 버튼들 표시
                    if (!viewModel.hasSearched) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              '파트',
                              style: CogoTextStyle.body12
                                  .copyWith(color: CogoColor.systemGray03),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BasicButton(
                                  text: 'FE',
                                  isClickable: viewModel.isTagSelected('FE'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('FE');
                                  },
                                ),
                                const SizedBox(width: 10),
                                BasicButton(
                                  text: 'BE',
                                  isClickable: viewModel.isTagSelected('BE'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('BE');
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BasicButton(
                                  text: 'Mobile',
                                  isClickable:
                                      viewModel.isTagSelected('Mobile'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('Mobile');
                                  },
                                ),
                                const SizedBox(width: 10),
                                BasicButton(
                                  text: '기획',
                                  isClickable: viewModel.isTagSelected('기획'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('기획');
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BasicButton(
                                  text: '디자인',
                                  isClickable: viewModel.isTagSelected('디자인'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('디자인');
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              '동아리',
                              style: CogoTextStyle.body12
                                  .copyWith(color: CogoColor.systemGray03),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BasicButton(
                                  text: 'GDSC',
                                  isClickable: viewModel.isTagSelected('GDSC'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('GDSC');
                                  },
                                ),
                                const SizedBox(width: 10),
                                BasicButton(
                                  text: 'YOURSSU',
                                  isClickable:
                                      viewModel.isTagSelected('YOURSSU'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('YOURSSU');
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BasicButton(
                                  text: 'UMC',
                                  isClickable: viewModel.isTagSelected('UMC'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('UMC');
                                  },
                                ),
                                const SizedBox(width: 10),
                                BasicButton(
                                  text: 'LIKELION',
                                  isClickable:
                                      viewModel.isTagSelected('LIKELION'),
                                  onPressed: () {
                                    viewModel.toggleTagSelection('LIKELION');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    // 검색 결과가 있으면 프로필 카드를 표시하고, 버튼들을 없앰
                    if (viewModel.hasSearched &&
                        viewModel.selectedTags.isNotEmpty)
                      Container(
                        height: MediaQuery.of(context).size.height *
                            0.7, // 화면의 70% 차지
                        child: viewModel.searchResults.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                itemCount: viewModel.searchResults.length,
                                itemBuilder: (context, index) {
                                  final profile =
                                      viewModel.searchResults[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                  );
                                },
                              )
                            : const Center(child: Text('검색 결과가 없습니다.')),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // 검색창 태그 위젯
  Widget _buildTagChip(
      BuildContext context, SearchViewModel viewModel, String tag) {
    return Chip(
      label: Text(
        tag,
        style: CogoTextStyle.body12.copyWith(color: CogoColor.white50),
      ),
      backgroundColor: Colors.black,
      deleteIconColor: Colors.white,
      deleteIcon: SvgPicture.asset('assets/icons/button/glyph.svg'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onDeleted: () {
        viewModel.toggleTagSelection(tag);
      },
    );
  }
}
