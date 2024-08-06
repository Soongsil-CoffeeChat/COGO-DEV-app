import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/vertical_profile_card.dart';
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
                            onChanged: (text) {
                              // This is optional if you want to perform live search as the user types
                            },
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
                            child: ProfileCard(
                              imagePath: profile['imagePath'],
                              name: profile['name'],
                              clubName: profile['clubName'],
                              tags: profile['tags'],
                              description: profile['description'],
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
