import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/models/shop_app/categories_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null  &&  ShopCubit.get(context).categoriesModel != null,
          builder: (context) =>
              productsBuilder(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!, context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map((e) => Image(
                      image: NetworkImage(e.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollDirection: Axis.horizontal),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(width: 10,),
                      itemCount: categoriesModel.data.data.length,
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'New products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.70,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.products.length,
                (index) => buildGridProduct(
                  model.data!.products[index],
                  context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel product, context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(product.image!),
                  width: double.infinity,
                  height: 200,
                ),
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              product.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.3,
              ),
            ),
            Row(
              children: [
                Text(
                  product.price.round()!.toString(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  product.price.round()!.toString(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 15,
                  //backgroundColor: ShopCubit.get(context).favourites[product.id]?? Colors.blue,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(product.id!);
                      },
                      icon: const Icon(
                        Icons.favorite_outline,
                        size: 16.0,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ],
        ),
      );
  Widget buildCategoryItem(DataModel model) => SizedBox(
    width: 100,
    height: 100,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: double.infinity,
          child: Text(
            model.name,
            style: const TextStyle(
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
