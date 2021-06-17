import 'package:flutter/material.dart';
import 'package:sirbanks_driver/screen/Dashboard/contactus/contact_us.dart';
import 'package:sirbanks_driver/screen/Dashboard/dashboard.dart';
import 'package:sirbanks_driver/screen/Dashboard/history/history_screen.dart';
import 'package:sirbanks_driver/screen/Dashboard/invite/invite_friend.dart';
import 'package:sirbanks_driver/screen/Dashboard/language/language_screen.dart';
import 'package:sirbanks_driver/screen/Dashboard/notification/notification.dart';
import 'package:sirbanks_driver/screen/Dashboard/profile/profile_screen.dart';
import 'package:sirbanks_driver/screen/Dashboard/review/review_screen.dart';
import 'package:sirbanks_driver/screen/Dashboard/settings/settings.dart';
import 'package:sirbanks_driver/screen/Dashboard/termandcondiction/termandcondiction.dart';
import 'package:sirbanks_driver/screen/Dashboard/wallet/wallet_screen.dart';
import 'package:sirbanks_driver/screen/authentication.dart/login.dart';
import 'package:sirbanks_driver/screen/authentication.dart/signup.dart';
import 'package:sirbanks_driver/screen/walkthrough/walkthough.dart';
import 'package:sirbanks_driver/splashscreen.dart';

import 'constants.dart';
import 'screen/authentication.dart/enable_location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sirbanks Driver',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          kSplashscreen: (ctx) => SplashScreen(),
          kWalkthrough: (ctx) => WalkThrough(),
          KEnableLocationScreen: (ctx) => EnableLocationScreen(),
          kSignupScreen: (ctx) => SignupScreen(),
          kLoginScreen: (ctx) => LoginScreen(),
          kDashboard: (ctx) => DashboardScreen(),
          KWalletScreen: (ctx) => WalletScreen(),
          KHistoryScreen: (ctx) => HistoryScreen(),
          KNotificationScreen: (ctx) => NotificationScreen(),
          KSettingScreen: (ctx) => SettingScreen(),
          KProfileScreen: (ctx) => ProfileScreen(),
          KReviewScreen: (ctx) => ReviewScreen(),
          KLanguageScreen: (ctx) => LanguageScreen(),
          KTermandCondition: (ctx) => TermandCondition(),
          KContactUs: (ctx) => ContactUs(),
          KInviteFriendScreen: (ctx) => InviteFriendScreen(),
        }
    );
  }
}
