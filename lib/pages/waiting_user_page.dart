import 'package:flutter/material.dart';
import 'package:apetit/classes/apprentices.dart';
import 'package:apetit/widgets/cust_widgets.dart' as custWidgets;


class waiting_user extends StatefulWidget{
  apprentices _apprentices=new apprentices();
  int _currentApperenticeId;


  waiting_user(this._apprentices,this._currentApperenticeId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new waiting_user_state(_apprentices,_currentApperenticeId);
  }
  
}

class waiting_user_state extends State<waiting_user> {
  apprentices _apprentices=new apprentices();
  int _currentApperenticeId;
  GlobalKey<ScaffoldState> scaffoldKey =new GlobalKey();
  //apprentices _app=new apprentices();
  User _user=new User();
  Data _userData=new Data();
 // bool expanded = false;
  String _illness='ندارد';
  List<Targets> _targets;


  waiting_user_state(this._apprentices,this._currentApperenticeId);

  //  _user=_apprentices.data[_currentApperenticeId].user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _user=_apprentices.data[_currentApperenticeId].user;
     _userData=_apprentices.data[_currentApperenticeId];
     switch (_apprentices.data[_currentApperenticeId].user.illness)
     {
       case 1:
         _illness='دارد';
         break;
       case 0:
         _illness='ندارد';
         break;
         

     }
     _targets=_apprentices.data[_currentApperenticeId].targets;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(textDirection: TextDirection.rtl,
        child:Builder(builder: (context) => new Scaffold(
          key: scaffoldKey,
          drawer: Drawer(

            child: custWidgets.globalDrawer(scaffoldKey)

          ),

          body: new Stack(


                //fit: StackFit.expand,
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/bgfirst.jpg'),
                      fit: BoxFit.fill,
                      ),


                    ),
                    //height: 350.0,
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 5.0),
                    child: new Column(
                      children: <Widget>[
                        // _headerImage(),
                        custWidgets.buildTopHeader('',true,true,scaffoldKey),


                        _buildProfileRow('${_user.name} ${_user.family}',
                            _user.avatar
                            ,_user.birth
                        ),
                        new Padding(padding: EdgeInsets.all(5.0)),
                        new Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 2.0,
                              color: Colors.white30,
                            ),
                            color: Colors.black.withOpacity(0.5),
                            
                            
                          ),
                          padding: EdgeInsets.fromLTRB(8.0, 2.0, 16.0, 2.0),
                          child:
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Container(

                                  child: new Text('مشخصات فردی ورزشکار',
                                    textScaleFactor: 1.4,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),


                                  ),
                                  padding: EdgeInsets.only(top: 8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 2.0,
                                              color: Colors.white
                                          )
                                      )
                                  ),
                                ),
                                new SizedBox(
                                  height: 3.0,
                                ),

                                new Text('وزن: ${_user.weight}'),
                                new Text('قد: ${_user.height}'),
                                new Text('تاریخ تولد: ${_user.birthday}'),
                                new Text('بیماری: $_illness')

                              ],
                            )
                          ,
                          
                        ),
                        new Padding(padding: EdgeInsets.only(top: 5.0)),
                        new Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 2.0,
                              color: Colors.white30,
                            ),
                            color: Colors.black.withOpacity(0.5),


                          ),
                          padding: EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0.0),
                          //height: 280.0,
                            constraints: BoxConstraints(
                              minHeight: 260.0,
                              maxHeight: 290.0
                            ),

                          
                          child: new
                              Column(

                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  new Container(

                          child: new Text('اهداف تمرینی',
                            textScaleFactor: 1.4,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),


                          ),
                                    padding: EdgeInsets.only(top: 8.0),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 2.0,
                                          color: Colors.white
                                        )
                                      )
                                    ),
                                  ),
                                  new SizedBox(
                                    height: 8.0,
                                  ),
                                  new Expanded(child:
                                  new ListView.builder(
                                    scrollDirection: Axis.vertical,
                                      itemCount: _targets.length,
                                      itemBuilder: (BuildContext context,int index){
                                        return new Card(
                                          child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Row(
                                                children: <Widget>[
                                                  new Padding(padding: EdgeInsets.only(right: 8.0)),
                                                  new Text(_targets[index].name)
                                                ],
                                                
                                              ),
                                              new Row(
                                                mainAxisAlignment: MainAxisAlignment.start,

                                                children: <Widget>[
                                                  new IconButton(icon: Icon(Icons.build), onPressed: (){debugPrint(_user.id.toString());}),
                                                  new IconButton(icon: Icon(Icons.fastfood), onPressed: null)
                                                ],
                                                
                                              )
                                            ],
                                          ),
                                        );
                                      }

                                  ),
                                  ),
                                  //new Text('test')
                                ],
                              )

                        ),






                      ],
                    ),
                  )


                    ],
                  )
                  //new Padding(padding: EdgeInsets.only(top: 65.0)),


                ,
              ),
            )
            ,


        );
  }

  _headerImage() {
    return new ClipPath(
      clipper: new DialogonalClipper(),
    child: Image.asset(
      'assets/images/bgfirst.jpg',
      fit: BoxFit.cover,
      //height: 256,
    )
    );
  }
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    //path.lineTo(0.0, -100.0);
    path.lineTo(0.0, size.height - 260.0);
    path.lineTo(size.width, size.height-360.0);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

}
Widget _buildProfileRow(String fullname,String avatar,int age) {
  return new Padding(
    padding: new EdgeInsets.only(left: 16.0, top: 0.0),
    child: new Row(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(avatar)),
            shape: BoxShape.circle,
          ),
          height: 65.0,
          width: 65.0,
          margin: EdgeInsets.only(left: 15.0,right: 25.0),
        ),
        /*new CircleAvatar(
          minRadius: 28.0,
          maxRadius: 28.0,
          backgroundImage: new AssetImage(avatar),
        )*/
        new Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                fullname,
                style: new TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              new Text(
                'سن: $age',
                style: new TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}