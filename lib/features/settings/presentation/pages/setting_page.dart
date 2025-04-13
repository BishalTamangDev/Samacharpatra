import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/core/constants/app_constants.dart';
import 'package:samacharpatra/core/functions/app_functions.dart';
import 'package:samacharpatra/features/api_key_setup/presentation/bloc/api_key_bloc.dart';
import 'package:samacharpatra/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:samacharpatra/features/settings/presentation/bloc/setting_bloc.dart';
import 'package:samacharpatra/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:samacharpatra/shared/widgets/custom_alert_dialog_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), elevation: 1),
      body: BlocConsumer<SettingBloc, SettingState>(
        listenWhen: (previous, current) => current is SettingActionState,
        buildWhen: (previous, current) => current is! SettingActionState,
        listener: (context, state) {
          if (state is SettingApiSetupNavActionState) {
            context.read<ApiKeyBloc>().add(ApiKeyFetchEvent());
            context.push('/setting/api-key-setup');
          } else if (state is SettingDeleteSavedArticlesRespActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: state.success ? const Text("Reset Successful.") : const Text("Couldn't reset.")),
            );
            if (state.success) {
              context.read<SavedBloc>().add(SavedFetchEvent());
            }
          }
        },
        builder: (context, state) {
          switch (state) {
            case SettingLoadedState():
              return SingleChildScrollView(
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
                          child: Text(
                            state.apiKey != '' ? state.apiKey : "You haven't set your api key",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      trailing: OutlinedButton(
                        onPressed: () => context.read<SettingBloc>().add(SettingApiSetupEvent()),
                        child: Text(state.apiKey != '' ? "Change Key" : "Set Now"),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                    ),

                    BlocBuilder<ThemeBloc, ThemeState>(
                      buildWhen: (previous, current) => current is! ThemeActionState,
                      builder: (context, state) {
                        switch (state) {
                          case ThemeLoadedState():
                            return Column(
                              children: [
                                // theme source
                                ListTile(
                                  title: Text(
                                    "Theme Source",
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Text(
                                        state.themeSource == ThemeSourceEnum.system
                                            ? "Device theme is active."
                                            : "Custom theme is active",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ),
                                  ),
                                  trailing: DropdownButton(
                                    value: state.themeSource,
                                    underline: const SizedBox.shrink(),
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    items: [
                                      ...ThemeSourceEnum.values.map(
                                        (themeSource) => DropdownMenuItem(
                                          value: themeSource,
                                          child: Text(AppFunctions.getSentenceCase(themeSource.label)),
                                        ),
                                      ),
                                    ],
                                    onChanged:
                                        (newValue) => context.read<ThemeBloc>().add(
                                          ThemeUpdateEvent(themeSource: newValue!, darkMode: state.darkMode),
                                        ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                                ),

                                // theme mode
                                Opacity(
                                  opacity: state.themeSource == ThemeSourceEnum.system ? 0.5 : 1,
                                  child: ListTile(
                                    title: Text(
                                      "Dark Mode",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    trailing: Switch(
                                      value: state.darkMode,
                                      activeColor: Theme.of(context).colorScheme.primary,
                                      onChanged: (newValue) {
                                        if (state.themeSource == ThemeSourceEnum.custom) {
                                          context.read<ThemeBloc>().add(
                                            ThemeUpdateEvent(themeSource: state.themeSource, darkMode: newValue),
                                          );
                                        }
                                      },
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                                  ),
                                ),
                              ],
                            );
                          case ThemeInitial():
                            return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),

                    // reset saved list
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogWidget(
                              title: 'Reset Saved List',
                              description: 'Do you want to delete all the saved articles?',
                              option1: 'Yes',
                              option2: 'No',
                              option1CallBack: () {
                                context.pop();
                                context.read<SettingBloc>().add(SettingDeleteSavedArticlesEvent());
                              },
                              option2CallBack: () => context.pop(),
                            );
                          },
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
                          child: Text(
                            "This will erase all the saved articles.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                    ),
                  ],
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
