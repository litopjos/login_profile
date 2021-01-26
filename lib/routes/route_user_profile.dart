import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../models/user_profile.dart";
import "../providers/provider_user_profiles.dart";

class RouteUserProfile extends StatefulWidget {
  @override
  _RouteUserProfileState createState() => _RouteUserProfileState();
}

class _RouteUserProfileState extends State<RouteUserProfile> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  String orgUserID;
  UserProfile currentUserProfile;
  bool isAddOperation;

  @override
  void didChangeDependencies() {
    currentUserProfile =
        ModalRoute.of(context).settings.arguments as UserProfile;

    if (currentUserProfile == null) {
      isAddOperation = true;
      currentUserProfile = UserProfile();
      currentUserProfile.name = "";
      currentUserProfile.address = "";
      currentUserProfile.userID = "";
      currentUserProfile.password = "";
    } else {
      orgUserID = currentUserProfile.userID;
      isAddOperation = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ProviderUserProfiles provider = Provider.of<ProviderUserProfiles>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name:",
                  ),
                  initialValue: currentUserProfile.name,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please enter your name";
                    } else
                      return null;
                  },
                  onSaved: (value) => currentUserProfile.name = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Address:",
                  ),
                  initialValue: currentUserProfile.address,
                  maxLines: 5,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please enter your address";
                    } else
                      return null;
                  },
                  onSaved: (value) => currentUserProfile.address = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "UserID:",
                  ),
                  initialValue: currentUserProfile.userID,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please enter your userID";
                    } else
                      return null;
                  },
                  onSaved: (value) => currentUserProfile.userID = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password:",
                  ),
                  initialValue: currentUserProfile.password,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please enter your password";
                    } else if (value.trim().length < 6) {
                      return "Please enter a valid password (ie- > 6 characters).";
                    } else
                      return null;
                  },
                  obscureText: true,
                  onSaved: (value) => currentUserProfile.password = value,
                ),
                isAddOperation
                    ? Container(
                        margin: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          child: Text('Add'),
                          onPressed: () {
                            if (keyForm.currentState.validate()) {
                              keyForm.currentState.save();
                              provider.createUserProfile(currentUserProfile);
                              Navigator.of(context).pop(currentUserProfile);
                            }
                          },
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          child: Text('Edit'),
                          onPressed: () {
                            if (keyForm.currentState.validate()) {
                              keyForm.currentState.save();
                              provider.updateUserProfile(
                                  orgUserID, currentUserProfile);
                              Navigator.of(context).pop(currentUserProfile);
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
