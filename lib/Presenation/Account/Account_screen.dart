import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Account/Edite_profile.dart';
import 'package:instagram_clone/Presenation/Account/Post_page.dart';
import 'package:instagram_clone/Presenation/Account/Tag_page.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: h10,
          title: ValueListenableBuilder(
              valueListenable: username,
              builder: (context, snapshot, _) {
                return Text(
                  username.value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23),
                );
              }),
        ),
        endDrawer: Drawer(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: Icon(kcomment),
                  title: Text('Title'),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: kGrey,
                );
              },
              itemCount: 10),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height / 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              profile,
                            ),
                          ),
                          const Column(
                            children: [
                              Text('000',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              h10,
                              Text('Posts'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                currentuserdata.follower.length.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              h10,
                              const Text('Followers'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(currentuserdata.following.length.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              h10,
                              const Text('Following'),
                            ],
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                          valueListenable: name,
                          builder: (context, snapshot, _) {
                            return Text(
                              name.value,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            );
                          }),
                      SizedBox(
                        height: size.height / 12,
                        width: size.width / 1.4,
                        child: ValueListenableBuilder(
                            valueListenable: bio,
                            builder: (context, snapshot, _) {
                              return Text(
                                bio.value,
                                maxLines: 3,
                                style: const TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width / 2.6,
                      child: Elevated_button(
                          elevatedbutttonwidget: const Text('Edit profile'),
                          elevatedbutttonid: 'editprofile_inaccount',
                          elevatedbuttonstyle: ElevatedButton.styleFrom(
                              backgroundColor: kgreydarktrans)),
                    ),
                    SizedBox(
                      width: size.width / 2.6,
                      child: Elevated_button(
                          elevatedbutttonwidget: const Text('Share profile'),
                          elevatedbutttonid: 'shareprofile_inaccount',
                          elevatedbuttonstyle: ElevatedButton.styleFrom(
                              backgroundColor: kgreydarktrans)),
                    ),
                    Center(
                      child: Elevated_button(
                          elevatedbutttonwidget: const Icon(kaddAccount),
                          elevatedbutttonid: 'addac_inaccount',
                          elevatedbuttonstyle: ElevatedButton.styleFrom(
                              backgroundColor: kgreydarktrans)),
                    ),
                  ],
                ),
                h10,
                const Text(
                  'Story Highlights',
                  style: TextStyle(fontSize: 17),
                ),
                h10,
                const Text(
                  'Keep your favourite stories on your profile',
                ),
                h10,
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kwhite, width: 1.5),
                          ),
                          child: const Icon(
                            kadd,
                            size: 35,
                          ),
                        ),
                        h10,
                        const Text('New')
                      ],
                    ),
                    SizedBox(
                      width: size.width / 1.3,
                      height: size.height / 7,
                      child: GridView.count(
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: 1,
                        children: List.generate(
                          10,
                          (index) => Column(
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg'),
                              ),
                              h10,
                              Text('New$index')
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                TabBar(
                  isScrollable: true,
                  labelColor: kwhite,
                  unselectedLabelColor: kGrey,
                  indicatorColor: kGrey,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
                  tabs: [
                    Tab(
                      child: SizedBox(
                          height: 50,
                          width: size.width / 3,
                          // color: kred,
                          child: const Align(
                              alignment: Alignment.center, child: Icon(kgrid))),
                    ),
                    Tab(
                      child: SizedBox(
                          height: 50,
                          width: size.width / 3,
                          // color: kred,
                          child: const Align(
                              alignment: Alignment.center,
                              child: Icon(kaddAccount))),
                    ),
                  ],
                ),
                SizedBox(
                    height: size.height / 1.5,
                    child: TabBarView(children: [Postpage(), Tagpage()]))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
//bio max 3 