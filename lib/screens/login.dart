import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/bottom_navbar.dart';
import '../components/custom_textbox.dart';
import '../utils/app_colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.contentColorYellow, AppColors.contentColorBlue],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.roboto(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: AppColors.contentColorDarkBlue),
                    ),
                    Text(
                      'Please sign in to continue..',
                      style: GoogleFonts.roboto(
                          fontSize: 15, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                icon: Icons.email,
                label: "E-mail",
                obscureText: false,
              ),
              CustomTextField(
                icon: Icons.lock,
                label: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 60),
                  child: LoginButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomTabBar()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Rounded corners

          color: AppColors.contentColorDarkBlue),
      child: ElevatedButton(
        onPressed: onPressed,
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
              'Login',
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
