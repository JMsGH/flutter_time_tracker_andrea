import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_change_notifier.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_stateful.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: // EmailSignInFormStateful(), // setStateを使ったstate管理
                // EmailSignInFormBlocBased.create(context), // BLoCを使う
                EmailSignInFormChangeNotifier.create(
                    context), // ChangeNotifierを使ったstate管理
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
