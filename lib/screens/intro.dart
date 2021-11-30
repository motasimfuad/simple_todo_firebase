import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:simple_todo_firebase/screens/home_page.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      showNextButton: true,
      showDoneButton: true,
      showSkipButton: false,
      done: Text('Done'),
      onDone: () {
        Get.to(() => HomePage());
      },
      next: Icon(Icons.arrow_forward),
      pages: [
        PageViewModel(
          image: SvgPicture.asset('assets/svg-1.svg'),
          title: 'Easy to use',
          body:
              'How to convert a EPS to a SVG file? Choose the EPS file you want to convert. Change quality or size (optional). Click on "Start conversion" to convert your',
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top: 50),
            descriptionPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
        PageViewModel(
          image: SvgPicture.asset('assets/svg-2.svg'),
          title: 'Achieve your goals',
          body:
              'How to convert a EPS to a SVG file?. Choose the EPS file you want to convert · Change quality or size (optional) · Click on "Start conversion" to convert your',
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top: 50),
            descriptionPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ],
    );
  }
}
