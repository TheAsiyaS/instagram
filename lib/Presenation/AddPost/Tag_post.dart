import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/widget/CupertinoTextfield.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Icons.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

ValueNotifier<String> searchUser = ValueNotifier('');
String tagUser = '';
String tagUseruid = '';

class Tagpeople extends StatefulWidget {
  const Tagpeople({Key? key, required this.image}) : super(key: key);
  final Uint8List image;

  @override
  State<Tagpeople> createState() => _TagpeopleState();
}

class _TagpeopleState extends State<Tagpeople> {
  List<Offset> tapPositions = [];
  List<int> tapIndexes = [];
  int maxBlueContainers = 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController tagQuery = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 45,
          child: Cupertino_textfield(
            maxLength: 20,
            backgroundColour: kGreyDarkTrans,
            placeholderText: 'search....',
            borderRadiusValue: 10,
            borderWidthValue: 0,
            borderColor: kTransparent,
            controller: tagQuery,
            textfieldId: 'tag_page',
            placeholderStyle: const TextStyle(color: kGrey),
            prefixWidget: const Icon(ksearchicon),
            suffixWidget: sizedBoxWidth2,
            keyboardInputType: TextInputType.name,
            isObscure: false,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTapDown: (details) {
                if (tapPositions.length < maxBlueContainers) {
                  setState(() {
                    tapPositions.add(details.globalPosition);
                    tapIndexes.add(tapPositions.length - 1);
                  });
                }
              },
              child: Stack(
                children: [
                  Container(
                    height: size.height / 2,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ...tapPositions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final position = entry.value;
                    return DraggableWidget(
                      position: position,
                      containerWidth: size.height / 4,
                      containerHeight: size.width / 4,
                      index: index,
                      onRemove: () {
                        setState(() {
                          tapPositions.remove(position);
                          tapIndexes.remove(index);
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('user')
                    .where(
                      'username',
                      isGreaterThanOrEqualTo: searchUser.value,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Some Error Occurred !!!',
                      ),
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.data!.docs.length == 0) {
                    return const Center(child: Text('No User Found!!'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        return Column(
                          children: [
                            const Divider(),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(data['photoUrl']),
                              ),
                              title: Text(data['username']),
                              subtitle: Text(data['name']),
                              onTap: () {
                                setState(() {
                                  tagUser = data['username'];
                                  tagUseruid = data['uid'];
                                  searchUser.value = data['username'];
                                });
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: kGrey,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ValueNotifier<List<String>> tagUsers = ValueNotifier([
  'Who is?',
  'Who is?',
  'Who is?',
]);
ValueNotifier<List<String>> tagUsersUid = ValueNotifier([
  '',
  '',
  '',
]);

class DraggableWidget extends StatefulWidget {
  final Offset position;
  final double containerWidth;
  final double containerHeight;
  final int index;
  final Function() onRemove;

  const DraggableWidget({
    required this.position,
    required this.containerWidth,
    required this.containerHeight,
    required this.index,
    required this.onRemove,
  });

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    log('list init ${tagUsers.value}');
    position = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      left: position.dx - 25,
      top: position.dy - 25,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
          });
        },
        onTap: () {
          widget.onRemove();
        },
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                //  log('list: ${tagUsers.value}');
                if (tagUsers.value.contains(tagUser)) {
                  setState(() {
                    tagUsers.value[widget.index] = 'Who is?';
                  });
                } else {
                  setState(() {
                    tagUsers.value[widget.index] = tagUser;
                    tagUser = '';
                  });
                }
                if (tagUsersUid.value.contains(tagUseruid)) {
                  setState(() {
                    tagUsersUid.value[widget.index] = '';
                  });
                } else {
                  setState(() {
                    tagUsersUid.value[widget.index] = tagUseruid;
                    tagUseruid = '';
                  });
                }
              },
              child: Container(
                width: size.width / 3,
                height: size.height / 15,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(213, 47, 47, 47),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text(tagUsers.value[widget.index])),
              ),
            ),
            Positioned(
              bottom: size.height / 40,
              left: size.width / 4,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: kBlack,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(kclose),
                  color: Colors.white,
                  onPressed: () {
                    widget.onRemove();
                    setState(() {
                      tagUsersUid.value.removeAt(widget.index);
                      tagUsers.value.removeAt(widget.index);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
