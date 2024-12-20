import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/modals/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
            child: Text(brew.name.substring(0, 1), style: TextStyle(color: Colors.white),),
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name, style: TextStyle(fontSize: 18.0),),
          subtitle: Text('Takes ${brew.sugars} sugar(s)', style: TextStyle(fontSize: 15.0),),
        ),
      )
    );
  }
}
