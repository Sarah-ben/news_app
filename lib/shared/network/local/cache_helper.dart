import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences  ;

  static init()async
  {
    sharedPreferences =await SharedPreferences.getInstance();
  }
  
 static Future putData({
  required key,
    required val
})async{
   return await sharedPreferences!.setBool(key,val);
  }

  static  getDAta({
  required key
}){
    return  sharedPreferences!.getBool(key);
}
}