import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:ecommerce_app/views/widgets/social_media_button.dart';
import 'package:ecommerce_app/views/widgets/text_field_widget.dart';
import 'package:ecommerce_app/views_models/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 50),
            Text(
              'Login Account',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Please, login with registered account!',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 24),
            LabelWithTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the email';
                } else {
                  return null;
                }
              },
              label: 'Email',
              controller: emailController,
              prefixIcon: Icons.email,
              hint: 'Enter you Email',
            ),
            const SizedBox(height: 24),
            LabelWithTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the password';
                } else {
                  return null;
                }
              },
              label: 'Password',
              controller: passwordController,
              prefixIcon: Icons.lock_outline,
              hint: 'Enter you password',
              // TODO: Make this visibility works well
              // obsecureText: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {},
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text('Forgot Password?')),
            ),
            const SizedBox(height: 40),
            BlocConsumer<AuthCubit, AuthState>(
              bloc: cubit,
              listenWhen: (previous, current) =>
                  current is AuthDone || current is AuthError,
              listener: (context, state) {
                if (state is AuthDone) {
                  Navigator.of(context).pushNamed(AppRoute.homeRoute);
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMassage),
                  ));
                }
              },
              buildWhen: (previous, current) =>
                  current is AuthLoading ||
                  current is AuthError ||
                  current is AuthDone,
              builder: (context, state) {
                if (state is AuthLoading) {
                  MainButton(
                    isLoading: true,
                    onTap: null,
                  );
                }
                return MainButton(
                  text: 'Login ',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await cubit.loginWithEmailandPassword(
                          emailController.text, passwordController.text);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoute.registerRoute);
                            },
                            child:
                                const Text('Don\'t have an account? Register')),
                        const SizedBox(height: 10),
                        Text(
                          'Or using other method',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen: (previous, current) =>
                              current is GoogleAuthDone,
                          listener: (context, state) {
                            if (state is GoogleAuthDone) {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamedAndRemoveUntil(
                                      AppRoute.homeRoute, (route) => false);
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is GoogleAuthenticating ||
                              current is GoogleAuthError || current is GoogleAuthDone,
                          builder: (context, state) {
                            if (state is GoogleAuthenticating) {
                              SocialMediaButton(
                                isLoading: true,
                              );
                            }
                            return SocialMediaButton(
                              text: 'Login in with Google',
                              imgUrl: 'assets/images/icons8-google-96.png',
                              onTap: () async {
                                await cubit.authenticateWithGoogle();
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SocialMediaButton(
                          text: 'Login in with Facebook',
                          imgUrl: 'assets/images/icons8-facebook-96.png',
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    )));
  }
}
