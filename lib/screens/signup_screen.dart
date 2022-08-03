import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:new_life/resources/auth_methods.dart';
import 'package:new_life/screens/login_screen.dart';
import 'package:new_life/utils/colors.dart';
import 'package:new_life/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_life/utils/global_variable.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image,
    );

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebSreenLayout(),
            mobileScreenLayout: MobileScreenLayout()),
      ));
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(res, context);
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          // width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/NewLifeText.svg",
                      //color: Theme.of(context).primaryColor,
                      height: 190,
                    ),
                    // const SizedBox(height: 64),
                    //Circuler widget to accept and show user profile image
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor: Colors.white,
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: AssetImage('assets/person.png'),
                                backgroundColor: Colors.white,
                              ),
                        Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: () => selectImage(),
                              icon: const Icon(Icons.add_a_photo),
                              color: blueColor,
                            ))
                      ],
                    ),
                    const SizedBox(height: 24),
                    //Text field input for username
                    TextFieldInput(
                        textEditingController: _usernameController,
                        hintText: 'Enter Username',
                        textInputType: TextInputType.text),

                    const SizedBox(height: 10),
                    //Text field input for email
                    TextFieldInput(
                        textEditingController: _emailController,
                        hintText: 'Enter Email',
                        textInputType: TextInputType.emailAddress),
                    //Text filed input for password
                    const SizedBox(height: 10),

                    TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: 'Enter Password',
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(height: 10),
                    //Text field input for bio
                    TextFieldInput(
                        textEditingController: _bioController,
                        hintText: 'Enter Organization/Personal Description ',
                        textInputType: TextInputType.text),

                    const SizedBox(height: 10),
                    //Button Login
                    InkWell(
                      onTap: () => signupUser(),
                      child: Container(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : const Text("Sign up"),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
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
                          child: const Text("Already have an account?"),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        GestureDetector(
                          onTap: () => navigateToLogin(),
                          child: Container(
                            child: const Text(
                              " Login.",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
