import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loginregisterlocaldata/model/account_model.dart';
import 'package:loginregisterlocaldata/tools/common_submit_button.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Box<UserAccountModel> localDB = Hive.box<UserAccountModel>("user");

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  String username = "";
  String password = "";
  String password2 = "";

  void _submit() {
    // validate all the form fields
    if (_formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage(status: false,)),
          (_) => false,
      );
      localDB.add(UserAccountModel(username: _usernameController.text, password: _passwordController.text));
      _usernameController.clear();
      _passwordController.clear();
      setState(() {

      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      // body: Form(
      //   key: _formKey,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 30,left: 50, right: 50),
      //       child: Column(
      //         children: [
      //           _buildProfileImage(),
      //           _buildFieldUsername(),
      //           _buildFieldPassword(),
      //           _buildFieldConftirmPassword(),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 30,left: 50, right: 50),
      //             child: _buildButtonRegister(),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //
      // ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
              child: Column(
                children: [
                  _buildProfileImage(),
                  _buildFieldUsername(),
                  _buildFieldPassword(),
                  _buildFieldConftirmPassword(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 50, right: 50),
                    child: _buildButtonRegister(),
                  ),
                ],
              ),
            ),
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

  Widget _buildFieldUsername(){
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

  Widget _buildFieldPassword(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        obscureText: true,
        controller: _passwordController,
        decoration: const InputDecoration(
            hintText: "Password",
            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
        ),
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Password Can\'t be empty';
          }
          if (text.length<8) {
            return 'Your Password is Weak (<8)';
          }
          else {
            return null;
          }
        },
        onChanged: (text) => setState(() => password = text),
      ),
    );
  }

  Widget _buildFieldConftirmPassword(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        obscureText: true,
        controller: _password2Controller,
        decoration: const InputDecoration(
          hintText: "Konfirmasi Password",
          contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
        ),
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Confirmation Password Can\'t be empty';
          }
          if (text.length<8) {
            return 'Your Password is <8 Character';
          }
          if (text != password) {
            return 'Your Password is Wrong';
          }
          else {
            return null;
          }
        },
        onChanged: (text) => setState(() => password2 = text),
      ),
    );
  }

  Widget _buildButtonRegister(){
    return Container(
        height: 65,
        child: CommonSubmitButton(
            labelButton: "Register",
            submitCallback: (value){
              _submit();
            }),
    );
  }
}
