import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/Presenation/Account/PostListPage.dart';
import 'package:instagram_clone/Presenation/search/search.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 17,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Search_history()));
                  },
                  child: Container(
                    height: size.height / 7,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: kTransparentGrey,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        sizedBoxWidth20,
                        Icon(
                          ksearchicon,
                          color: kGrey,
                        ),
                        sizedBoxWidth20,
                        Text(
                          'Search.....',
                          style: TextStyle(color: kGrey, fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
            sizedBoxHeight10,
            Expanded(
              child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('post').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: kWhite,
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
                          
                            
                           
                            return GestureDetector( 
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PostListPage(
                                        posts: snapshot.data!.docs,
                                        initialPostIndex: index)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 48, 48, 48),
                                    image: DecorationImage(
                                        image: NetworkImage(data['postUrl']),
                                        fit: BoxFit.cover)),
                                child: Container(
                                   
                                  color: Color.fromARGB(data['filterColor'][0], data['filterColor'][1], data['filterColor'][2], data['filterColor'][3]),
                                ),
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
