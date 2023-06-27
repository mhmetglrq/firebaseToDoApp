import 'package:flutter/material.dart';
import 'package:flutter_new_projects/features/auth_page/controller/auth_controller.dart';
import 'package:flutter_new_projects/router/app_route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/colors.dart';
import '../../../common/sizes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/logo.dart';
import '../../widgets/main_gradient.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: MainGradient(
          child: SafeArea(
            child: Padding(
              padding: scaffoldPadding,
              child: Column(
                children: [
                  const Spacer(),
                  const Logo(),
                  const Spacer(),
                  CustomTextFieldWidget(
                    controller: _fullNameController,
                    hintText: "Adınızı Giriniz!",
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                  CustomTextFieldWidget(
                    controller: _emailController,
                    hintText: "E-Postanızı Giriniz!",
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                  CustomTextFieldWidget(
                    controller: _passwordController,
                    hintText: "Şifrenizi Giriniz!",
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                  ),
                  const Spacer(),
                  Consumer(
                    builder: (context, ref, child) {
                      return CustomButton(
                        text: "Kayıt Ol",
                        onPressed: () async {
                          await ref
                              .watch(authControllerProvider)
                              .signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  _fullNameController.text)
                              .then(
                                (value) => Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRouteName.signIn,
                                    (route) => false),
                              );
                        },
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Giriş Yap",
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
