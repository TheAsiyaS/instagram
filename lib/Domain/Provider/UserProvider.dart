// provider for state management



// class UserProvider with ChangeNotifier {
//   UserData? _user;
//   final AuthMethod _authMethods = AuthMethod();

//   UserData get getUser => _user!;

//   Future<void> refreshUser() async {
//     UserData user = await _authMethods.getUserDetail();
//     _user = user;
//     notifyListeners();
//   }
// }