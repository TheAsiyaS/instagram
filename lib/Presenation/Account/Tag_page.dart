import 'package:flutter/material.dart';

class Tagpage extends StatelessWidget {
  const Tagpage({super.key});

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
                          'https://images.unsplash.com/photo-1588064578354-c1e28d429246?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fG9wdGltaXphdGlvbnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                        ),
                        fit: BoxFit.cover)),
              )),
    );
  }
}
