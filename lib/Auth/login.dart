import 'dart:io';
import 'dart:convert' as convert;
import 'package:dalal/MainPage/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  signIn(String username, pass) async {
    // var url = "https://dalalin.herokuapp.com/api-token-auth/";
    var url = "https://kinglink2.herokuapp.com/v2/api-token-auth/";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> bodyData = {
      'username': username,
      'password': pass,
    };
    // ignore: avoid_init_to_null
    var jsonResponse = null;
    http.Response response;
    try {
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      IOClient ioClient = IOClient(client);

      response = await ioClient.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: convert.jsonEncode(bodyData),);

      if (response.statusCode == 200) {
        jsonResponse = convert.jsonDecode(response.body);
        print("token");
        print("token" + jsonResponse['token']);
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          sharedPreferences.setString("token", jsonResponse['token']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => MainPage()),
              (Route<dynamic> route) => false);
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    } catch (ex) {
      print(ex);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(emailController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "username",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Code Land",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
