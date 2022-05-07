import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'page_list_pokemon.dart';

class HomePage extends StatefulWidget {
  final String username;
  final bool isLogin;

  const HomePage({Key? key, required this.username, required this.isLogin}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _myPref = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.username}"),
        actions: [
          IconButton(
            onPressed: () {
              bool status = false;
              _prosesLogout(status, widget.username);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return LoginPage(status: status);
              }));

            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: PageListPokemon(),
    );
  }

  void _prosesLogout(bool status, String username) async {
    SharedPreferences getPref = await _myPref;
    await getPref.setBool("LoginStatus", status);
    await getPref.setString("Username", username);
  }

}
