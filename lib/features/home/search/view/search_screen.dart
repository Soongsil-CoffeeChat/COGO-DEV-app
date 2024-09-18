import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/home/search/view_model/search_view_model.dart';

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Consumer<SearchViewModel>(
                          builder: (context, viewModel, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(color: Colors.black),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      spacing: 5.0,
                                      runSpacing: 5.0,
                                      children: viewModel.selectedTags
                                          .map((tag) => _buildTagChip(context, viewModel, tag)) //tag 함수
                                          .toList(),
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset('assets/icons/button/search.svg'),
                                    onPressed: () {
                                      viewModel.search(viewModel.selectedTags.join(' '));
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // 선택 가능한 태그 버튼들이 있는 섹션
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Consumer<SearchViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          // 파트 선택 버튼
                          const Text(
                            '파트',
                            style: CogoTextStyle.caption2,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                text: 'FE',
                                isSelected: viewModel.isTagSelected('FE'),
                                onPressed: () {
                                  viewModel.toggleTagSelection('FE');
                                },
                              ),
                              const SizedBox(width: 10),
                              CustomButton(
                                text: 'BE',
                                isSelected: viewModel.isTagSelected('BE'),
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
                              CustomButton(
                                text: 'Mobile',
                                isSelected: viewModel.isTagSelected('Mobile'),
                                onPressed: () {
                                  viewModel.toggleTagSelection('Mobile');
                                },
                              ),
                              const SizedBox(width: 10),
                              CustomButton(
                                text: '기획',
                                isSelected: viewModel.isTagSelected('기획'),
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
                              CustomButton(
                                text: '디자인',
                                isSelected: viewModel.isTagSelected('디자인'),
                                onPressed: () {
                                  viewModel.toggleTagSelection('디자인');
                                },
                              ),
                            ],
                          ),
                          // 동아리 선택 버튼
                          const SizedBox(height: 15),
                          const Text(
                            '동아리',
                            style: CogoTextStyle.caption2,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                text: 'GDSC',
                                isSelected: viewModel.isTagSelected('GDSC'),
                                onPressed: () {
                                  viewModel.toggleTagSelection('GDSC');
                                },
                              ),
                              const SizedBox(width: 10),
                              CustomButton(
                                text: 'YOURSSU',
                                isSelected: viewModel.isTagSelected('YOURSSU'),
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
                              CustomButton(
                                text: 'UMC',
                                isSelected: viewModel.isTagSelected('UMC'),
                                onPressed: () {
                                  viewModel.toggleTagSelection('UMC');
                                },
                              ),
                              const SizedBox(width: 10),
                              CustomButton(
                                text: 'LIKELION',
                                isSelected: viewModel.isTagSelected('LIKELION'),
                                onPressed: () {
                                  viewModel.toggleTagSelection('LIKELION');
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 검색창 태그 위젯
  Widget _buildTagChip(BuildContext context, SearchViewModel viewModel, String tag) {
    return Chip(
      label: Text(
        tag,
        style: CogoTextStyle.smallButtonText,
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
