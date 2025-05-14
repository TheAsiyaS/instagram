import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/SignUp/ProfileImage.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:instagram_clone/utenslis/styles.dart';

class AddFacebookFreinds extends StatelessWidget {
  const AddFacebookFreinds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            const TwoIcons(
              baseIcon: Icons.circle_outlined,
              frondIcon: Icons.person_add,
              left: 100,
              right: 100,
            ),
            const Text('Find Facebook friends to Follow'),
            const Text(
              'You choose who to follow ,and we\'ll never post to facebook without your permission',
              style: TextStyle(color: kGrey),
            ),
            sizedBoxHeight50,
            Elevated_button(
                elevatedbutttonwidget: const Text('Find Firends'),
                elevatedbutttonid: '',
                elevatedbuttonstyle: elevatedbuttonstyle),
            sizedBoxHeight20,
            const Text(
              '----and 20 other friends using Instagram',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            sizedBoxHeight20,
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const addProfilePic()));
                },
                child: Text(
                  'Skip',
                  style: textstyleBlue,
                )),
            Flexible(
              flex: 4,
              child: Container(),
            ),
          ],
        ),
      )),
    );
  }
}

class TwoIcons extends StatelessWidget {
  const TwoIcons({
    Key? key,
    required this.baseIcon,
    required this.frondIcon,
    this.left,
    this.right,
    this.top,
    this.bottom,
  }) : super(key: key);
  final IconData baseIcon;
  final IconData frondIcon;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: top ?? 0,
          bottom: bottom ?? 0,
          left: left ?? 0,
          right: right ?? 0,
          child: Icon(
            frondIcon,
            size: 50,
          )),
      Center(
          child: Icon(
        baseIcon,
        size: 150,
      ))
    ]);
  }
}
