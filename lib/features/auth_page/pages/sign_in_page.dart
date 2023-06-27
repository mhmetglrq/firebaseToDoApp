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

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainGradient(
        child: SafeArea(
          child: Padding(
            padding: scaffoldPadding,
            child: Column(
              children: [
                const Spacer(),
                const Logo(),
                const Spacer(),
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
                      text: "Giriş Yap",
                      onPressed: () async {
                        await ref
                            .watch(authControllerProvider)
                            .signIn(
                                _emailController.text, _passwordController.text)
                            .then(
                              (value) => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRouteName.homePage,
                                  (route) => false),
                            );
                      },
                    );
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouteName.signUp,
                  ),
                  child: const Text(
                    "Kayıt Ol",
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
    );
  }
}
