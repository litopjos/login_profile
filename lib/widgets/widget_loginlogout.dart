import "package:flutter/material.dart";
import "package:provider/provider.dart";

import 'package:login/global.dart';
import 'package:login/providers/provider_current_user_profile.dart';
import "../models/user_profile.dart";

Future<void> showLoginDialog(
    {@required BuildContext context, String userID, String password}) async {
  return await showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        content: WidgetLoginLogout(),
      );
    },
  );
}

class WidgetLoginLogout extends StatefulWidget {
  WidgetLoginLogout();

  @override
  _WidgetLoginLogoutState createState() => _WidgetLoginLogoutState();
}

class _WidgetLoginLogoutState extends State<WidgetLoginLogout> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  String userID = "";
  String password = "";

  UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: keyForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              child: Text("Sign Up"),
              onPressed: () async {
                var profile =
                    await Navigator.of(context).pushNamed(ROUTE_USER_PROFILE);
                UserProfile userProfile = profile as UserProfile;
                if (userProfile != null) {
                  setState(() {
                    userID = userProfile.userID;
                    password = userProfile.password;
                  });
                }
              },
            ),
            TextFormField(
              key:
                  UniqueKey(), // <- Necessary to get it to mind initialValue on a setState()
              decoration: InputDecoration(
                labelText: "UserID:",
              ),
              initialValue: userID,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please enter your userID";
                } else
                  return null;
              },
              onSaved: (value) => userID = value,
            ),
            TextFormField(
              key:
                  UniqueKey(), // <- Necessary to get it to mind initialValue on a setState()
              decoration: InputDecoration(
                labelText: "Password:",
              ),
              initialValue: password,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Please enter your password";
                } else if (value.trim().length < 6) {
                  return "Please enter a valid password (ie- > 6 characters).";
                } else
                  return null;
              },
              obscureText: true,
              onSaved: (value) => password = value,
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () async {
                if (keyForm.currentState.validate()) {
                  keyForm.currentState.save();

                  ProviderCurrentUserProfile provider =
                      Provider.of<ProviderCurrentUserProfile>(context,
                          listen: false);

                  if (provider.login(userID: userID, password: password)) {
                    Navigator.of(context).pop();
                  } else {
                    await showAlertDialog(
                        context, "Login FAILED: invalid UserID / Password");
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
