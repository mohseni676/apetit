import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'classes/globals.dart' as globals;
import 'pages/mainPage.dart';

void main() async{
  runApp(new MaterialApp(
    title: 'Appetit',
    home: new home(),
    theme: new ThemeData(
      primaryColor: Colors.pink.shade600,
      fontFamily: 'yekan',


    ),

  ));
}

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new homeState();
  }
}

class homeState extends State<home> {

  TextEditingController _mobile= new TextEditingController();
  TextEditingController _password=new TextEditingController();

  void auth (String user,String pass) async{
    debugPrint('x');
    var response=await http.post(
        'http://92.50.34.37/api/v1/coach/login',
      body: {
          'mobile':'$user',
          'pass': '$pass'
      }


    );
    if (response.statusCode==200){
      debugPrint('ok');
      var x=json.decode(response.body);
      debugPrint(x['access_token'].toString());
      globals.token=x['access_token'].toString();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>mainPage(globals.token)));
    }else{
      debugPrint('No');
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(textDirection: TextDirection.rtl,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text('Appetit'),
            centerTitle: true,
          ),
          body: new Center(
            child: new ListView(
              padding: EdgeInsets.all(25.0),
              children: <Widget>[
                new CircleAvatar(
                  maxRadius: 65.0,
                  backgroundColor: Colors.pinkAccent,

                  child: ClipOval(
                    clipBehavior: Clip.antiAlias,
                    child: new Icon(Icons.fitness_center,
                      size: 60.0,


                    ),
                  ),
                ) ,
                new SizedBox(
                  height: 20.0,
                ),
                new TextFormField(
                  controller: _mobile,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: 'شماره همراه',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      
                    )
                  ),
                ),
                new Padding(padding: EdgeInsets.all(4.0)),
                new TextFormField(
                  controller: _password,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: 'رمز عبور',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),

                      )
                  ),
                ),
                new Padding(padding: EdgeInsets.all(5.0)),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),

                  ),
                  onPressed: () async{
                    //Navigator.of(context).pushNamed(HomePage.tag);
                    await auth(_mobile.text, _password.text);
                  },
                  padding: EdgeInsets.all(18),
                  color: Colors.pinkAccent,
                  child: Text('ورود به سیستم', style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w800,
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}

