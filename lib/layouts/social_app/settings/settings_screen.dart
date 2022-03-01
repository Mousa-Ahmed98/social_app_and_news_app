import 'package:abdallah_flutter_funds/layouts/social_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/cubit/states.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              model!.cover!),
                        ),),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            '${model.image}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(model.name!),
            Text(
              model.bio!,
              style: Theme.of(context).textTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        const Text('Posts'),
                        Text(
                          '128',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        const Text('Photos'),
                        Text(
                          '21',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        const Text('Followers'),
                        Text(
                          '10k',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        const Text('Followings'),
                        Text(
                          '14',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
              ]),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: (){},
                    child: const Text('Add Photos'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, EditProfile.route_name);
                  },
                  child: const Icon(Icons.edit,
                  size: 16,),
                ),
              ],
            ),
          ],
        ),
      );
      },
    );
  }
}
