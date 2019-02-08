import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'classes/globals.dart' as globals;
import 'pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  runApp(new MaterialApp(
    title: 'Appetit',
    home: new home(),
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
        fontFamily: 'yekan',
     buttonColor: Colors.pinkAccent,
        toggleableActiveColor: Colors.pink,
        textSelectionColor: Colors.pink,
        highlightColor: Colors.pink,
        indicatorColor: Colors.amber,
        selectedRowColor: Colors.pink,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.black.withOpacity(0.8),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: Colors.pink,
              width: 3.0
            )
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.amber,
              width: 4.0,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.circular(50.0),

          ),
         
        ),
      brightness: Brightness.dark
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
  bool _isSaved=false;
  //final pref=await SharedPreferences.getInstance();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadLoginData();

  }

  _loadLoginData() async{
    SharedPreferences _prefs=await SharedPreferences.getInstance();
    if (_prefs.getBool('isLoginSaved')){
      setState(() {
        _mobile.text=_prefs.getString('mobile');
        _password.text=_prefs.getString('password');
        _isSaved=_prefs.getBool('isLoginSaved');
      });
    }
  }

  _saveLoginDate() async{
    SharedPreferences _prefs=await SharedPreferences.getInstance();
    setState(() {
      _prefs.setBool('isLoginSaved', _isSaved);
      _prefs.setString('mobile', _mobile.text);
      _prefs.setString('password', _password.text);
    });
  }
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
      _saveLoginDate();
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
          /*appBar: new AppBar(
            title: new Text('Appetit'),
            centerTitle: true,
            
          ),*/
          body: new Container(
            padding: EdgeInsets.fromLTRB(5.0, 55.0, 5.0, 5.0),
           /* decoration: BoxDecoration(
              image: DecorationImage(image: new AssetImage('assets/images/bgfirst.jpg'),
              fit: BoxFit.fill
              )
            ),*/
           decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage('assets/images/firstbackground.jpg'),
             fit: BoxFit.fill
             )
           ),
            child: new Center(
              child: new ListView(
                padding: EdgeInsets.all(25.0),
                children: <Widget>[
                  new CircleAvatar(
                    maxRadius: 65.0,
                    //backgroundColor: Colors.pinkAccent,

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
                        prefixIcon: Icon(Icons.phone_android,color: Colors.white70),
                        hintText: 'شماره همراه',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),


                        ),

                    ),
                  ),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  new TextFormField(
                    controller: _password,
                    //keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key,color: Colors.white70,),
                        hintText: 'رمز عبور',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),

                        )
                    ),
                  ),
                  new Padding(padding: EdgeInsets.all(5.0)),
                  new Row(
                    children: <Widget>[
                      new Checkbox(value: _isSaved, onChanged: (bool _val){
                        setState(() {
                          _isSaved=_val;
                        });
                      }),
                      new Text('ذخیره اطلاعات ورود')
                    ],
                  ),

                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),

                    ),
                    onPressed: () async{
                      //Navigator.of(context).pushNamed(HomePage.tag);
                      await auth(_mobile.text, _password.text);
                    },

                    padding: EdgeInsets.all(18),
                    //color: Colors.pinkAccent,
                    child: Text('ورود به سیستم', style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w800,
                    )),
                  ),
                ],
              ),
            ),
          )
        ));
  }
}

