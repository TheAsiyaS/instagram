import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Domain/DB/Insfrastructure/AddUser.dart';
import 'package:instagram_clone/Domain/DB/Model/Usermodel.dart';
import 'package:instagram_clone/Presenation/Login/Login_scree.dart';
import 'package:instagram_clone/Presenation/Navigationpage/NavigationBar.dart';
import 'package:instagram_clone/utenslis/Colors.dart';
import 'package:firebase_core/firebase_core.dart';

/*
https://www.befunky.com/images/prismic/f5ca4181-01da-4237-92bf-b6938359503e_hero-blur-image-5.jpg?auto=avif,webp&format=jpg&width=896,
https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg,
https://i0.wp.com/blog.apilayer.com/wp-content/uploads/2022/11/pexels-photo-574073.jpeg?resize=1132%2C694&ssl=1,
https://imagekit.io/blog/content/images/2019/12/image-optimization.jpg,
https://images.unsplash.com/photo-1588064578354-c1e28d429246?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fG9wdGltaXphdGlvbnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80
 */

late UserData currentuserdata;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAOY0ExZdCIDyuoJ91bDo_Xj3sQb47tTzQ",
          appId: "1:666666820807:web:938041a10c486fcfbfcae2",
          messagingSenderId: "666666820807",
          projectId: "instagram-fa0c5",
          storageBucket: 'instagram-fa0c5.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
  currentuserdata = await AuthMethod().getUserDetail();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kblack,
        appBarTheme: const AppBarTheme(backgroundColor: kblack),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // if (snapshot.data!.displayName!.isEmpty) {
              //   return LoginScreen();
              // } else {
              return const NavigationPage();
              //   }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.hasError}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              strokeWidth: 2,
              color: kwhite,
            );
          }
          return LoginScreen();
        },
      ),
    );
  }
}
