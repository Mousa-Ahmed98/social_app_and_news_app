import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/shop_app/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10,),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
      ),
    );
  }

  Widget buildCatItem(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20,),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
