import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MassengerScreen extends StatelessWidget {
  const MassengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://sm.ign.com/t/ign_mear/blogroll/n/naruto-shi/naruto-shippuden-ultimate-ninja-storm-trilogy-and-legacy-rel_rwj9.h720.png'),
            ),
            SizedBox(width: 15,),
            Text('Chats', style: TextStyle(color: Colors.black),),
          ],
        ),
        titleSpacing: 20,
        actions: [
          IconButton(onPressed: () {}, icon: const CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            child: Icon(Icons.camera_alt, size: 16, color: Colors.white,),
          )),
          IconButton(onPressed: () {}, icon: const CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            child: Icon(Icons.edit, size: 16, color: Colors.white,),
          )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300],

                ),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    SizedBox(width: 15,),
                    Text('Search'),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildStory(),
                    separatorBuilder: (context, index) => const SizedBox(width: 15,),
                    itemCount: 10,
                ),
              ),

              const SizedBox(height: 40,),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildChat(),
                  separatorBuilder: (context, index) => const SizedBox(height: 15,),
                  itemCount: 20,
              ),


            ],
          ),
        ),

      ),
    );
  }
  Widget buildStory(){
    return Container(
      width: 70,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: const [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    'https://sm.ign.com/t/ign_mear/blogroll/n/naruto-shi/naruto-shippuden-ultimate-ninja-storm-trilogy-and-legacy-rel_rwj9.h720.png'),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 3,
                  end: 3,
                ),
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4,),
          const Text('Mousa Abd-Elnaby Ahmed Soliman',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  Widget buildChat(){
    return Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: const [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                  'https://sm.ign.com/t/ign_mear/blogroll/n/naruto-shi/naruto-shippuden-ultimate-ninja-storm-trilogy-and-legacy-rel_rwj9.h720.png'),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 3,
                end: 3,
              ),
              child: CircleAvatar(
                radius: 7,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mousa Abd-Elnaby',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Expanded(child: const Text('Hello my name is mousa abdelnaby',maxLines: 1,
                      overflow: TextOverflow.ellipsis)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      width: 7.0,
                      height: 7.0,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const Text('02:32 pm'),


                ],
              )
            ],
          ),
        ),

      ],
    );
  }
}
