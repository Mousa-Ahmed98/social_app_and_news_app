// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:abdallah_flutter_funds/layouts/social_app/social_layout.dart';
import 'package:abdallah_flutter_funds/modules/social_app/social_login_screen/register/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  static const String route_name = 'social_register_screen';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if(state is SocialCreateUserSuccessState){
            Navigator.pushReplacementNamed(context, SocialLayout.route_name);
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
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'Register now to to see the world',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 40,),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if(emailController.text.isEmpty){
                            return 'Please enter your name';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Name',
                            prefixIcon: Icon(Icons.person)
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if(emailController.text.isEmpty){
                            return 'Please enter your email address';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'E-mail',
                            prefixIcon: Icon(Icons.email_outlined)
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: false,
                        validator: (value) {
                          if(passwordController.text.isEmpty){
                            return 'Please enter your password';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(onPressed: (){
                          }, icon: const Icon(Icons.remove_red_eye)),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if(emailController.text.isEmpty){
                            return 'Please enter your phone number';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Phone',
                            prefixIcon: Icon(Icons.phone)
                        ),
                      ),
                      const SizedBox(height: 25,),
                      ConditionalBuilder(
                        condition: state is SocialRegisterLoadingState,
                        builder: (context) => const Center(child: CircularProgressIndicator(),),
                        fallback: (context) => ElevatedButton(onPressed: (){
                          if(!formKey.currentState!.validate())
                            return;
                         RegisterCubit.get(context).userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                          );
                        }, child: Container(
                            width: double.infinity,
                            height: 50,
                            child: const Center(child: Text('REGISTER')))),
                      ),
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
