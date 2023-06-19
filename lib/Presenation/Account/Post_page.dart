import 'package:flutter/material.dart';

class Postpage extends StatelessWidget {
  const Postpage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1 / 1,
      mainAxisSpacing: 3,
      crossAxisSpacing: 3,
      children: List.generate(
          45,
          (index) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://imagekit.io/blog/content/images/2019/12/image-optimization.jpg',
                        ),
                        fit: BoxFit.cover)),
              )),
    );
  }
}
