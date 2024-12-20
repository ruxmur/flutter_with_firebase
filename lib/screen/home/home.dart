import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screen/home/settings_form.dart';
import 'package:flutter_with_firebase/services/auth.dart';
import 'package:flutter_with_firebase/services/database.dart';
import 'package:provider/provider.dart';
import '../../modals/brew.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        }
      );
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () async {await _auth.signOut();},
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () => showSettingsPanel(),
              label: const Text(
                'settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
          )),
          child: BrewList()
        ),
      ),
    );
  }
}
