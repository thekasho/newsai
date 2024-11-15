import 'package:get_storage/get_storage.dart';

final locale = GetStorage();

class LocaleApi {

  static Future<bool> saveLoginData(Map loginData) async {
    try {
      await locale.remove("login_data");
      await locale.write("login_data", loginData);
      print("Success Save Login Data");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<Map?> getLoginData() async {
    try {
      final users = await locale.read("login_data");

      if (users != null) {
        return users;
      }
      print('login_data null');
      return null;
    } catch (e) {
      print('login_data null $e');
      return null;
    }
  }

  static Future<bool> removeLoginData() async {
    try {
      await locale.remove("login_data");
      print("Success Removed Login Data");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


}