import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/view_models/shared_views/agreement_view_model.dart';

class CheckBoxRow extends StatelessWidget {
  final int index;
  final String title;
  final String mandatoryText;

  CheckBoxRow({
    required this.index,
    required this.title,
    required this.mandatoryText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AgreementViewModel>(
      builder: (context, viewModel, child) => Row(
        children: [
          Checkbox(
            value: viewModel.isChecked[index],
            onChanged: (value) {
              viewModel.updateCheckState(index, value!);
            },
            activeColor: Colors.black,
            checkColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontFamily: 'PretendardRegular',
                      fontSize: 12,
                      color: Colors.black, // 기본 색상
                    ),
                  ),
                  TextSpan(
                    text: mandatoryText,
                    style: const TextStyle(
                      fontFamily: 'PretendardRegular',
                      fontSize: 12,
                      color: Color(0xFF808080),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
