import 'package:ody_flutter_app/data/data_source/local/SharedKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAppApi {
  LocalAppApi();

  final String appUsePolicyKey = SharedKeyHelper.fromString(SharedKey.APP_USE_POLICY);

  Future<bool> hasAgreedToPolicy() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(appUsePolicyKey) ?? false;
  }

  Future<void> setHasAgreedToPolicy(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(appUsePolicyKey, value);
  }
}