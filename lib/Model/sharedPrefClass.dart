import 'package:shared_preferences/shared_preferences.dart';



class UserSharedprefs{
  static SharedPreferences? _prefs;
  static const _keyname= '_username';
  static const _keyadminid = '_adminid';


  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  static Future setName(String username) async{
    await _prefs?.setString(_keyname, username);
  }
  static String? getName(){
    return _prefs?.getString(_keyname);
  }


  static Future setAdminId(String username) async{
    await _prefs?.setString(_keyadminid, username);
  }
  static String? getAdminId(){
    return _prefs?.getString(_keyadminid);
  }


  // static Future setVechicleList(List<String> list) async{
  //   await _prefs?.setStringList(_keylist, list);
  // }
  // static List<String>? getVechicleList() => _prefs?.getStringList(_keylist);


}