import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/Userfunctions.dart';
import 'package:instagram_clone/Presenation/Account/Account_screen.dart';
import 'package:instagram_clone/Presenation/AddPost/NewPost.dart';
import 'package:instagram_clone/Presenation/Home/Home_screen.dart';
import 'package:instagram_clone/Presenation/Notification/Notification_screen.dart';
import 'package:instagram_clone/Presenation/search/explore_screen.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

ValueNotifier<int> Bottomindex = ValueNotifier(0);
final bottomscreens = [
  const HomeScreen(),
  const SearchScreen(),
  const AddpostScreen(),
  const NotificationScreen(),
  const AccountScreen()
];
//    uid: FirebaseAuth.instance.currentUser!.uid,
const double websize = 1000;

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      currentuserdata = await AuthMethod().getUserDetail();
    });

    return ValueListenableBuilder(
        valueListenable: Bottomindex,
        builder: (context, value, child) {
          return Scaffold(
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(canvasColor: kBlack),
              child: BottomNavigationBar(
                  selectedItemColor: kWhite,
                  unselectedItemColor: kGrey,
                  currentIndex: value,
                  onTap: (newindex) {
                    Bottomindex.value = newindex;
                  },
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: ''),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: ''),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.add_box_outlined), label: ''),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: ''),
                    BottomNavigationBarItem(
                        icon: CircleAvatar(
                          radius: 17,
                          backgroundImage: NetworkImage(
                            currentuserdata.photoUrl,
                          ),
                        ),
                        label: ''),
                  ]),
            ),
            body: bottomscreens[value],
          );
        });
  }
}
/*
Screensize > websize
        ? const WebmainPge()
        : */