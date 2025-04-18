import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Presenation/Account/DrawerScreens/SavedPosts.dart';
import 'package:instagram_clone/Presenation/Account/Others_account.dart';
import 'package:instagram_clone/Presenation/Account/Post_page.dart';
import 'package:instagram_clone/Presenation/Account/Tag_page.dart';
import 'package:instagram_clone/Presenation/widget/Elevatedbutton.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';
import 'package:instagram_clone/utenslis/variables.dart';

ValueNotifier<String> name = ValueNotifier(currentuserdata!.name );
ValueNotifier<String> editeusername = ValueNotifier(currentuserdata!.username);
ValueNotifier<String> newusername = ValueNotifier(currentuserdata!.username);
ValueNotifier<String> bio = ValueNotifier(currentuserdata!.bio);
ValueNotifier<String> newname = ValueNotifier(currentuserdata!.name );
ValueNotifier<String> newbio = ValueNotifier(currentuserdata!.bio);
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Drawertitle = [
      'Settings',
      'Privacy',
      'Your activity',
      'Archive',
      'QR code',
      'Saved',
      'Closed friends',
      'Favourites',
      'Sign out'
    ];
    final Drawericons = [
      Icons.settings,
      Icons.security,
      Icons.history_toggle_off_rounded,
      Icons.history,
      Icons.qr_code_scanner_sharp,
      ksave,
      Icons.menu,
      Icons.star_border_outlined,
      Icons.logout
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: sizedBoxHeight10,
          title: ValueListenableBuilder(
            valueListenable: newusername,
            builder: (context, snapshot, _) {
              return Text(
                newusername.value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              );
            },
          ),
        ),
        endDrawer: Drawer(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Drawericons[index]),
                title: Text(Drawertitle[index]),
                onTap: () async {
                  print(index);
                  if (index == 8) {
                    await AuthMethod().logout();
                  } else if (index == 5) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SavedPosts()));
                  }
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(color: kGrey);
            },
            itemCount: Drawertitle.length,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height / 3.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBoxHeight10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: profile,
                              builder: (context, snapshot, _) {
                                return CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    profile.value,
                                  ),
                                );
                              },
                            ),
                            Column(
                              children: [
                                Text(
                                  "${currentuserdata!.posts.length}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                sizedBoxHeight10,
                                const Text('Posts'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                              currentuserdata!.follower.length.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                sizedBoxHeight10,
                                const Text('Followers'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                 currentuserdata!.following.length.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                sizedBoxHeight10,
                                const Text('Following'),
                              ],
                            ),
                          ],
                        ),
                        sizedBoxHeight10,
                        ValueListenableBuilder(
                          valueListenable: newname,
                          builder: (context, snapshot, _) {
                            return Text(
                              newname.value,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        sizedBoxHeight5,
                        SizedBox(
                          height: size.height / 12,
                          width: size.width / 1.4,
                          child: ValueListenableBuilder(
                            valueListenable: newbio,
                            builder: (context, snapshot, _) {
                              return Text(
                                newbio.value,
                                maxLines: 3,
                                style: const TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width / 2.6,
                        child: Elevated_button(
                          elevatedbutttonid: 'editprofile_inaccount',
                          elevatedbuttonstyle: ElevatedButton.styleFrom(
                              backgroundColor: kGreyDarkTrans),
                          elevatedbutttonwidget: const Text('Edit profile'),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 2.6,
                        child: Elevated_button(
                          elevatedbutttonid: 'shareprofile_inaccount',
                          elevatedbuttonstyle: ElevatedButton.styleFrom(
                              backgroundColor: kGreyDarkTrans),
                          elevatedbutttonwidget: const Text('Share profile'),
                        ),
                      ),
                      Center(
                        child: Elevated_button(
                          elevatedbutttonid: 'addac_inaccount',
                          elevatedbuttonstyle: ElevatedButton.styleFrom(
                              backgroundColor: kGreyDarkTrans),
                          elevatedbutttonwidget: const Icon(kaddAccount),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight10,
                  const Text(
                    'Story Highlights',
                    style: TextStyle(fontSize: 17),
                  ),
                  sizedBoxHeight10,
                  const Text(
                    'Keep your favourite stories on your profile',
                  ),
                  sizedBoxHeight10,
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: kWhite, width: 1.5),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const OthersProfile(
                                      uid: 'nJBWucQnNsfK7dJO89uKIy9cXMB2'),
                                ));
                              },
                              child: const Icon(
                                kadd,
                                size: 35,
                              ),
                            ),
                          ),
                          sizedBoxHeight10,
                          const Text('New'),
                        ],
                      ),
                      SizedBox(
                        width: size.width / 1.3,
                        height: size.height / 7,
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          crossAxisCount: 1,
                          children: List.generate(
                            1,
                            (index) => Column(
                              children: [
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg'),
                                ),
                                sizedBoxHeight10,
                                Text('New$index'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TabBar(
                    isScrollable: true,
                    labelColor: kWhite,
                    unselectedLabelColor: kGrey,
                    indicatorColor: kGrey,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 30),
                    tabs: [
                      Tab(
                        child: SizedBox(
                          height: 50,
                          width: size.width / 3,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Icon(kgrid),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          height: 50,
                          width: size.width / 3,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Icon(kTagperson),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height / 1.5,
                    child: TabBarView(
                      children: [
                        Postpage(uid:currentuserdata!.uid!),
                        Tagpage(uid: currentuserdata!.uid!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
