import 'package:abdallah_flutter_funds/layouts/shop_app/login/shop_login_screen.dart';
import 'package:flutter/material.dart';
class OnBoarding{
  final String image;
  final String title;
  final String body;

  OnBoarding(this.image, this.title, this.body);
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller = PageController();

  final List<OnBoarding> boarding = [
    OnBoarding(
        'assets/images/on1.jpg',
        'On Board 1 Title',
        'On Board 1 Title'
    ),
    OnBoarding(
        'assets/images/on2.jpg',
        'On Board 2 Title',
        'On Board 2 Title'
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  if(value == 1){
                    isLast = true;
                  }
                  else{
                    isLast = false;
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                const Text('Indicator'),
                const Spacer(),
                FloatingActionButton(
                  mini: true,
                  onPressed: (){
                    if(isLast){
                      Navigator.pushReplacementNamed(context, ShopLoginScreen.route_name);
                    }
                    controller.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoarding model){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),

          ),
        ),
        const SizedBox(height: 15,),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15,),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
