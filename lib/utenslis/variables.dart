import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/main.dart';

RegExp usernameRegex = RegExp(r'^[0-1a-z._]+$');
const noimg =
    'https://selvamtech.edu.in/wp-content/uploads/2014/05/no-user-image.gif';
const websize = 600;


final List<String> drawerTitle = [''];
ValueNotifier<String> profile =
    ValueNotifier(currentuserdata.photoUrl ?? noimg);
ValueNotifier<String> name = ValueNotifier(currentuserdata.name ?? "");
ValueNotifier<String> editeusername = ValueNotifier(currentuserdata.username);
ValueNotifier<String> newusername = ValueNotifier(currentuserdata.username);
ValueNotifier<String> bio = ValueNotifier(currentuserdata.bio);
ValueNotifier<String> newname = ValueNotifier(currentuserdata.name ?? "");
ValueNotifier<String> newbio = ValueNotifier(currentuserdata.bio);
final TextEditingController UsernameController = TextEditingController();

final ValueNotifier<int> profilecommentLength = ValueNotifier(0);
final ValueNotifier<List> profilelikes = ValueNotifier([]);
