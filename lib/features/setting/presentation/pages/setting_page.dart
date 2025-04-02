import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/shared/widgets/custom_alert_dialog_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // variables
  bool _darkMode = true;
  String themeMode = 'device';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // user api key
            ListTile(
              title: Text(
                "API Key",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Opacity(
                  opacity: 0.6,
                  child: Text('GHDS456SDADSA67GYH', style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              trailing: OutlinedButton(onPressed: () {}, child: const Text("Set Now")),
              contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
            ),

            // theme
            ListTile(
              title: Text("Theme", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),

              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Opacity(
                  opacity: 0.6,
                  child: Text(
                    themeMode == 'device' ? "Device theme is active." : 'System theme is active.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              trailing: DropdownButton(
                value: themeMode,
                underline: SizedBox.shrink(),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                items: [
                  DropdownMenuItem(value: 'device', child: const Text('Device')),
                  DropdownMenuItem(value: 'custom', child: const Text('Custom')),
                ],
                onChanged:
                    (newValue) => setState(() {
                      themeMode = newValue!;
                    }),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
            ),

            // dark mode
            ListTile(
              title: Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Opacity(
                  opacity: 0.6,
                  child: Text("Custom theme is set to dark mode.", style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              trailing: Switch(
                value: _darkMode,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged:
                    (newValue) => setState(() {
                      _darkMode = newValue;
                    }),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
            ),

            // reset saved list
            ListTile(
              onTap: () {
                debugPrint("Reset Saved List");
                showDialog(
                  context: context,
                  builder:
                      (context) => CustomAlertDialogWidget(
                        title: 'Reset Saved List',
                        description: 'Do you want to delete all the saved articles?',
                        option1: 'Yes',
                        option2: 'No',
                        option1CallBack: () => debugPrint("Delete Article"),
                        option2CallBack: () => context.pop(),
                      ),
                );
              },
              title: Text(
                "Reset Saved List",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Opacity(
                  opacity: 0.6,
                  child: Text("This will erase all the saved articles.", style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
