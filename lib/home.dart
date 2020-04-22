import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:github/user.dart';
import 'package:http/http.dart' as http;
import 'package:github/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Git hub'),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onChanged: (val) {
                setState(() {
                  username = val;
                });
              },
            ),
            RaisedButton(
              child: Text('search'),
              color: Colors.green,
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            User(this.username)));
              },
            ),
          ],
        ),
      ),
    );
  }

}
