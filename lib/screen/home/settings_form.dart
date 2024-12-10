import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../modals/user.dart';
import '../../services/database.dart';
import '../../shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = '';
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModal?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          UserData? userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update your brew settings.', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData?.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(value: sugar, child: Text('$sugar sugars'));
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val.toString()),
                ),
                // slider
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value: _currentStrength.toDouble(),
                  onChanged: (val) => setState(() => _currentStrength = val.toInt()),
                  activeColor: Colors.brown[_currentStrength],
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars,
                        _currentName,
                        _currentStrength
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}

