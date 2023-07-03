import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/main.dart';

RegExp usernameRegex = RegExp(r'^[0-1a-z._]+$');
const noimg =
    'https://selvamtech.edu.in/wp-content/uploads/2014/05/no-user-image.gif';
const websize = 600;


final List<String> drawerTitle = [''];
ValueNotifier<String> profile =
    ValueNotifier(currentuserdata.photoUrl );

final TextEditingController UsernameController = TextEditingController();

