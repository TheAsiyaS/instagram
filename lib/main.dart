import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/Domain/DB/Model/Usermodel.dart';
import 'package:instagram_clone/Presenation/Login/Login_scree.dart';
import 'package:instagram_clone/Presenation/Navigationpage/NavigationBar.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

import 'Domain/DB/Insfrastructure/Userfunctions.dart';

UserData? currentuserdata;

//edite in => search , profile ,
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyDjqsT1ND-B70DHI2EB_0QaEZKpWI82exc',
    appId: '1:19114928418:android:6d2800e7d5585101545d7b',
    messagingSenderId: '19114928418',
    projectId: 'clone-instagram-5ee02',
    storageBucket: 'gs://clone-instagram-5ee02.appspot.com',
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.accent, // Or any other text theme option
            colorScheme: ColorScheme.light().copyWith(
            
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBlack,
        appBarTheme: const AppBarTheme(backgroundColor: kBlack),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return FutureBuilder<UserData>(
                future: AuthMethod().getUserDetail(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (userSnapshot.hasData) {
                    currentuserdata = userSnapshot.data!;
                    return const NavigationPage();
                  } else {
                    return const Center(child: Text("Failed to get user data"));
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) { 
            return const CircularProgressIndicator(
              strokeWidth: 2,
              color: kWhite,
            );
          }
          return LoginScreen();
        },
      ),
    );
  }
}
