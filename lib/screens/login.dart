import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../components/bottom_navbar.dart';
import '../screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider_android/messages.g.dart';
import '../utils/app_colors.dart';
import '../utils/toast.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'dart:async';
import '../services/api.dart';
import '../utils/constant.dart';
import '../screens/register.dart';
import '../components/circle_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  var _isDisable = false;
  encriptPassword(String password) {
    if (password.isNotEmpty) {
      var bytes1 = utf8.encode(password);
      return sha256.convert(bytes1).toString();
    }
    return null;
  }

  login() async {
    Timer.run(() {
      CircleLoader.showCustomDialog(context);
    });
    setState(() {
      _isDisable = true;
    });
    var data = {
      "email": emailController.text,
      "password": encriptPassword(passwordContoller.text)
    };
    print(data);
    APIManager()
        .postRequest(Constant.domain + "/api/Account/Login", data)
        .then((res) async {
      print(res);
      setState(() {
        _isDisable = false;
      });
      CircleLoader.hideLoader(context);
      if (res["isSucess"]) {
        //need to save user id here
        MyToast.showSuccess("Login success");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userid", res["results"]["id"]);
        prefs.setString("email", res["results"]["email"]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => BottomTabBar()));
      } else {
        MyToast.showError("Login Failed!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 100,
                      child: Image.asset('assets/images/flutterwave.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    controller: passwordContoller,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter password'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText: "Password should be atleast 6 characters"),
                      MaxLengthValidator(15,
                          errorText:
                              "Password should not be greater than 15 characters")
                    ])
                    //validatePassword,        //Function to check validation
                    ),
              ),
              // FlatButton(
              //   onPressed: () {
              //     //TODO FORGOT PASSWORD SCREEN GOES HERE
              //   },
              //   child: Text(
              //     'Forgot Password',
              //     style: TextStyle(color: Colors.blue, fontSize: 15),
              //   ),
              // ),
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(top: 15.0),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: SignInButton(
                  isDisable: _isDisable,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      print("Validated");
                      login();
                    } else {
                      print("Not Validated");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text('Do not have an account? Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isDisable;

  const SignInButton(
      {Key? key, required this.onPressed, required this.isDisable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Rounded corners

          color: AppColors.contentColorDarkBlue),
      child: ElevatedButton(
        onPressed: isDisable ? null : onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent, // Transparent background
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // To keep the children close together
          children: [
            Text(
              'Sign In',
              style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ), // Arrow icon
          ],
        ),
      ),
    );
  }
}
