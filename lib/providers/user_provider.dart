import 'package:flutter/material.dart';
import 'package:medihub/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart : []
  );

  User get user => _user;

  void setUser(User user){
    _user = user;
    notifyListeners();
  }
}
