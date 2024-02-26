import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../components/bottom_navbar.dart';
import '../screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/toast.dart';
import 'dart:async';
import '../services/api.dart';
import '../utils/constant.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isEqual(String str1, String str2) {
    return str1 == (str2);
  }

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  var _isDisable = false;
  encriptPassword(String password) {
    if (password.isNotEmpty) {
      var bytes1 = utf8.encode(password);
      return sha256.convert(bytes1).toString();
    }
    return null;
  }

  registerNewUser() async {
    setState(() {
      _isDisable = true;
    });
    var data = {
      "name": fullnameController.text,
      "email": emailController.text,
      "mobileNo": mobileController.text,
      "password": encriptPassword(password.text)
    };
    print(data);
    APIManager()
        .postRequest(Constant.domain + "/api/Account/Register", data)
        .then((res) {
      setState(() {
        _isDisable = false;
      });
      print(res);
      if (res["isSucess"]) {
        MyToast.showSuccess(
            "The User successfully saved. please login with credentials");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        MyToast.showError("Failed to register user!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Create Account"),
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
                      child: Image.asset('assets/images/nutrition-plan.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    controller: fullnameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                        hintText: 'Enter Full Name'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    controller: mobileController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: 'Mobile No',
                        hintText: 'Enter Mobile No'),
                    keyboardType: TextInputType.phone,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
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
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText: "Password should be atleast 6 characters"),
                      MaxLengthValidator(15,
                          errorText:
                              "Password should not be greater than 15 characters"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  obscureText: true,
                  controller: confirmpassword,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      labelText: 'Re Enter password',
                      hintText: 'Re Enter password'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please re-enter password';
                    }
                    if (password.text != confirmpassword.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
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
                child: SignUpButton(
                  isDisable: _isDisable,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      registerNewUser();
                      //Navigator.push(context,
                      //  MaterialPageRoute(builder: (_) => BottomTabBar()));
                    } else {}
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
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text('Already have an account ? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isDisable;

  const SignUpButton(
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
              'Sign Up',
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
