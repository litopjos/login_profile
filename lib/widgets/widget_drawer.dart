import "package:flutter/material.dart";
import 'package:login/global.dart';
import "package:provider/provider.dart";

import 'package:login/widgets/widget_loginlogout.dart';
import "../providers/provider_current_user_profile.dart";
import "../models/user_profile.dart";

class WidgetDrawer extends StatelessWidget {
  WidgetDrawer();

  @override
  Widget build(BuildContext context) {
    ProviderCurrentUserProfile provider =
        Provider.of<ProviderCurrentUserProfile>(context, listen: false);

    UserProfile currentUser = provider.readCurrentLoggedInUserProfile();

    return Container(
      child: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.supervisor_account),
                title: Text("User Profile"),
                enabled: currentUser != null,
                onTap: () async {
                  var profile = await Navigator.of(context)
                      .pushNamed(ROUTE_USER_PROFILE, arguments: currentUser);
                  if (profile != null) {
                    UserProfile userProfile = profile as UserProfile;
                    provider.login(
                        userID: userProfile.userID,
                        password: userProfile.password);
                  }
                  Navigator.of(context).pop();
                },
              ),
              currentUser != null
                  ? ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                      onTap: () {
                        provider.logout();
                        Navigator.of(context).pop();
                      },
                    )
                  : ListTile(
                      leading: Icon(Icons.login),
                      title: Text("Login"),
                      onTap: () async {
                        await showLoginDialog(context: context);
                        Navigator.of(context).pop();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
