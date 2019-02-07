import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apetit/classes/globals.dart' as globals;
import 'package:apetit/classes/apprentices.dart';
import 'package:async/async.dart';
import 'package:apetit/pages/waiting_user_page.dart';

class waitingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new waitingPageState();
  }
}
class waitingPageState extends State<waitingPage> {
    apprentices _apprS= new apprentices();
   Future<apprentices> _apprenticeList(String _token,int _page) async {
   try{ var response = await http.post('${globals.ServerAddress}/api/v1/coach/apprentice?page=${_page}',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        },
        body: {
          'status':'0'
        }
    );
    if (response.statusCode == 200) {
      var x = json.decode(response.body);
      _apprS=apprentices.fromJson(x);

      debugPrint(_apprS.data[0].user.name);
      return _apprS;

    }else{
      debugPrint('خطا اطلاعاتی');
    }}
    catch (e){
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
    return
        new Directionality(textDirection: TextDirection.rtl,
            child:       new Scaffold(
              appBar: new AppBar(
                title: new Text('لیست انتظار'),

              ),
              body:
              new Center(
                  child:
                  new FutureBuilder(
                      future: _apprenticeList(globals.token, 1) ,
                      builder: (BuildContext context,AsyncSnapshot snapshot){
                        switch(snapshot.connectionState){
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Text('Loading');

                          default:
                          //return Text('ok');
                            apprentices ls=snapshot.data;
                            return new ListView.builder(
                                itemCount: ls.data.length,
                                itemBuilder: (BuildContext context,int index){
                                  return new Card(

                                   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0),

                                   ),
                                    child:new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            new Container(

                                              decoration: BoxDecoration(

                                                shape: BoxShape.circle,
                                                //borderRadius: ,
                                                border: Border.all(color: Colors.black45,width: 2.0,style: BorderStyle.solid),
                                                image: new DecorationImage(image: NetworkImage(ls.data[index].user.avatar,

                                                )
                                                ),
                                                //borderRadius: BorderRadius.circular(15.0),

                                              ),
                                              height: 55.0,
                                              width: 55.0,
                                            ),
                                            new Padding(padding: EdgeInsets.only(left: 10.0)),
                                            new Text('${ls.data[index].user.name} ${ls.data[index].user.family}',
                                            textDirection: TextDirection.ltr,
                                            ),
                                          ],
                                        ),
                                        new Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            new IconButton(icon: Icon(Icons.lock), onPressed: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (build)=>waiting_user(snapshot.data,index)));
                                            },),
                                            new IconButton(icon: Icon(Icons.track_changes), onPressed: (){}),
                                          ],

                                        )
                                      ],
                                    ) ,
                                  );
                                });


                        }

                      })
                //new Text('test'),
                /*new FutureBuilder<apprenticesClass>(
          future: _apprenticeList(globals.token, 1),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.active:
              case ConnectionState.active:
                new Text('Data is Loding');
                break;
              case ConnectionState.none:
                new Text('No Connection');
                break;

              case ConnectionState.done:
                if (snapshot.hasError)
                  new Text('Error ${snapshot.error}');

                new Text('ok');


            }
          }
        )*/
              ),
            )
        );
  }
}