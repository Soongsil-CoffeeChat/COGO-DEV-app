import 'package:cogo/features/home/report/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("신고하기"),
        ),
      ),
    );
  }
}
