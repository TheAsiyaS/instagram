import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

final photoPickList = ['Gallery', 'Camera', 'WatsApp image', 'Facebook image'];

ValueNotifier<String> dropInitValue = ValueNotifier('Gallery');
Uint8List? _file;

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
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => editePost(
                //           imagePath: _file!,
                //         )));
              },
              icon: const Icon(Icons.arrow_forward))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Stack(children: [
                _file != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: MemoryImage(_file!), fit: BoxFit.cover),
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
              ])),
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
                      color: ktransaparentGrey,
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

class DropdownImagePick extends StatefulWidget {
  DropdownImagePick({super.key, required this.id});
  String id;
  @override
  State<DropdownImagePick> createState() => _DropdownImagePickState();
}

class _DropdownImagePickState extends State<DropdownImagePick> {
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
                onTap: () {
                  // log(dropdownvalue.toString());
                },
                items: photoPickList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) async {
                  dropInitValue.value = newValue!;
                  // if (newValue == 'Gallery') {
                  //   log('0');
                  //   final postFile = await pickImage(ImageSource.gallery);
                  //   if (widget.id == 'AddStory') {
                  //     setState(() {
                  //       storyImage = postFile;
                  //     });
                  //   } else if (widget.id == 'AddPost') {
                  //     setState(() {
                  //       _file = postFile;
                  //     });
                  //   }
                  // } else if (newValue == 'Camera') {
                  //   log('1');
                  //   final postFile = await pickImage(ImageSource.camera);
                  //   if (widget.id == 'AddStory') {
                  //     setState(() {
                  //       storyImage = postFile;
                  //     });
                  //   } else if (widget.id == 'AddPost') {
                  //     setState(() {
                  //       _file = postFile;
                  //     });
                  //   }
                  // } else if (newValue == 'WatsApp image') {
                  //   log('2');
                  //   final postFile = await pickImage(ImageSource.gallery);
                  //   if (widget.id == 'AddStory') {
                  //     setState(() {
                  //       storyImage = postFile;
                  //     });
                  //   } else if (widget.id == 'AddPost') {
                  //     setState(() {
                  //       _file = postFile;
                  //     });
                  //   }
                  // } else if (newValue == 'Stibnite image') {
                  //   log('3');
                  //   final postFile = await pickImage(ImageSource.gallery);
                  //   if (widget.id == 'AddStory') {
                  //     setState(() {
                  //       storyImage = postFile;
                  //     });
                  //   } else if (widget.id == 'AddPost') {
                  //     setState(() {
                  //       _file = postFile;
                  //     });
                  //   }
                  // }
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
