import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/shared/widgets/custom_alert_dialog_single_option_widget.dart';

class ApiKeySetupPage extends StatefulWidget {
  const ApiKeySetupPage({super.key});

  @override
  State<ApiKeySetupPage> createState() => _ApiKeySetupPageState();
}

class _ApiKeySetupPageState extends State<ApiKeySetupPage> {
  // functions
  // check api key
  void _proceed() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialogSingleOptionWidget(
          title: 'Invalid Key',
          description: 'The provided api key is not valid. Please enter another key and try again.',
          option: 'Okay',
          callBack: () => context.pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Key Setup")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // api key field
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your api key',
                  contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                ),
              ),

              // submit button
              SizedBox(
                height: 45.0,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ElevatedButton(onPressed: _proceed, child: const Text("Check Key")),
                ),
              ),

              // note
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Opacity(opacity: 0.7, child: Text("Enter the API key you got from newsapi.org.")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
