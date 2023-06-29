import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 17,
              child: Cupertino_textfield(
                  maxlengh: 20,
                  backgroundcolour: ktransaparentGrey,
                  placeholderText: 'Search',
                  borderradiusValue: 10,
                  borderwidthValue: 0,
                  borderColor: kGrey,
                  controller: searchController,
                  textfieldId: 'Searchscreen_top',
                  placeholderStyle: const TextStyle(color: kGrey),
                  prefixWidget: const Row(
                    children: [
                      w10,
                      Icon(ksearchicon, color: kGrey),
                    ],
                  ),
                  suffixWidget: h10,
                  keyboardInputTyoe: TextInputType.name,
                  isobscure: false),
            ),
            Expanded(
              child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('post').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: kwhite,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Some Error occured'));
                    }
                    return SizedBox(
                      height: size.height / 1.5,
                      child: GridView.custom(
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3,
                            repeatPattern: QuiltedGridRepeatPattern.inverted,
                            pattern: [
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(2, 1),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 1),
                            ],
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                              childCount: snapshot.data!.docs.length,
                              (context, index) {
                            final data = snapshot.data!.docs[index];
                            String colorString = data['filtercolor'];
                            String extractedCode = colorString.substring(
                                6, colorString.length - 1);
                            final parscode = int.parse(extractedCode);
                            return Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 48, 48, 48),
                                  image: DecorationImage(
                                      image: NetworkImage(data['postUrl']),
                                      fit: BoxFit.cover)),
                              child: Container(
                                color: Color(parscode),
                              ),
                            );
                          })),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
