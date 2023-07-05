import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Account/Others_account.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

import '../../utenslis/Colors.dart';

// ignore: camel_case_types
class After_search extends StatelessWidget {
  const After_search({super.key, required this.querry});
  final String querry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          querry,
          style: const TextStyle(color: kGrey, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('user')
                .where(
                  'username',
                  isGreaterThanOrEqualTo: querry,
                )
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Some Error Ocuur !!!'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No User Found'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: kWhite,
                  ),
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1,
                width: double.infinity,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          sizedBoxHeight10,
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                data['photoUrl'],
                              ),
                              radius: 30,
                            ),
                            title: Text(data['username']),
                            subtitle: Text(data['name']),
                            onTap: () async {
                              log(data['uid']);
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (conatext) => OthersProfile(
                                            uid: data['uid'],
                                          )));
                            },
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return sizedBoxHeight30;
                    },
                    itemCount: snapshot.data!.docs.length),
              );
            }),
      ),
    );
  }
}
