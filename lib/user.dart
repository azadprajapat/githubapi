import 'dart:convert';
import 'package:github/repolist.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github/userdata.dart';
import 'package:url_launcher/url_launcher.dart';

class User extends StatefulWidget {
  final user;

  User(this.user);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  var newid;
  var newlist;
  var _repolength;
  TextStyle _textStyle=TextStyle(fontSize: 18.0,color: Colors.white);
  List<RepoList> _list=List<RepoList>();
  @override
  void initState() {
    fetch();
    fetchList().then((value){
      setState(() {
        _list.addAll(value);
      });

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     if (newid == null) {
      return CircularProgressIndicator();
    }
    else {
      return Scaffold(
          appBar: AppBar(title: Text(
              '${widget.user} id:${newid.toString()}'

          ),
            centerTitle: true,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Repositories ${_repolength}',style: _textStyle,),
                )
            ),),
          body: ListView.builder(itemBuilder: (BuildContext context, index) {
              return Card(
                margin: EdgeInsets.only(top: 0,left: 0,right: 0,bottom: 2),
                child: Container(
                  padding: EdgeInsets.only(right: 0,left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_list[index].name,style:TextStyle(fontSize: 15.0)),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        child: FlatButton(child: Text('DOWNLOAD',style: _textStyle,),
                          color: Colors.blueAccent,
                          onPressed: (){
                            _launchURL(index);
                          },
                        ),
                      )
                    ],
                  ),
                  color: Colors.green,
                ),

              );
          },
            itemCount: _list.length)
      );
    }

  }

  Future<void> fetch() async {
    var data = await fetchUser();
    setState(() {
      newid = data.id;
      _repolength=data.repo_length;
    });
  }

  Future<profile> fetchUser() async {
    final response =
    await http.get('https://api.github.com/users/${widget.user}');
    if (response.statusCode == 200) {
      return profile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
  Future <List<RepoList>>fetchList() async{
    final response=await http.get('https://api.github.com/users/${widget.user}/repos');
    var items=List<RepoList>();
    if (response.statusCode == 200) {
      var  jsonitems =(json.decode(response.body));
        for(var jsonitem in jsonitems){
          items.add(RepoList.fromJson(jsonitem));
        }
        return items;
    } else {
      throw Exception('Failed to load');
    }
  }
 Future<void>  _launchURL(int i) async {
    var url = _list[i].url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  }
