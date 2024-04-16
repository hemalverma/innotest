import 'package:innotest/src/routing/app_router.dart';
import 'package:innotest/src/ui/auth/register/register_page_model.dart';
import 'package:innotest/src/utils/app_button.dart';
import 'package:innotest/src/utils/app_snack_bar.dart';
import 'package:innotest/src/utils/app_text_field.dart';
import 'package:innotest/src/utils/text_style.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';

@RoutePage()
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(
        registerPageModelProvider.select((value) => value.registerStatus),
        (previous, next) {
      if (next != previous) {
        if (next == RegisterStatus.registerSuccess) {
          context.router.replace(const LoginRoute());
          AppSnackBar.showSuccessMessage(context, 'Registered Successfully');
        } else if (next == RegisterStatus.registerError) {
          AppSnackBar.showErrorMessage(
              context,
              ref.read(registerPageModelProvider
                  .select((value) => value.errorMessage ?? 'Error Occurred')));
        }
      }
    });

    final status = ref.watch(
        registerPageModelProvider.select((value) => value.registerStatus));

    final nameError =
        ref.watch(registerPageModelProvider.select((value) => value.nameError));
    final emailError = ref
        .watch(registerPageModelProvider.select((value) => value.emailError));
    final passwordError = ref.watch(
        registerPageModelProvider.select((value) => value.passwordError));
    final confirmPasswordError = ref.watch(registerPageModelProvider
        .select((value) => value.confirmPasswordError));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text(
          'Register',
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            'Create an Account',
                            style: AppTextStyles.title,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Name',
                          style: AppTextStyles.label,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: AppTextField(
                          hint: 'Enter your name',
                          controller: nameController,
                          errorText: nameError &&
                                  status == RegisterStatus.registerError
                              ? ref.read(registerPageModelProvider
                                  .select((value) => value.errorMessage))
                              : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(registerPageModelProvider.notifier)
                                  .setNameError(false);
                            }
                            ref
                                .read(registerPageModelProvider.notifier)
                                .setName(val);
                          },
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          errorText: emailError &&
                                  status == RegisterStatus.registerError
                              ? ref.read(registerPageModelProvider
                                  .select((value) => value.errorMessage))
                              : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(registerPageModelProvider.notifier)
                                  .setEmailError(false);
                            }
                            ref
                                .read(registerPageModelProvider.notifier)
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
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: AppTextField(
                          hint: 'Choose your Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          errorText: passwordError &&
                                  status == RegisterStatus.registerError
                              ? ref.read(registerPageModelProvider
                                  .select((value) => value.errorMessage))
                              : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(registerPageModelProvider.notifier)
                                  .setPasswordError(false);
                            }
                            ref
                                .read(registerPageModelProvider.notifier)
                                .setPassword(val);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Confirm Password',
                          style: AppTextStyles.label,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 20),
                        child: AppTextField(
                          hint: 'Re-enter your Password',
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          errorText: confirmPasswordError &&
                                  status == RegisterStatus.registerError
                              ? ref.read(registerPageModelProvider
                                  .select((value) => value.errorMessage))
                              : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(registerPageModelProvider.notifier)
                                  .setConfirmPasswordError(false);
                            }
                            ref
                                .read(registerPageModelProvider.notifier)
                                .setConfirmPassword(val);
                          },
                        ),
                      ),
                      AppButton(
                        text: 'Signup',
                        radius: 10,
                        isProcessing: ref.watch(registerPageModelProvider
                                .select((value) => value.registerStatus)) ==
                            RegisterStatus.registerProcessing,
                        buttonColor: AppColors.primaryColor,
                        onClicked: () {
                          ref
                              .read(registerPageModelProvider.notifier)
                              .validateAndRegister();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 30,
                  ),
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        context.router.replace(const LoginRoute());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: AppTextStyles.customStyle(
                            size: 16,
                            color: AppColors.darkTextColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
