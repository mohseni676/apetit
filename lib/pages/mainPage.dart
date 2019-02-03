import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apetit/classes/globals.dart' as globals;

class mainPage extends StatefulWidget {
  String _token;

  mainPage(this._token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new mainState(_token);
  }
}

class mainState extends State<mainPage> {
  String _token;
  String _trainer;
  String _imgUrl;

  mainState(this._token);

  void _getUserInfo(String _token) async {
    var response = await http.post('http://92.50.34.37/api/v1/coach/dashboard',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        });
    if (response.statusCode == 200) {
      debugPrint('ok');
      var x = json.decode(response.body);
      //debugPrint(x['name'].toString());
      //globals.token=x['access_token'].toString();
      setState(() {
        _trainer = x['name'].toString() + ' ' + x['family'].toString();
        _imgUrl = x['avatar'].toString();
      });

      debugPrint(_trainer);
    } else {
      debugPrint('No');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo(globals.token);
    // await _getUserInfo(globals.token);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(

          appBar: new AppBar(
            title: new Text('اَپتیت مربیان',
            textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.w700
              ),
            ),
            centerTitle: true,
          ),
          body:

          new Center(
              child: new Container(
                padding: EdgeInsets.all(8.0),
            child: Column(
              //shrinkWrap: true,
              //padding: EdgeInsets.all(8.0),
              children: <Widget>[
                new Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          offset: new Offset(7.0, 4.0),
                          blurRadius: 15.0

                        )
                      ],
                      image: new DecorationImage(
                          image: NetworkImage(_imgUrl), fit: BoxFit.fill),
                      border: Border.all(
                        color: Colors.black45,
                        width: 2.0,
                        style: BorderStyle.solid
                      )),
                ),
                new Padding(padding: EdgeInsets.all(2.0)),
                new Text(_trainer,
                textAlign: TextAlign.center,
                style: TextStyle(
                  shadows: [
                    new Shadow(
                      color: Colors.pink,
                      blurRadius: 12.0,
                      offset: new Offset(3.0, 2.0)
                    )
                  ],
                  fontWeight: FontWeight.w800,
                ),
                textScaleFactor: 1.5,
                )
              ],
            ),
          )),
        ));
  }
}
