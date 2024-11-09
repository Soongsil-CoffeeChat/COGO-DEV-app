import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/common/widgets/components/header.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/home/apply/view_models/memo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemoScreen extends StatelessWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemoViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Header(
                  title: '멘토님께 드릴 메모를 적어보세요',
                  subtitle: 'COGO를 하면서 많은 성장을 기원해요!',
                  onBackButtonPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Consumer<MemoViewModel>(
                  builder: (context, viewModel, child) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: viewModel.controller,
                        maxLength: 200,
                        maxLines: 8,
                        style: CogoTextStyle.body12,
                        decoration: InputDecoration(
                          hintText: '내용을 입력해주세요',
                          hintStyle: CogoTextStyle.body12
                              .copyWith(color: CogoColor.systemGray03),
                          border: InputBorder.none,
                          counterText: '${viewModel.charCount}/200',
                          counterStyle: CogoTextStyle.body12
                              .copyWith(color: CogoColor.systemGray03),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<MemoViewModel>(
                  builder: (context, viewModel, child) {
                    return CustomButton(
                      text: '다음',
                      isSelected: viewModel.charCount > 0,
                      onPressed: viewModel.charCount > 0
                          ? () => viewModel.saveMemo(context)
                          : null,
                      width: double.infinity,
                    );
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
