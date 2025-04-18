import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/FirestoreMethods.dart';
import 'package:instagram_clone/Presenation/search/After_search.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';

class Search_history extends StatelessWidget {
  const Search_history({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final queryController = TextEditingController();
    ValueNotifier<bool> isAdd = ValueNotifier(false);
    return ValueListenableBuilder<bool>(
      valueListenable: isAdd,
      builder: (context, isAddValue, _) {
        return Scaffold(
          appBar: AppBar(
            title: SizedBox(
              height: size.height / 9,
              width: size.width,
              child: CupertinoTextField(
                controller: queryController,
                prefix: const Icon(
                  Icons.search,
                  color: kGrey,
                ),
                style: const TextStyle(color: kWhite),
                placeholder: 'Search "a user"',
                placeholderStyle: const TextStyle(
                  color: kGrey,
                  fontSize: 16,
                ),
                onChanged: (value) {
                  if (isAddValue) {
                    isAdd.value = false;
                  }
                },
                onSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => After_search(
                          querry: value,
                        ),
                      ),
                    );

                    log('value : $value isAdd $isAddValue');

                    if (!isAddValue) {
                      await FirestoreMethods().search_add(
                        profileImg: currentuserdata!.photoUrl,
                        username: currentuserdata!.username,
                        serach_query: value,
                        useruid:currentuserdata!.uid!,
                      );
                    }
                    isAdd.value = false;
                    queryController.text = '';
                  }
                },
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kIsWeb ? size.width / 5 : 0,
              ),
              child: Column(
                children: [
                 
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('search')
                        .where('useruid', isEqualTo: currentuserdata!.uid)
                        .orderBy('search_query', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                     // log('data ${snapshot.data!.docs.length}');
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text('No Search Item Found'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: kBlue,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Some error occurred. ${snapshot.error}');
                      } else {
                        return Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final data = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () async {
                                  queryController.text = data['search_query'];
                                  DocumentReference docRef = FirebaseFirestore
                                      .instance
                                      .collection('search')
                                      .doc(data['searchUid']);
                                  bool documentExists =
                                      (await docRef.get()).exists;
                                  isAdd.value = documentExists;
                                },
                                child: Listtitlenoimage(
                                  deleteid: data['searchUid'],
                                  isSearch: true,
                                  trailicon: kclose,
                                  title: data['search_query'],
                                  Subtitle: '',
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: kGrey,
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Listtitlenoimage extends StatelessWidget {
  const Listtitlenoimage({
    super.key,
    required this.title,
    required this.Subtitle,
    required this.trailicon,
    required this.deleteid,
    required this.isSearch,
  });

  final String title;
  final String Subtitle;
  final IconData trailicon;
  final bool isSearch;
  final String deleteid;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
      subtitle: Text(
        Subtitle,
      ),
      trailing: GestureDetector(
          onTap: () async {
            if (isSearch == true) {
              await FirestoreMethods().deleteSearch(uid: deleteid);
            }
          },
          child: Icon(trailicon,size: 20,)),
    );
  }
}
