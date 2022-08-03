import 'package:flutter/material.dart';
import 'package:new_life/resources/auth_methods.dart';
import 'package:new_life/screens/signup_screen.dart';
import 'package:new_life/utils/colors.dart';
import 'package:new_life/utils/global_variables.dart';
import 'package:new_life/utils/utils.dart';
import 'package:new_life/widgets/text_field_input.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      //Move to homescreen
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebSreenLayout(),
                mobileScreenLayout: MobileScreenLayout()),
          ),
          (route) => false);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignUpScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),

              isDarkMode
                  ? Image(
                      image: AssetImage("assets/NewLifeLogoDark.gif"),
                      height: 350,
                    )
                  : Image(
                      image: AssetImage("assets/NewLifeLogo.gif"),
                      height: 350,
                    ),
              const SizedBox(height: 5),
              //Text filed input for email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter email',
                  textInputType: TextInputType.emailAddress),
              //Text filed input for password
              const SizedBox(height: 24),

              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24),
              //Button Login
              InkWell(
                onTap: () => loginUser(),
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(fontFamily: 'Nutino'),
                        ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      color: Colors.blue.withOpacity(0.5)),
                ),
              ),
              const SizedBox(height: 12),
              // Flexible(child: Container(), flex: 2),
              //Transitioning to Signing Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(fontFamily: 'Nutino'),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => navigateToSignup(),
                    child: Container(
                      child: const Text(
                        " Sign up.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Nutino'),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      )),
    );
  }
}
