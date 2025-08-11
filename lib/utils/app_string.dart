import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApplicationStrings {
  static const String appName = 'CabiBook';
  static const String appDescription = 'Your personal book library';
  static const String welcomeMessage = 'Welcome to CabiBook!';
  static const String errorMessage = 'An error occurred. Please try again.';
  static const String loadingMessage = 'Loading...';
  static const String noBooksFound = 'No books found.';
  static const String addBookButton = 'Add Book';
  static const String searchPlaceholder = 'Search for books...';
  static const String settingsTitle = 'Settings';
  static const String aboutTitle = 'About CabiBook';
  static const String getStarted = 'Get Started';
  static const String continueButton = 'Continue';
  static const String signUpButton = 'Sign Up';
  static const String signInButton = 'Sign In';
  static const String logoutButton = 'Logout';
  static const String otpTitle = 'Phone Verification';
  static const String otpDescription = 'Enter your OTP code here';
  static const String hiNiceToMeetYou = 'Hi, nice to meet you!';
  // ignore: lines_longer_than_80_chars
  static const String allowNotifications = 'Please allow location access so we can show you nearby rides.';
  static const String enableLocation = 'Enable Location Services';
  static const String locationPermissionDenied = 'Location permission denied. Please enable it in settings.';
  static const String permissionRequired = 'Permission Required';
}


class EnvoironmentVar {

  static final  String googleMapApiKey = dotenv.env['GOOGLE_API_KEY']!;

} 
