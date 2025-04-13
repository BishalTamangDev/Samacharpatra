import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/features/api_key_setup/presentation/bloc/api_key_bloc.dart';
import 'package:samacharpatra/features/api_key_setup/presentation/widgets/api_key_error_widget.dart';
import 'package:samacharpatra/features/home/presentation/bloc/home_bloc.dart';
import 'package:samacharpatra/features/search/presentation/bloc/search_bloc.dart';
import 'package:samacharpatra/features/settings/presentation/bloc/setting_bloc.dart';
import 'package:samacharpatra/shared/widgets/custom_alert_dialog_single_option_widget.dart';
import 'package:samacharpatra/shared/widgets/custom_alert_dialog_widget.dart';
import 'package:samacharpatra/shared/widgets/custom_snackbar_widget.dart';

class ApiKeySetupPage extends StatefulWidget {
  const ApiKeySetupPage({super.key});

  @override
  State<ApiKeySetupPage> createState() => _ApiKeySetupPageState();
}

class _ApiKeySetupPageState extends State<ApiKeySetupPage> {
  // variables
  bool _updating = false;
  final apiKeyController = TextEditingController();

  // functions
  // check api key
  void _add(String oldApiKey, String newApiKey) {
    if (!mounted) return;
    FocusScope.of(context).unfocus();

    // setting api key in process
    if (_updating) return;

    // empty api key
    if (newApiKey == '') {
      showCustomSnackbar(context: context, message: "Please enter the API key first.");
    } else {
      if (oldApiKey != '' && oldApiKey == newApiKey) {
        showCustomSnackbar(context: context, message: "Please enter different API key.");
        return;
      }
      setState(() {
        _updating = true;
      });
      context.read<ApiKeyBloc>().add(ApiKeySetEvent(apiKeyController.text));
    }
  }

  // delete api key
  void _deleteApiKey() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialogWidget(
          title: 'Delete API key',
          description: "You won't be able to use the features.",
          option1: 'Yes',
          option2: 'No',
          option1CallBack: () {
            context.read<ApiKeyBloc>().add(ApiKeyDeleteEvent());
            setState(() {
              _updating = true;
            });
            context.pop();
          },
          option2CallBack: () => context.pop(),
        );
      },
    );
  }

  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiKeyBloc, ApiKeyState>(
      listenWhen: (previous, current) => current is ApiKeyActionState,
      buildWhen: (previous, current) => current is! ApiKeyActionState,
      listener: (context, state) {
        if (state is ApiKeySetResActionState) {
          if (!mounted) return;
          setState(() {
            _updating = false;
          });
          if (state.response) {
            apiKeyController.clear();
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialogSingleOptionWidget(
                  title: "API key added!",
                  description: "Feel free to explore article.",
                  option: 'Okay',
                  callBack: () => context.pop(),
                );
              },
            );
            context.read<ApiKeyBloc>().add(ApiKeyFetchEvent());
            context.read<SettingBloc>().add(SettingFetchEvent());
            context.read<HomeBloc>().add(HomeFetchEvent());
            context.read<SearchBloc>().add(SearchResetEvent());
          } else {
            showCustomSnackbar(context: context, message: state.message);
          }
          // debugPrint("${state.response} || ${state.message}");
        } else if (state is ApiKeyDeleteResActionState) {
          if (!mounted) return;
          setState(() {
            _updating = false;
          });
          showCustomSnackbar(
            context: context,
            message: state.response ? "API key deleted successfully." : "API key couldn't be deleted.",
          );
          if (state.response) {
            // refresh pages
            context.read<ApiKeyBloc>().add(ApiKeyFetchEvent());
            context.read<HomeBloc>().add(HomeFetchEvent());
            context.read<SearchBloc>().add(SearchResetEvent());
            context.read<SettingBloc>().add(SettingFetchEvent());
          }
        }
      },
      builder: (context, state) {
        switch (state) {
          case ApiKeyErrorState():
            return const ApiKeyErrorWidget();
          case ApiKeyLoadedState():
            return Scaffold(
              appBar: AppBar(title: const Text("API Key Setup")),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 20.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // initial api key
                      state.initialApiKey == ''
                          ? Opacity(
                            opacity: 0.9,
                            child: Text(
                              "You haven't set your API key.",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red),
                            ),
                          )
                          : Row(
                            children: [
                              Expanded(
                                child: Opacity(
                                  opacity: 0.6,
                                  child: Text(
                                    "Your API key\n${state.initialApiKey}",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.4),
                                  ),
                                ),
                              ),
                              OutlinedButton(onPressed: _deleteApiKey, child: const Text("Delete")),
                            ],
                          ),

                      // api key field
                      TextField(
                        controller: apiKeyController,
                        decoration: InputDecoration(
                          hintText: 'Enter your api key',
                          contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          suffixIcon: IconButton(
                            onPressed:
                                () => setState(() {
                                  apiKeyController.text = "";
                                }),
                            icon: const Icon(Icons.close),
                          ),
                        ),
                      ),

                      // progress indicator
                      Visibility(
                        visible: _updating,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: Column(
                              spacing: 16.0,
                              children: [CircularProgressIndicator(), Opacity(opacity: 0.6, child: Text("Processing"))],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16.0,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // note
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(text: "Don't have API key? Get it from "),
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.blue),
                            text: "newsapi.org",
                          ),
                        ],
                      ),
                    ),

                    // set button
                    SizedBox(
                      height: 45.0,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ElevatedButton(
                          onPressed: () => _add(state.initialApiKey, apiKeyController.text),
                          child: state.initialApiKey == '' ? const Text("Add Key") : const Text('Update Key'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
