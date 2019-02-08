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



  waiting_user_state(this._apprentices,this._currentApperenticeId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Directionality(textDirection: TextDirection.rtl,
        child:Builder(builder: (context) => new Scaffold(
          key: scaffoldKey,
          drawer: Drawer(

            child: custWidgets.globalDrawer(scaffoldKey)

          ),

          body: new Container(
            color: Colors.black45.withOpacity(.5),
            child: new Stack(

              //fit: StackFit.expand,
              children: <Widget>[

                _headerImage(),
                custWidgets.buildTopHeader('',true,true,scaffoldKey),

                _buildProfileRow(_apprentices.data[_currentApperenticeId].user.name+' '+_apprentices.data[_currentApperenticeId].user.family,
                    _apprentices.data[_currentApperenticeId].user.avatar
                    ,18
                )

              ],
            ),
          )
          ),
        ));
  }

  _headerImage() {
    return new ClipPath(
      clipper: new DialogonalClipper(),
    child: Image.asset(
      'assets/images/bgfirst.jpg',
      fit: BoxFit.fitWidth,
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
    path.lineTo(0.0, size.height - 360.0);
    path.lineTo(size.width, size.height-460.0);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

}
Widget _buildProfileRow(String fullname,String avatar,int age) {
  return new Padding(
    padding: new EdgeInsets.only(left: 16.0, top: 365 / 2.5),
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
                    fontSize: 14.0,
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