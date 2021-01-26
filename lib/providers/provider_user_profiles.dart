import "package:flutter/material.dart";

import '../models/user_profile.dart';

class ProviderUserProfiles extends ChangeNotifier {
  Map<String, UserProfile> mapCurrentUsers = {};

  void createUserProfile(UserProfile profile) {
    mapCurrentUsers[profile.userID] = profile;
    return;
  }

  UserProfile readUserProfile(String userID) {
    return mapCurrentUsers[userID];
  }

  UserProfile updateUserProfile(String userID, UserProfile profile) {
    mapCurrentUsers.remove(userID);
    mapCurrentUsers[profile.userID] = profile;

    return profile;
  }
}
