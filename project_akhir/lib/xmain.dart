import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loginregisterlocaldata/homepage.dart';
import 'package:loginregisterlocaldata/login_page.dart';
import 'package:loginregisterlocaldata/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  initiateLocalDB();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool status =  pref.getBool("LoginStatus") ?? false;
  String username = pref.getString("Username") ?? "";
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: status == true ? HomePage(username: username, isLogin: status) : LoginPage(status: false)));
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAccountModelAdapter());
  await Hive.openBox<UserAccountModel>("user");
}