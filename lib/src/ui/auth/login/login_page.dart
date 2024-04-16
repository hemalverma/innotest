import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innotest/src/routing/app_router.dart';
import 'package:innotest/src/ui/auth/login/login_page_model.dart';
import 'package:innotest/src/utils/app_button.dart';
import 'package:innotest/src/utils/app_snack_bar.dart';
import 'package:innotest/src/utils/app_text_field.dart';
import 'package:innotest/src/utils/text_style.dart';

import '../../../constants/colors.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<LoginPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ref.listen(loginPageModelProvider.select((value) => value.loginStatus),
        (previous, next) {
      if (next != previous) {
        if (next == LoginStatus.loginFailed) {
          AppSnackBar.showErrorMessage(
              context,
              ref.read(loginPageModelProvider
                  .select((value) => value.errorMessage ?? 'Error Occurred')));
        }
        if (next == LoginStatus.loginSuccess) {
          // context.router.replace(const HomeRoute());
        }
      }
    });

    final status =
        ref.watch(loginPageModelProvider.select((value) => value.loginStatus));
    final emailError =
        ref.watch(loginPageModelProvider.select((value) => value.emailError));
    final passwordError = ref
        .watch(loginPageModelProvider.select((value) => value.passwordError));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text(
          'Login',
          style: AppTextStyles.title,
        ),
        backgroundColor: AppColors.transparent,
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/login.png',
                          height: width * 0.5,
                          width: width * 0.5,
                        ),
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Login',
                            style: AppTextStyles.title,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Email',
                          style: AppTextStyles.label,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: AppTextField(
                          hint: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          errorText:
                              emailError && status == LoginStatus.loginFailed
                                  ? ref.read(loginPageModelProvider
                                      .select((value) => value.errorMessage))
                                  : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(loginPageModelProvider.notifier)
                                  .setEmailError(false);
                            }
                            ref
                                .read(loginPageModelProvider.notifier)
                                .setEmail(val);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Password',
                          style: AppTextStyles.label,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        child: AppTextField(
                          prefixIcon: Icon(Icons.lock),
                          hint: 'Enter your Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          errorText:
                              passwordError && status == LoginStatus.loginFailed
                                  ? ref.read(loginPageModelProvider
                                      .select((value) => value.errorMessage))
                                  : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(loginPageModelProvider.notifier)
                                  .setPasswordError(false);
                            }
                            ref
                                .read(loginPageModelProvider.notifier)
                                .setPassword(val);
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyles.body,
                        ),
                      ),
                      AppButton(
                        text: 'Login',
                        isProcessing: ref.watch(loginPageModelProvider
                                .select((value) => value.loginStatus)) ==
                            LoginStatus.logging,
                        buttonColor: AppColors.primaryColor,
                        radius: 10,
                        onClicked: () {
                          ref
                              .read(loginPageModelProvider.notifier)
                              .validateAndLogin();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 30,
                  ),
                  child: Center(
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          context.router.replace(const RegisterRoute());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: AppTextStyles.customStyle(
                              size: 16,
                              color: AppColors.darkTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
