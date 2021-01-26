import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "./provider_user_profiles.dart";
import '../models/user_profile.dart';

class ProviderCurrentUserProfile extends ChangeNotifier {
  UserProfile _currentUser;
  ProviderUserProfiles providerUserProfiles;

  ProviderCurrentUserProfile(this.providerUserProfiles);

  UserProfile readCurrentLoggedInUserProfile() {
    return _currentUser;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  bool login({String userID, String password}) {
    UserProfile profile = providerUserProfiles.readUserProfile(userID);
    if (profile != null && profile.password == password) {
      _currentUser = profile;
      notifyListeners();
      return true;
    } else
      return false;
  }
}
