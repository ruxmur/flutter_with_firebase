import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/modals/user.dart';
import 'package:flutter_with_firebase/screen/authenticate/authenticate.dart';
import 'package:flutter_with_firebase/screen/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModal?>(context);

    // return either Home or Authenticate widget throw a stream
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
