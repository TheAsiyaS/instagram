import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class Newhomepage extends StatefulWidget {
  const Newhomepage({super.key});

  @override
  State<Newhomepage> createState() => _NewhomepageState();
}

class _NewhomepageState extends State<Newhomepage> {
  bool direction0 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.forward) {
                direction0 = true;
              } else if (direction == ScrollDirection.reverse) {
                direction0 = false;
              }
              return true;
            },
        child: SafeArea(
            child: Stack(
          children: [
             direction0
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
        )),
      ),
    );
  }
}
