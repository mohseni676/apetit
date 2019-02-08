import 'package:flutter/material.dart';
import 'package:path/path.dart';

Widget buildTopHeader(String title,bool hasBack,bool hasMenu,GlobalKey<ScaffoldState> key) {
  List<Widget> _w=[];
  _w.add(new IconButton(icon: Icon(Icons.menu, size: 32.0, color: Colors.white),onPressed:()=>key.currentState.openDrawer() ));
  _w.add(new Expanded(
  child: new Padding(
  padding: const EdgeInsets.only(right: 8.0),
  child: new Text(
  title,
  style: new TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.w300),
  ),
  ),
  ));
  if (hasBack)
  _w.add(new IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.white), onPressed: ()=>Navigator.pop(key.currentContext)));
  return new Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
    child: new Row(
      children: _w,
    ),
  );
}

Widget globalDrawer(GlobalKey<ScaffoldState> key){

  return new Container(

    decoration: BoxDecoration(

      image: DecorationImage(image: AssetImage('assets/images/drawer-back.jpg'),
      fit: BoxFit.cover,


      ),


    ),
    padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 5.0),
    child: new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new IconButton(icon: Icon(Icons.close,
            color: Colors.white,

            ), onPressed: ()=>Navigator.pop(key.currentContext),
            iconSize: 35.0,
            )
          ],

        ),
        new Container(

          padding: EdgeInsets.all(5.0),



          child: Column(
            children: <Widget>[
              new Text('منوی اصلی',
                style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white70,
                    //decoration: TextDecoration.underline

                ),

              ),
              new Padding(padding: EdgeInsets.all(18.0)),
              new GestureDetector(
                onTap: null,
                child: new Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Colors.black26.withOpacity(0.5),
                    
                  ),
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.exit_to_app,
                      color: Colors.white,
                        size: 35.0,
                      ),
                      new Padding(padding: EdgeInsets.all(12.0)),
                      new Text('خروج از نرم افزار',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                      )

                    ],
                  ),
                ),
              ),
              new GestureDetector(
                onTap: null,
                child: new Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Colors.black26.withOpacity(0.5),

                  ),
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.exit_to_app,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      new Padding(padding: EdgeInsets.all(12.0)),
                      new Text('خروج از نرم افزار',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),
                      )

                    ],
                  ),
                ),
              ),
              new GestureDetector(
                onTap: null,
                child: new Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Colors.black26.withOpacity(0.5),

                  ),
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.exit_to_app,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      new Padding(padding: EdgeInsets.all(12.0)),
                      new Text('خروج از نرم افزار',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),
                      )

                    ],
                  ),
                ),
              ),

            ],
          ),

        )
      ],
    )
  );
}