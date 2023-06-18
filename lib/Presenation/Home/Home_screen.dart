import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Presenation/widget/IconButtons.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ValueNotifier<bool> _direction = ValueNotifier(true);

    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _direction,
          builder: (context, newDierction, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: ((notification) {
                final ScrollDirection direction = notification.direction;
                if (direction == ScrollDirection.forward) {
                  _direction.value = true;
                } else if (direction == ScrollDirection.reverse) {
                  _direction.value = false;
                }
                return true;
              }),
              child: SafeArea(
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                            child: SizedBox(
                          height: size.height / 13,
                        )),
                        SliverToBoxAdapter(
                            child: SizedBox(
                          height: size.height / 6,
                          child: GridView.count(
                            crossAxisCount: 1,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                                10,
                                (index) => const Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              'https://i0.wp.com/blog.apilayer.com/wp-content/uploads/2022/11/pexels-photo-574073.jpeg?resize=1132%2C694&ssl=1'),
                                        ),
                                        Text('Username')
                                      ],
                                    )),
                          ),
                        )),
                        SliverList.separated(
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: size.height / 1.39,
                              //  color: kwhite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: size.height / 2,
                                    width: size.width,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Row(
                                    children: [
                                      Iconbuttons(
                                          icon: const Icon(
                                            kfavorite_outline,
                                            size: 28,
                                          ),
                                          iconId: 'fav_out_in_post',
                                          style: IconButton.styleFrom()),
                                      Iconbuttons(
                                          icon: const Icon(
                                            kcomment,
                                            size: 28,
                                          ),
                                          iconId: 'cmt_out_in_post',
                                          style: IconButton.styleFrom()),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 9),
                                        child: Iconbuttons(
                                            icon: Transform.rotate(
                                              angle: -20 * pi / 180,
                                              child: const Icon(
                                                kshare,
                                                size: 28,
                                              ),
                                            ),
                                            iconId: 'snd_in_post',
                                            style: IconButton.styleFrom()),
                                      ),
                                      const Spacer(),
                                      Iconbuttons(
                                          icon: const Icon(
                                            ksave,
                                            size: 28,
                                          ),
                                          iconId: 'save_out_in_post',
                                          style: IconButton.styleFrom()),
                                    ],
                                  ),
                                  const Text(
                                    ' 1,234 likes',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: const [
                                        TextSpan(
                                          text: 'Username',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        TextSpan(
                                          text:
                                              ' Description when the user added FLUTTER IS A GOOD PROGRAMMING IT IS THE FRMAE WORK OF DART. Mainly used for mobile.',
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    ' View all 23 comments',
                                    style:
                                        TextStyle(color: kGrey, fontSize: 17),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Text(
                                    ' 10 hr ago',
                                    style:
                                        TextStyle(color: kGrey, fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: 10,
                        )
                      ],
                    ),
                    _direction.value
                        ? AnimatedContainer(
                            duration: const Duration(microseconds: 500),
                            color: kblack,
                            child: Row(
                              children: [
                                Text('Instagram',
                                    style: GoogleFonts.grandHotel(
                                      fontSize: 45,
                                    )),
                                const Spacer(),
                                Iconbuttons(
                                    icon: const Icon(
                                      kfavorite_outline,
                                      size: 29,
                                    ),
                                    iconId: 'fav_out_home_appbar',
                                    style: IconButton.styleFrom()),
                                Iconbuttons(
                                    icon: const Icon(
                                      kmessage,
                                      size: 28,
                                    ),
                                    iconId: 'msg_out_home_appbar',
                                    style: IconButton.styleFrom())
                              ],
                            ))
                        : h10,
                  ],
                ),
              ),
            );
          }),
    );
  }
}
