import 'package:shared_preferences/shared_preferences.dart';
class MealPref{
  static const keypref='meallist';
  static late SharedPreferences _preferences;
  static Future init() async =>_preferences= await SharedPreferences.getInstance();

  List mealprefdata=[];
  String lastopentime="";

  static Future setMeal(meals) async=> await _preferences.setStringList(keypref, meals);
  List<String>? getMeal()=> _preferences.getStringList(keypref);

  static Future setTime(lastopentime) async =>
      await _preferences.setString('lastopentime', lastopentime);
  String? getTime()=> _preferences.getString('lasopentime');

}