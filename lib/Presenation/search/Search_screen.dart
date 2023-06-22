import 'package:flutter/cupertino.dart';
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
              height: size.height/17, 
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
              child: SizedBox(
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
                    childrenDelegate: SliverChildBuilderDelegate(childCount: 30,
                        (context, index) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 48, 48, 48),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.vieribottazzini.com/wp-content/uploads/X1DII1_00190_slide.jpg'),
                                fit: BoxFit.cover)),
                      );
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }
}
