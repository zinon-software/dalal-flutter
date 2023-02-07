import 'package:dalal/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
      drawer: drawer(context),
    );
  }

  appBar(BuildContext context) {
    return AppBar(
      title: Text("Code Land", style: TextStyle(color: Colors.white)),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            sharedPreferences.clear();
            // ignore: deprecated_member_use
            sharedPreferences.commit();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()),
                (Route<dynamic> route) => false);
          },
          child: Text("Log Out", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  List<List> _list = [["0", "0", "0"], ["0", "0", "0"], ["0", "0", "0"]];

  body(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      _list[0][0].add(1.toString());
                      print(_list[0][0]);
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      // _list[0].add(1.toString());
                      print(_list[1]);
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      // _list[0].add(1.toString());
                      print(_list[2]);
                    },
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      // _list[0].add(1.toString());
                      print(_list[3]);
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      // _list[0].add(1.toString());
                      print(_list[4]);
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      // _list[0].add(1.toString());
                      print(_list[5]);
                    },
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      // _list[0].add(1.toString());
                      print(_list[6]);
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      // _list[0].add(1.toString());
                      print(_list[7]);
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  setState(
                    () {
                      // _list[0].add(1.toString());
                      print(_list[8]);
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  drawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Center(child: Text('Abdu')),
          Center(child: Text('Abdu')),
          Center(child: Text('Abdu')),
          Center(child: Text('Abdu')),
        ],
      ),
    );
  }
}
