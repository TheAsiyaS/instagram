import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Presenation/Home/postcard.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class Homescreenwidget extends StatelessWidget {
  Homescreenwidget({super.key});

  final ValueNotifier<bool> scrolldirection = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: scrolldirection,
          builder: (context, newvalue, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.forward) {
                  // Scroll down

                  scrolldirection.value = true;
                } else if (notification.direction == ScrollDirection.reverse) {
                  // Scroll up

                  scrolldirection.value = false;
                }
                return false; // or false, depending on if you want the notification to continue upwards
              },
              child: SafeArea(
                child: Stack(
                  children: [
                    Homepostcard(),
                    scrolldirection.value
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
          }),
    );
  }
}
