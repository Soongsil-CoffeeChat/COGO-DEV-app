import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/common/widgets/widgets.dart'; // Assuming this has `VerticalProfileCard`
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
          scrolledUnderElevation: 0, // appbar 컬러 오류 해결
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Consumer<SearchViewModel>(
                        builder: (context, viewModel, child) {
                          return TextField(
                            controller: viewModel.searchController,
                            readOnly: true, // 검색창은 사용자가 직접 입력하지 않음
                            decoration: InputDecoration(
                              hintText: '동아리, 분야, 학과로 검색하기',
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                              suffixIcon: IconButton(
                                icon: SvgPicture.asset('assets/icons/button/search.svg'),
                                onPressed: () {
                                  viewModel.search(viewModel.searchController.text);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Button Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Consumer<SearchViewModel>(
                  builder: (context, viewModel, child) {
                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        CustomButton(
                          text: '기획',
                          isSelected: viewModel.selectedTags.contains('기획'),
                          onPressed: () {
                            viewModel.addTagToSearch('기획');
                          },
                        ),
                        CustomButton(
                          text: '디자인',
                          isSelected: viewModel.selectedTags.contains('디자인'),
                          onPressed: () {
                            viewModel.addTagToSearch('디자인');
                          },
                        ),
                        CustomButton(
                          text: 'FE',
                          isSelected: viewModel.selectedTags.contains('FE'),
                          onPressed: () {
                            viewModel.addTagToSearch('FE');
                          },
                        ),
                        CustomButton(
                          text: 'BE',
                          isSelected: viewModel.selectedTags.contains('BE'),
                          onPressed: () {
                            viewModel.addTagToSearch('BE');
                          },
                        ),
                        // Add more buttons as needed
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer<SearchViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.searchResults.isEmpty) {
                      return const Center(
                        child: Text('검색 결과가 없습니다.'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: viewModel.searchResults.length,
                        itemBuilder: (context, index) {
                          final profile = viewModel.searchResults[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: VerticalProfileCard(
                              imagePath: profile['imagePath'],
                              name: profile['name'],
                              clubName: profile['clubName'],
                              tags: profile['tags'],
                              description: profile['description'],
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
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
