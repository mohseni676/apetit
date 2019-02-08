import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apetit/classes/globals.dart' as globals;
import 'waiting_page.dart';
import 'package:apetit/widgets/cust_widgets.dart' as cust_Widgets;

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
  bool _loadingInProgress=true;

  int _waiting=0;
  int _apprentice=0;
  int _messages=0;
  GlobalKey<ScaffoldState> _globalKey=new GlobalKey();

  mainState(this._token);

  void _getUserInfo(String _token) async {
    var response = await http.post('http://92.50.34.37/api/v1/coach/dashboard',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        });
    if (response.statusCode == 200) {
     // debugPrint('ok');
      var x = json.decode(response.body);
      //debugPrint(x['name'].toString());
      //globals.token=x['access_token'].toString();
      setState(() {
        _trainer = x['name'].toString() + ' ' + x['family'].toString();
        _imgUrl = x['avatar'].toString();
       // debugPrint(x['id'].toString());
       // debugPrint(x['dashboard']['waiting'].toString());
        _waiting=int.tryParse(x['dashboard']['waiting'].toString());
        _apprentice=int.tryParse(x['dashboard']['apprentice'].toString());
        _messages=int.tryParse(x['dashboard']['messages'].toString());
        //debugPrint(_waiting.toString()); apprentice
        //globals.user_id=
         // debugPrint( int.tryParse( x['id']).toString());
        //_waiting=
       // debugPrint(    int.tryParse(x['dashboard']['waiting']).toString());
        globals.user_name=_trainer;
        _loadingInProgress=false;
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

  Widget _buildBody(){
    if (_loadingInProgress){
      return new Scaffold(
        body:
        new Center(
        child: new CircularProgressIndicator(),
      ));
    }else{
      return
        Scaffold(
          key: _globalKey,
         drawer: cust_Widgets.globalDrawer(_globalKey),
          
         /* appBar: new AppBar(
          title: new Text('اَپتیت مربیان',
          textScaleFactor: 1.2,
          style: TextStyle(
          fontWeight: FontWeight.w700
      ),
    ),
    centerTitle: true,
    ),*/



    body:
        new Stack(
          
          children: <Widget>[
            new Container(


              decoration: BoxDecoration(
                image: DecorationImage(image: new AssetImage('assets/images/bgchat.jpg',

                ),
                  fit: BoxFit.fill,

                ),


              ),
              padding: EdgeInsets.fromLTRB(8.0, 45.0, 8.0, 8.0),
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
                        /*  new Shadow(
                          color: Colors.pink,
                          blurRadius: 12.0,
                          offset: new Offset(3.0, 2.0)
                      )*/
                      ],
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    textScaleFactor: 1.5,
                  ),
                  new Padding(padding: EdgeInsets.only(top: 15.0)),
                  _buildDashboard(),
                ],
              ),
            ),
            //new cust_Widgets.buildTopHeader('',true,true,scaffoldKey),
            cust_Widgets.buildTopHeader('', false, true, _globalKey)
          ],
      )
        );
    }
  }
  Widget _buildDashboard(){
    return new Card(
      color: Colors.white.withOpacity(0.0),
      //margin: EdgeInsets.all(25.0),
      child:new Column(

        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 10.0)),
      new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          new GestureDetector(
            child: _dashboardIcon('assets/images/shagerd.png', _apprentice,'شاگردان')
          ),
          new GestureDetector(
            child: _dashboardIcon('assets/images/entezar.png', _waiting,'لیست انتظار'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>waitingPage()));
            },
          ),

        ],
      ),
      new Padding(padding: EdgeInsets.only(top: 10.0)),
      new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          new GestureDetector(
            child: _dashboardIconWithoutCounter('assets/images/daramad.png', 'درآمد')
          ),
          new GestureDetector(
            child: _dashboardIcon('assets/images/payam.png', _messages,'پیام ها')
          ),

        ],
      ),
      new Padding(padding: EdgeInsets.only(top: 10.0)),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              new GestureDetector(
                  child: _dashboardIconWithoutCounter('assets/images/taghzie.png', 'دسته بندی تغذیه')
              ),
              new GestureDetector(
                  child: _dashboardIconWithoutCounter('assets/images/majmoeharekat.png', 'مجموعه حرکات')
              ),

            ],
          ),
          new Padding(padding: EdgeInsets.only(top: 10.0)),

        ],
      )


    );

  }

  Widget _dashboardIcon(String imgAddress,int _count,String title){
    return Stack(
      children: <Widget>[

        new CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          child: new Column(
            children: <Widget>[
              /*new Icon(Icons.home,
                      size: 45.0,
                      color: Colors.white,
                      ),*/
              new Image.asset(imgAddress,
                fit: BoxFit.scaleDown,
                height: 45.0,
              ),
              new Text(title,
                style: TextStyle(
                    color: Colors.white,

                ),
                softWrap: true,
                textScaleFactor: 0.7,
              ),
            ],
          ),
          minRadius: 45.0,
        ),
        new CircleAvatar(
          backgroundColor: Colors.red.withOpacity(0.7),
          child: new Text(_count.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  Widget _dashboardIconWithoutCounter(String imgAddress,String title){
    return Stack(
      children: <Widget>[

        new CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          child: new Column(
            children: <Widget>[
              /*new Icon(Icons.home,
                      size: 45.0,
                      color: Colors.white,
                      ),*/
              new Image.asset(imgAddress,
                fit: BoxFit.scaleDown,
                height: 45.0,
              ),
              new Text(title,
                style: TextStyle(
                  color: Colors.white,

                ),
                softWrap: true,
                textScaleFactor: 0.7,
              ),
            ],
          ),
          minRadius: 45.0,
        ),
       /* new CircleAvatar(
          backgroundColor: Colors.red.withOpacity(0.7),
          child: new Text(_count.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),*/
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: _buildBody()



    );
  }
}
