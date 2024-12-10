import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/modals/user.dart';
import 'package:flutter_with_firebase/screen/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_with_firebase/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModal?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
