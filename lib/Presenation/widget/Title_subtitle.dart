import 'package:flutter/material.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class Titlesubtitle extends StatelessWidget {
  const Titlesubtitle({super.key, required this.title, required this.subtitle, required this.titlestyle, required this.subtitlestyle});
  final String title;
  final String subtitle;
  final TextStyle titlestyle;
  final TextStyle subtitlestyle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: titlestyle,
        ),
        sizedBoxHeight10,
        Text(
          subtitle,
          style: subtitlestyle,
        )
      ],
    );
  }
}
