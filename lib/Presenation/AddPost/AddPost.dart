import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/StorageMethods.dart';
import 'package:instagram_clone/Presenation/AddPost/NewPost.dart';
import 'package:instagram_clone/Presenation/AddPost/Tag_post.dart';
import 'package:instagram_clone/Presenation/Navigationpage/NavigationBar.dart';
import 'package:instagram_clone/Presenation/widget/SnackBar.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

ValueNotifier<bool> off1 = ValueNotifier(false);
ValueNotifier<bool> off2 = ValueNotifier(false);
ValueNotifier<bool> off3 = ValueNotifier(false);
ValueNotifier<bool> off4 = ValueNotifier(false);
final TextEditingController descriptionController = TextEditingController();
ValueNotifier<bool> isloading = ValueNotifier(false);
ValueNotifier<num> ratios = ValueNotifier(10);
ValueNotifier<List<String>> items = ValueNotifier([]);
final musicName = [
  'If you beleive',
  'filter',
  'daechitwa',
  'left and right',
  'RunBulletproof BTS',
  'beleiver',
  'love yourself',
  'rush hour',
  'jump',
  'Yet to come'
];
final CountryName = [
  'India',
  'South India',
  'Dubai',
  'USA',
  'SwiserLand',
  'Qatar',
  'canada',
  'Soudia Arabia',
  'Russia',
  'Paris'
];

// ignore: must_be_immutable
class PostAdd extends StatelessWidget {
  PostAdd(
      {super.key,
      required this.imagepath,
      this.uid,
      required this.filtercolor});
  final Uint8List imagepath;
  final Color filtercolor;
  String? uid;
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    List<String> taguid = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPost'),
        actions: [
          IconButton(
              onPressed: () async {
                isloading.value = true;

                for (String uid in tagUsersUid.value) {
                  if (uid.isNotEmpty) {
                    taguid.add(uid);
                  }
                }
                String? location;
                String? music;
                if (CountryName.contains(items.value[0])) {
                  log('0 is country');
                  location = items.value[0];
                }
                if (musicName.contains(items.value[0])) {
                  log('0 is music');
                  music = items.value[0];
                }
                if (musicName.contains(items.value[1])) {
                  log('1 is music');

                  music = items.value[1];
                }
                if (CountryName.contains(items.value[1])) {
                  log('1 is country');

                  location = items.value[1];
                }
                log('uid $taguid');

                final String postUrl = await StorageMethods()
                    .uploadImageToStorage('Posts', imagepath, true);

                if (postUrl.isNotEmpty) {
                  isloading.value = true;
                  final isOk = await FirestoreMethods().uploadPost(
                      tag: taguid,
                      description: descriptionController.text,
                      imagePath: postUrl,
                      username: currentuserdata!.username,
                      profileUrl: currentuserdata!.photoUrl,
                      uid: currentuserdata!.uid!,
                      location: location ?? '',
                      music: music ?? '',
                      filterColor: filtercolor.toString());

                  if (isOk == true) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: kWhite,
                        content: SnackbarWidget(
                            icon: Icons.favorite,
                            message: 'Sucessfully Posted !')));
                    Bottomindex.value = 0;
                    file.value = null;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const NavigationPage()),
                        (route) => true);

                    isloading.value = false;
                    taguid = [];
                    tagUsersUid.value = [
                      'Who is?',
                      'Who is?',
                      'Who is?',
                    ];
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    tagUsersUid.notifyListeners();
                    tagUsers.value = [
                      '',
                      '',
                      '',
                    ];
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    tagUsers.notifyListeners();
                    descriptionController.text = '';
                    location = '';
                    music = '';
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: kRed,
                        content: SnackbarWidget(
                            icon: Icons.remove,
                            message: 'An error occured !')));
                    isloading.value = true;
                  }
                }
              },
              icon: const Icon(
                Icons.check,
                size: 35,
                color: Colors.blue,
              ))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screensize.width > 600 ? screensize.width / 3 : 20),
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: isloading,
              builder: (context, snapshot, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isloading.value
                        ? const LinearProgressIndicator(
                            color: kWhite,
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: kTransparentGrey,
                            backgroundImage:
                                NetworkImage(currentuserdata!.photoUrl),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                                controller: descriptionController,
                                decoration: const InputDecoration(
                                  hintText: 'Write  a Caption........',
                                  hintMaxLines: 20,
                                )),
                          ),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(imagepath),
                                    fit: BoxFit.cover)),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: kGreyDarkTrans,
                    ),
                    sizedBoxHeight20,
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Tagpeople(image: imagepath)));
                      },
                      child: const Text(
                        'Tag People',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    sizedBoxHeight20,
                    const Divider(
                      color: kGrey,
                    ),
                    sizedBoxHeight20,
                    const Text('Add Location', style: TextStyle(fontSize: 20)),
                    SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return FilterChip(
                                  // selectedColor: green,
                                  labelStyle: const TextStyle(fontSize: 16),
                                  label: Text(CountryName[index]),
                                  onSelected: (value) {
                                    items.value.add(CountryName[index]);
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return sizedBoxWidth20;
                            },
                            itemCount: CountryName.length)),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Add music',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return FilterChip(
                                  // selectedColor: green,
                                  labelStyle: const TextStyle(fontSize: 16),
                                  label: Text(musicName[index]),
                                  onSelected: (value) {
                                    items.value.add(musicName[index]);
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return sizedBoxWidth20;
                            },
                            itemCount: musicName.length)),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 5, bottom: 25),
                      child: Text(
                        'Post to Other Instagram account',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Account 1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                        const Spacer(),
                        ValueListenableBuilder(
                          valueListenable: off1,
                          builder: (context, value, child) {
                            return CupertinoSwitch(
                                activeTrackColor: CupertinoColors.systemGrey,
                                value: off1.value,
                                onChanged: (ischange) {
                                  off1.value = ischange;
                                });
                          },
                        ),
                        sizedBoxWidth20,
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Account 2',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const Spacer(),
                        ValueListenableBuilder(
                          valueListenable: off2,
                          builder: (context, value, child) {
                            return CupertinoSwitch(
                                activeTrackColor: CupertinoColors.systemGrey,
                                value: off2.value,
                                onChanged: (ischange) {
                                  off2.value = ischange;
                                });
                          },
                        ),
                        sizedBoxWidth20,
                      ],
                    ),
                    sizedBoxHeight20,
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Also post to',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(currentuserdata!.photoUrl),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('FaceBook',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                            subtitle: const Text('username'),
                            trailing: ValueListenableBuilder(
                              valueListenable: off3,
                              builder: (context, value, child) {
                                return CupertinoSwitch(
                                    activeTrackColor: CupertinoColors.systemGrey,
                                    value: off3.value,
                                    onChanged: (ischange) {
                                      off3.value = ischange;
                                    });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          sizedBoxHeight10,
                          const Text(
                            'Twitter',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          ValueListenableBuilder(
                            valueListenable: off4,
                            builder: (context, value, child) {
                              return CupertinoSwitch(
                                  activeTrackColor: CupertinoColors.systemGrey,
                                  value: off4.value,
                                  onChanged: (ischange) {
                                    off4.value = ischange;
                                  });
                            },
                          ),
                          sizedBoxWidth20,
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      )),
    );
  }
}
