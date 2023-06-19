import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Login/Login_scree.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

/*
https://www.befunky.com/images/prismic/f5ca4181-01da-4237-92bf-b6938359503e_hero-blur-image-5.jpg?auto=avif,webp&format=jpg&width=896,
https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg,
https://i0.wp.com/blog.apilayer.com/wp-content/uploads/2022/11/pexels-photo-574073.jpeg?resize=1132%2C694&ssl=1,
https://imagekit.io/blog/content/images/2019/12/image-optimization.jpg,
https://images.unsplash.com/photo-1588064578354-c1e28d429246?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fG9wdGltaXphdGlvbnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: kblack,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: kblack),
        appBarTheme: const AppBarTheme(backgroundColor: kblack),
        navigationBarTheme:
            const NavigationBarThemeData(backgroundColor: kblack),
        brightness: Brightness.dark,
      ),
      home: LoginScreen(),
    );
  }
}
