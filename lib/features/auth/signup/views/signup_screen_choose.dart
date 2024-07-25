import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/views_model/signup_choose_view_model.dart';
import 'package:cogo/common/widgets/custom_appbar.dart';

class SignupScreenChoose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupChooseViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SignupChooseViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '거의 다 되었습니다!',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'PretendardMedium',
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '멘토로 가입하실지, 멘티로 가입하실지 알려주세요',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PretendardMedium',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildRoleButton(context, '멘토', viewModel),
                            SizedBox(width: 10),
                            _buildRoleButton(context, '멘티', viewModel),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(
      BuildContext context, String role, SignupChooseViewModel viewModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              viewModel.selectRole(role, context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: viewModel.selectedRole == role
                  ? Colors.black
                  : Colors.grey[300],
              foregroundColor:
              viewModel.selectedRole == role ? Colors.white : Colors.black,
              textStyle: const TextStyle(
                fontFamily: 'PretendardMedium',
                fontSize: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(role),
          ),
        ),
      ),
    );
  }
}
