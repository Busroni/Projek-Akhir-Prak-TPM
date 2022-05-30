import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loginregisterlocaldata/register_page.dart';
import 'package:loginregisterlocaldata/tools/common_submit_button.dart';
import 'homepage.dart';
import 'model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final bool status;
  const LoginPage({Key? key, required this.status}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late Box<UserAccountModel> localDB = Hive.box<UserAccountModel>("user");
  final Future<SharedPreferences> _myPref = SharedPreferences.getInstance();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String username = "";
  String password = "";

  late bool isLogin = widget.status;

  void _submit() {
    // validate all the form fields
    if (_formKey.currentState!.validate()) {
      String currentUsername = _usernameController.value.text;
      String currentPassword = _passwordController.value.text;

      _prosesLogin(currentUsername, currentPassword);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed:(){
            Navigator.pop(context);
          }
        ),
        title: const Text("Login Page"),
      ),
      body: Form(
        key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                _buildProfileImage(),
                _buildFieldUsername(),
                _buildFieldPassword(),

                Padding(
                  padding: const EdgeInsets.only(top: 30,left: 50, right: 50),
                  child: Column(
                    children: [
                      _buildButtonLogin(),
                      _buildButtonRegister(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildProfileImage() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: Image.network(
          "https://archive.org/services/img/PokemonIcon",
          height: 250,
        ),
      ),
    );
  }
  
  Widget _buildFieldUsername() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
          controller: _usernameController,
          decoration: const InputDecoration(
            hintText: "Username",
              contentPadding: const EdgeInsets.symmetric(horizontal: 25.0)
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Username Can\'t be empty';
            } else {
              return null;
            }
          },
          onChanged: (text) => setState(() => username = text),
      ),
    );
  }

  Widget _buildFieldPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: "Password",
                contentPadding: const EdgeInsets.symmetric(horizontal: 25.0)
            ),
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Password Can\'t be empty';
              } else {
                return null;
              }
            },
            onChanged: (text) => setState(() => password = text),
          ),
    );
  }

  Widget _buildButtonLogin() {
    return Container(
        height: 65,
          child: CommonSubmitButton(
              labelButton: "Login",
              submitCallback: (value) {
                _submit();
              }),
    );
  }

  Widget _buildButtonRegister() {
    return Container(
      height: 65,
        child: CommonSubmitButton(
            labelButton: "Register",
            submitCallback: (value) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            }),
    );
  }

  void _prosesLogin(String username, String password) async {
    for (int index = 0; index < localDB.length; index++){
    if (username == localDB.getAt(index)!.username && password == localDB.getAt(index)!.password) {
      isLogin = true;
      SharedPreferences getPref = await _myPref;
      await getPref.setBool("LoginStatus", isLogin);
      await getPref.setString("Username", username);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        return HomePage(username: username, isLogin: isLogin,);
      }),
          (_)=> false);
      // SharedPreferences getPref = await _myPref;
      // await getPref.setBool("LoginStatus", true);

    }
    }
  }

}
