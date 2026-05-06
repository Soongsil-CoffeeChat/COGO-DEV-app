import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/mypage/notification/notification_settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen>
    with WidgetsBindingObserver {
  late final NotificationSettingsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = NotificationSettingsViewModel();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _viewModel.refreshNotificationStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Header(
                  title: "알림 설정",
                  subtitle: "",
                  onBackButtonPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Consumer<NotificationSettingsViewModel>(
                builder: (context, viewModel, _) {
                  return Column(
                    children: [
                      ListTile(
                          title:
                              const Text('푸시 알림', style: CogoTextStyle.body16),
                          trailing: SizedBox(
                            height: 40,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Switch(
                                value: viewModel.isNotificationEnabled,
                                onChanged: viewModel.setNotificationEnabled,
                                thumbColor: WidgetStateProperty.resolveWith(
                                  (states) =>
                                      states.contains(WidgetState.selected)
                                          ? Colors.white
                                          : Colors.black,
                                ),
                                trackColor: WidgetStateProperty.resolveWith(
                                  (states) =>
                                      states.contains(WidgetState.selected)
                                          ? Colors.black
                                          : Colors.white,
                                ),
                                trackOutlineColor:
                                    WidgetStateProperty.resolveWith(
                                  (states) =>
                                      states.contains(WidgetState.selected)
                                          ? Colors.transparent
                                          : Colors.black,
                                ),
                                trackOutlineWidth:
                                    const WidgetStatePropertyAll(1.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
