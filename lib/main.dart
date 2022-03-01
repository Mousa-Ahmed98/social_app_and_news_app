import 'package:abdallah_flutter_funds/cubit/cubit_provider.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/cubit/cubit.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/login/shop_login_screen.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/register/register_screen.dart';
import 'package:abdallah_flutter_funds/layouts/shop_app/search/search_screen.dart' as shopApp;
import 'package:abdallah_flutter_funds/layouts/shop_app/shop_layout.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/chat_details/chat_details_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/edit_profile/edit_profile.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/new_post/new_post_screen.dart';
import 'package:abdallah_flutter_funds/layouts/social_app/social_layout.dart';
import 'package:abdallah_flutter_funds/models/social_app/message_model.dart';
import 'package:abdallah_flutter_funds/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:abdallah_flutter_funds/shared/network/local/cache_helper.dart';
import 'package:abdallah_flutter_funds/shared/network/remote/dio_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/constants.dart';
import 'layouts/social_app/cubit/cubit.dart';
import 'modules/news_app/science/search/search_screen.dart';
import 'modules/social_app/social_login_screen/register/register_screen.dart';
import 'shared/styles/themes.dart';
Future<void> onBackGroundHandler(RemoteMessage message) async{
  print('on backGround ${message.data.toString()}');
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData('token').toString();
  Widget widget;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey('uId')) {
    uId = prefs.getString('uId')!;
    print('uid $uId');
    widget = const SocialLayout();
  }
  else{
    widget = SocialLoginScreen();

  }

  var userToken = await FirebaseMessaging.instance.getToken();
  print('user token $userToken');
  //the app is already opened
  FirebaseMessaging.onMessage.listen((event) {

    print('app is opened ${event.data.toString()}');
  });

  //the app is not opened
  //this function detects that user has clicked the notification
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('app on background ${event.data.toString()}');
  });

  FirebaseMessaging.onBackgroundMessage(onBackGroundHandler);
  runApp( MyApp(
    screen: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.screen}) : super(key: key);
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterCubit()),
        //BlocProvider(create: (context) => ShopCubit()..getData()..getCategories()),
        BlocProvider(create: (context) => ShopCubit()),
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          //themeMode: CounterCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
          home:  Directionality(
                textDirection: TextDirection.ltr,
                child: SafeArea(
                  child: screen,
                ),
              ),
          routes: {
             SearchScreen.route_name : (context) =>  const SearchScreen(),
             shopApp.SearchScreen.route_name : (context) => shopApp.SearchScreen(),
             ShopLoginScreen.route_name : (context) =>  ShopLoginScreen(),
             ShopLayout.route_name : (context) =>  const ShopLayout(),
             RegisterScreen.route_name : (context) =>   RegisterScreen(),
             SocialRegisterScreen.route_name : (context) =>   SocialRegisterScreen(),
             SocialLayout.route_name : (context) =>   const SocialLayout(),
             NewPostScreen.route_name : (context) =>   const NewPostScreen(),
             EditProfile.route_name : (context) =>    EditProfile(),
          },
          ),
    );
  }

}

