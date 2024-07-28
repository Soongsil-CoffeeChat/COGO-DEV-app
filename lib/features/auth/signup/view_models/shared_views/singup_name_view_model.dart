import 'package:flutter/material.dart';
import 'package:cogo/common/db/locale_manager.dart';
import 'package:go_router/go_router.dart';

class SignupNameViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final ValueNotifier<bool> isValidName = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  SignupNameViewModel() {
    nameController.addListener(_validateName);
  }

  @override
  void dispose() {
    nameController.removeListener(_validateName);
    nameController.dispose();
    isValidName.dispose();
    errorMessage.dispose();
    super.dispose();
  }

  Future<void> _validateName() async {
    final name = nameController.text;
    final isValid = name.isNotEmpty;
    isValidName.value = isValid;
    errorMessage.value = isValid ? null : '성함을 입력해주세요';

    await LocaleManager.instance.setStringValue('name', name);
  }

  void onConfirmButtonPressed(BuildContext context) {
    if (isValidName.value) {
      context.push('/agreement/choose');
    }
  }
}
