import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/AddPost/AddPost.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class EditePost extends StatelessWidget {
  const EditePost({super.key, required this.imagePath});
  final Uint8List imagePath;
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    ValueNotifier<Color> filtercolor = ValueNotifier(const Color(0x00000000));
    const List<String> filterNames = [
      'Original',
      '1977', //lightbule
      'Appolo', //green
      'Barnan', //yellomix
      'EarlyBird', //yellowgreen,
      'Gotham', //lightblack
      'MayFair', //blue
      'Kelvin', //brown
      'Rise', //violet
      'Nashville', //zyan
    ];
    const filters = [
      kTransparent,
      Color.fromARGB(87, 34, 137, 221),
      Color.fromARGB(87, 17, 167, 125),
      Color.fromARGB(86, 124, 141, 16),
      Color.fromARGB(85, 83, 142, 12),
      Color.fromARGB(84, 25, 25, 25),
      Color.fromARGB(83, 5, 94, 177),
      Color.fromARGB(107, 163, 109, 15),
      Color.fromARGB(107, 121, 2, 180),
      Color.fromARGB(115, 0, 172, 220),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.edit),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostAdd(
                          imagepath: imagePath,
                         
                          uid: currentuserdata.uid,
                          filtercolor: filtercolor.value,
                        )));
              },
              icon: const Icon(Icons.arrow_forward))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screensize.width > 600 ? screensize.width / 3 : 2),
        child: Column(
          children: [
            Stack(children: [
              ValueListenableBuilder(
                  valueListenable: filtercolor,
                  builder: (context, snapshot, _) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(imagePath), fit: BoxFit.cover),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        color: filtercolor.value,
                      ),
                    );
                  }),
              Positioned(
                  top: MediaQuery.of(context).size.height / 2.5,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.expand_circle_down,
                        size: 50,
                        color: kGrey,
                      ))),
            ]),
            sizedBoxHeight50,
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.6,
              width: double.infinity,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(
                    10,
                    (index) => GestureDetector(
                          onTap: () {
                            filtercolor.value = filters[index];
                          },
                          child: Column(
                            children: [
                              Text(filterNames[index]),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: MemoryImage(imagePath),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: filters[index],
                                ),
                              )
                            ],
                          ),
                        )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Fliter',
                      style: TextStyle(fontSize: 20, color: kWhite),
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Text('Edit',
                        style: TextStyle(fontSize: 20, color: kGrey))),
              ],
            )
          ],
        ),
      )),
    );
  }
}
