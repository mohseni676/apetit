import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apetit/classes/globals.dart' as globals;
import 'package:apetit/classes/apprentices.dart';
import 'package:async/async.dart';
import 'package:apetit/pages/waiting_user_page.dart';
import 'package:apetit/widgets/cust_widgets.dart' as custWidgets;

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

        debugPrint(_apprS.data[0].user.name);
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
                      child: new FutureBuilder(
                          future: _apprenticeList(globals.token, 1),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Text('Loading');

                              default:
                                //return Text('ok');
                                apprentices ls = snapshot.data;
                                return new ListView.builder(
                                    itemCount: ls.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var item = ls.data[index].user;
                                      return new GestureDetector(
                                        onTap:  () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (build) =>
                                                    waiting_user(
                                                        snapshot
                                                            .data,
                                                        index)));
                                      },
                                        child: new Card(
                                          shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  new Container(
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
                                                    '${ls.data[index].user.name} ${ls.data[index].user.family}',

                                                  ),
                                                ],
                                              ),
                                              new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  new Icon(Icons.arrow_forward_ios


                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
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
