import 'package:flutter/material.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:instagram_clone/utenslis/Sizes.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.34,
              width: double.infinity,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  'https://cdn.wallpapersafari.com/31/2/5SX1m0.jpg'),
                            ),
                            title: Text('Username$index   like your Post'),
                          ),
                        ),
                        Text(
                          '$index d',
                          style: const TextStyle(color: kGrey),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 13,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://thumbs.dreamstime.com/b/scenic-view-moraine-lake-mountain-range-sunset-landscape-canadian-rocky-mountains-49666349.jpg'),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return h20;
                  },
                  itemCount: 20),
            )
          ],
        ),
      )),
    );
  }
}
