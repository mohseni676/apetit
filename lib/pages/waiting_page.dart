import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apetit/classes/globals.dart' as globals;
import 'package:apetit/classes/apprentices.dart';
import 'package:async/async.dart';
import 'package:apetit/pages/waiting_user_page.dart';
import 'package:apetit/widgets/cust_widgets.dart' as custWidgets;
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:apetit/pages/add_train.dart';

class waitingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new waitingPageState();
  }
}

class waitingPageState extends State<waitingPage> {
  apprentices _apprS = new apprentices();
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  int _page=1;
  int _pageSize=1;

  Future<apprentices> _apprenticeList(String _token, int _page) async {
    try {
      var response = await http.post(
          '${globals.ServerAddress}/api/v1/coach/apprentice?page=${_page}',
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          },
          body: {
            'status': '0'
          });
      if (response.statusCode == 200) {
        var x = json.decode(response.body);
        _apprS = apprentices.fromJson(x);

        //debugPrint(_apprS.data[0].user.name);
        return _apprS;
      } else {
        debugPrint('خطا اطلاعاتی');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Scaffold(
            key: _globalKey,
            drawer: custWidgets.globalDrawer(_globalKey),

            /*appBar: new AppBar(
                title: new Text('لیست انتظار'),

              ),*/
            body: new Stack(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.fromLTRB(8.0, 55.0, 8.0, 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/waitingback.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: new Center(
                      child:




                    new FutureBuilder(
                          future: _apprenticeList(globals.token, _page),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Text('Loading');

                              default:
                                //return Text('ok');
                                apprentices ls = snapshot.data;
                                return new Column(

                                  children: <Widget>[
                                    new Expanded(
                                        child: ListView.builder(

                                            itemCount: ls.data.length,
                                            itemBuilder:
                                                (BuildContext context, int idDex) {
                                              var item = ls.data[idDex].user;
                                              var target=ls.data[idDex].targets[0];
                                              String _illness='ندارد';
                                              switch (item.illness){
                                                case 1:
                                                  _illness='دارد';
                                                  break;
                                                case 0:
                                                  _illness='ندارد';
                                                  break;
                                              }
                                              return new GestureDetector(
                                                onTap:  () {
                                                  /*Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (build) =>
                                                              waiting_user(
                                                                  snapshot
                                                                      .data,
                                                                  index)));*/
                                                },
                                                child: new Card(
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                    
                                                  ),
                                                  color: Colors.pinkAccent.withOpacity(0.7),
                                                  child: new 
                                                  Column(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          new
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              new Container(
                                                                margin: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  //borderRadius: ,
                                                                  border: Border.all(
                                                                      color: Colors.black45,
                                                                      width: 2.0,
                                                                      style: BorderStyle
                                                                          .solid),
                                                                  image:
                                                                  new DecorationImage(
                                                                      image:
                                                                      NetworkImage(
                                                                        item.avatar,
                                                                      ),
                                                                      fit: BoxFit.cover),
                                                                  //borderRadius: BorderRadius.circular(15.0),
                                                                ),
                                                                height: 55.0,
                                                                width: 55.0,
                                                              ),
                                                              new Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: 10.0)),
                                                              new Text(
                                                                '${ls.data[idDex].user.name} ${ls.data[idDex].user.family}',
                                                                textScaleFactor: 1.3,

                                                              ),
                                                            ],
                                                          ),


                                                        ],
                                                      ),
                                                      new Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          new Text('هدف:'),
                                                          new Text(target.name,
                                                            style: TextStyle(
                                                              color: Colors.green,
                                                            ),
                                                          ),
                                                          new Padding(padding: EdgeInsets.only(left: 10.0))
                                                        ],
                                                      ),


                                                      //Row 2
                                                      new Container(
                                                        margin: EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 5.0),
                                                        padding: EdgeInsets.all(6.0),
                                                        
                                                        decoration: BoxDecoration(
                                                          color: Colors.white10,
                                                          borderRadius: BorderRadius.circular(5.0)
                                                        ),
                                                        height: 60.0,
                                                        child:
                                                        new Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          children: <Widget>[
                                                            new Expanded(child:
                                                            new
                                                                GridView.count(crossAxisCount: 2,
                                                            //mainAxisSpacing: 1.0,
                                                              childAspectRatio: 5.0,
                                                            children: <Widget>[
                                                              new Text('قد: ${item.height}'),
                                                              new Text('وزن: ${item.weight}'),
                                                              new Text('سن: ${item.birth}'),
                                                              new Text('بیماری: $_illness'),

                                                            ]
                                                            ,
                                                            )

                                                            )
                                                          ],
                                                        )
                                                        ,
                                                      ),
                                                      new Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                                                        children: <Widget>[
                                                          new FlatButton(onPressed: (){
                                                            Navigator.of(context).push(MaterialPageRoute(builder: (build)=>
                                                            addTraining(item.id)
                                                            ));
                                                          },
                                                              color: Colors.pink,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0)
                                                              ),
                                                              child: new Text('برنامه ورزشی')),
                                                          new FlatButton(onPressed: (){},
                                                              color: Colors.green,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(15.0)
                                                              ),
                                                              child: new Text('برنامه غذایی'))


                                                        ],
                                                      )


                                                      //End Row 2
                                                    ],
                                                  )
                                                ),
                                              );
                                            })),
                                    new Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade900,

                                      ),
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new IconButton(icon: Icon(Icons.arrow_back,

                                          ), onPressed: null,),
                                          new Text(_pageSize.toString()),
                                          new IconButton(icon: Icon(Icons.arrow_forward), onPressed: null),


                                        ],
                                      ),
                                    )
                                  ],
                                );
                            }
                          })
                      ),
                ),

                custWidgets.buildTopHeader(
                    'لیست انتظار', true, true, _globalKey)
              ],
            )));
  }

}
