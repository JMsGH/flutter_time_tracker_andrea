import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/show_alert_dialog.dart';
import '../../services/auth.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
