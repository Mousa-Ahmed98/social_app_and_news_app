import 'package:abdallah_flutter_funds/layouts/shop_app/search/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/search/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/search/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  static const route_name = 'search_screen2';
  final GlobalKey fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder:(context, state) => Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: fromKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if(value.toString().isEmpty){
                          return 'Enter search word';
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search on items',
                      ),
                      onFieldSubmitted: (value) => SearchCubit.get(context).search(value.toString()),

                    ),
                  ),
                  const SizedBox(height: 5,),
                  if(state is SearchLoadingState)
                  const LinearProgressIndicator(),
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
                        SearchCubit.get(context).model!.data!.data.length,
                            (index) => buildGridProduct(
                              SearchCubit.get(context).model!.data!.data[index],
                          context,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   Widget buildGridProduct(Product product, context) => Padding(
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
                     //SearchCubit.get(context).changeFavorites(product.id!);
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

}
