import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static StorageUtil? _storageUtil;
  static SharedPreferences? _preferences;

  static Future getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  StorageUtil._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences!.getString(key) ?? defValue;
  }

  // put string
  static Future? putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences!.setString(key, value);
  }

  // put Bool
  static Future? putBool(String key, bool value) {
    if (_preferences == null) return null;
    return _preferences!.setBool(key, value);
  }

  // get bool
  static bool getBool(String key,{bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences!.getBool(key) ?? defValue;
  }

  // put Int
  static Future? putInt(String key, int value) {
    if (_preferences == null) return null;
    return _preferences!.setInt(key, value);
  }

  // get int
  static int getInt(String key, {int value = 0}) {
    if (_preferences == null) return value;
    return _preferences!.getInt(key) ?? value;
  }

  // put List<String>
  static Future? putListString(String key, List<String> list) {
    if (_preferences == null) return null;
    return _preferences!.setStringList(key, list);
  }

  // get List<String>
  static List<String> getListString(String key, {List<String> value = const []}) {
    if (_preferences == null) return value;
    return _preferences!.getStringList(key) ?? value;
  }

  static void clearData() {
    if (_preferences != null) _preferences!.clear();
  }

  static void clearSingleData(String key) {
    if (_preferences == null) return;
    _preferences!.remove(key);
  }
}
