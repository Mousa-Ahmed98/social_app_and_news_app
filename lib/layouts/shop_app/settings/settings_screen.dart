import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).userModel != null,
        builder: (context) {
          var model = ShopCubit.get(context).userModel;
          nameController.text = model!.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if (nameController.text.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  validator: (value) {
                    if (nameController.text.isEmpty) {
                      return 'Please enter your email';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'E-mail',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  validator: (value) {
                    if (phoneController.text.isEmpty) {
                      return 'Please enter your phone';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ShopCubit.get(context).updateUserData(
                      email: emailController.text,
                      name: nameController.text,
                      phone: phoneController.text,
                    );
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text('UPDATE'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
