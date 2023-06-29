import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Domain/imagePick.dart';
import 'package:instagram_clone/Presenation/AddPost/EditePost.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

final photoPickList = ['Gallery', 'Camera', 'WatsApp image', 'Facebook image'];

ValueNotifier<String> dropInitValue = ValueNotifier('Gallery');

ValueNotifier<Uint8List?> file = ValueNotifier(null);

class AddpostScreen extends StatelessWidget {
  const AddpostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPost'),
        actions: [
          IconButton(
              onPressed: () {
                if (file.value != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditePost(imagePath: file.value!)));
                } else {
                  print('No data found');
                }
              },
              icon: const Icon(Icons.arrow_forward))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 2,
              child: ValueListenableBuilder(
                  valueListenable: file,
                  builder: (context, snapshot, _) {
                    return Stack(children: [
                      file.value != null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: MemoryImage(file.value!),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://thumbs.dreamstime.com/b/scenic-view-moraine-lake-mountain-range-sunset-landscape-canadian-rocky-mountains-49666349.jpg'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 3.5,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.expand_circle_down,
                                size: 50,
                                color: kGrey,
                              )))
                    ]);
                  })),
          Expanded(
              flex: 2,
              child: Stack(children: [
                GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  children: List.generate(
                      21,
                      (index) => Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://thumbs.dreamstime.com/b/scenic-view-moraine-lake-mountain-range-sunset-landscape-canadian-rocky-mountains-49666349.jpg'),
                                    fit: BoxFit.cover)),
                          )),
                ),
                DropdownImagePick(id: 'AddPost'),
                Positioned(
                    top: MediaQuery.of(context).size.height / 4.2,
                    left: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      color: ktransaparent,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(105, 20, 20, 20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              Text(
                                '\tPost',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Story', style: TextStyle(fontSize: 20)),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Reel', style: TextStyle(fontSize: 20)),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Live\t', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ))
              ]))
        ],
      )),
    );
  }
}

// ignore: must_be_immutable
class DropdownImagePick extends StatelessWidget {
  DropdownImagePick({super.key, required this.id});
  String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kblackshade,
      height: MediaQuery.of(context).size.height / 13,
      width: double.infinity,
      child: Row(
        children: [
          ValueListenableBuilder(
            builder: (context, value, child) {
              return DropdownButton(
                value: dropInitValue.value,
                icon: const Icon(Icons.keyboard_arrow_down),
                onTap: () {},
                items: photoPickList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) async {
                  dropInitValue.value = newValue!;
                  if (newValue == 'Gallery') {
                    final postFile = await pickImage(ImageSource.gallery);

                    file.value = postFile;

                    // }
                  } else if (newValue == 'Camera') {
                    final postFile = await pickImage(ImageSource.camera);

                    file.value = postFile;
                  } else if (newValue == 'WatsApp image') {
                    final postFile = await pickImage(ImageSource.gallery);

                    file.value = postFile;
                  } else if (newValue == 'Stibnite image') {
                    final postFile = await pickImage(ImageSource.gallery);

                    file.value = postFile;
                  }
                },
              );
            },
            valueListenable: dropInitValue,
          ),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_none_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.camera_alt_rounded)),
        ],
      ),
    );
  }
}
