import 'package:cogo/features/auth/signup/agreement/terms_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  _AgreementScreenState createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAgreementModal(context);
    });
  }

  void _showAgreementModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const TermsBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
