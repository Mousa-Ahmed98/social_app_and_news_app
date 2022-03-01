// ignore_for_file: avoid_print

import 'package:abdallah_flutter_funds/layouts/shop_app/register/register_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/social_layout.dart';
import 'package:abdallah_flutter_funds/modules/social_app/social_login_screen/register/register_screen.dart';
import 'package:abdallah_flutter_funds/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialLoginCubit>(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            print(state.error);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              Navigator.pushReplacementNamed(context, SocialLayout.route_name);
            });
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'login now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (emailController.text.isEmpty) {
                            return 'Please enter your email address';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'E-mail',
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: false,
                        validator: (value) {
                          if (passwordController.text.isEmpty) {
                            return 'Please enter your password';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove_red_eye)),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ConditionalBuilder(
                        condition: state is SocialLoginLoadingState,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        fallback: (context) => ElevatedButton(
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                            child: Container(
                                width: double.infinity,
                                height: 50,
                                child: const Center(child: Text('LOGIN')))),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SocialRegisterScreen.route_name);
                              },
                              child: const Text('REGISTER')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
