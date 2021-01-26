import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import 'routes/route_user_profile.dart';
import "./models/user_profile.dart";
import 'widgets/widget_drawer.dart';
import './providers/provider_user_profiles.dart';
import './providers/provider_current_user_profile.dart';
import "global.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProviderUserProfiles()),
        ChangeNotifierProxyProvider<ProviderUserProfiles,
            ProviderCurrentUserProfile>(
          create: (ctx) => ProviderCurrentUserProfile(null),
          update: (context, userProfiles, currentUser) =>
              ProviderCurrentUserProfile(userProfiles),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          ROUTE_USER_PROFILE: (_) => RouteUserProfile(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false;
  String userID, password;

  @override
  Widget build(BuildContext context) {
    // This will cause the automatic rebuild of this widget after a login/logout.
    ProviderCurrentUserProfile provider =
        Provider.of<ProviderCurrentUserProfile>(context, listen: true);

    UserProfile currentUser = provider.readCurrentLoggedInUserProfile();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login / Profile App"),
      ),
      body: Container(
        child: Center(
          child: currentUser != null
              ? Text("Hey, ${currentUser.userID}!",
                  style: TextStyle(fontSize: 40))
              : Text("Please Login", style: TextStyle(fontSize: 30)),
        ),
      ),
      drawer: WidgetDrawer(),
    );
  }
}
