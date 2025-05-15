import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class Homescreenwidget extends StatefulWidget {
  const Homescreenwidget({super.key});

  @override
  State<Homescreenwidget> createState() => _HomescreenwidgetState();
}

class _HomescreenwidgetState extends State<Homescreenwidget> {
  bool scrolldirection = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            // Scroll down
            setState(() {
              scrolldirection = true;
            });
          } else if (notification.direction == ScrollDirection.reverse) {
            // Scroll up
            setState(() {
              scrolldirection = false;
            });
          }
          return true; // or false, depending on if you want the notification to continue upwards
        },
        child: Stack(
          children: [
            ListView.builder(itemBuilder: (context, index) {}),
            scrolldirection
                ? AnimatedContainer(
                    duration: const Duration(microseconds: 500),
                    color: kBlack,
                    child: Row(
                      children: [
                        Text(
                          'Instagram',
                          style: GoogleFonts.grandHotel(
                            fontSize: 45,
                          ),
                        ),
                        const Spacer(),
                        Iconbuttons(
                          icon: const Icon(
                            kfavorite_outline,
                            size: 29,
                          ),
                          iconId: 'fav_out_home_appbar',
                          style: IconButton.styleFrom(),
                        ),
                        Iconbuttons(
                          icon: const Icon(
                            kmessage,
                            size: 28,
                          ),
                          iconId: 'msg_out_home_appbar',
                          style: IconButton.styleFrom(),
                        ),
                      ],
                    ),
                  )
                : sizedBoxHeight10,
          ],
        ),
      ),
    );
  }
}
