import 'package:shared_preferences/shared_preferences.dart';
// singelton
abstract class PreferencesService {
  static  SharedPreferences ? prefs;

static bool checkUserLoggedIn() {
    return prefs?.getBool('isLogin') ?? false;
    // if not null => true , else => false
  }
}