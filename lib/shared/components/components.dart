import 'package:flutter/material.dart';

AppBar defaultAppBar({
  required BuildContext context,
  String title = 'Add Post',
  List<Widget>? actions,
}) => AppBar(
  titleSpacing: 5.0,
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(Icons.arrow_back_ios),
  ),
  title: Text(title,),
  actions: actions,
);