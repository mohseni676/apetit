import 'dart:convert';
import 'package:apetit/widgets/cust_widgets.dart' as custWidgets;
import 'package:apetit/classes/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apetit/classes/trains_class.dart';
import 'package:video_player/video_player.dart';

class addTraining extends StatefulWidget {
  int apprenticId;

  addTraining(this.apprenticId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new addTrainingState(apprenticId);
  }
}

class addTrainingState extends State<addTraining> {
  int apprenticId;
  addTrainingState(this.apprenticId);
  String _mySelection;
  String _myChildSelection;
  String _myImageSelection;
  GlobalKey<ScaffoldState> _globalKey=new GlobalKey();

  List<DropdownMenuItem<Trains>> headTags = new List();
  List<DropdownMenuItem<SubTrainsChilds>> childTags=new List();
  Widget _imageRadios=new Text('test');



  Icon _icon=Icon(Icons.play_arrow);

  Future<TrainHeader> _getHeaderTagList(String token) async {
    var response = await http
        .post('${globals.ServerAddress}/api/v1/coach/category', body: {
      "id": "0"
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var responseEdited = '{"trains":' + response.body + '}';
    var jsonresponse = json.decode(responseEdited);
    TrainHeader jsondecode = TrainHeader.fromJson(jsonresponse);

    return jsondecode;
  }

  _createHeadDWlist()  {
    List<DropdownMenuItem<Trains>> headTags = new List();
    _getHeaderTagList(globals.token).then((x){
      setState(() {
        for (Trains i in x.trains) {
          headTags.add(new DropdownMenuItem(
            child: new Text(i.name),
            value: i,
          ));

        }
      });

    });


    return headTags;
  }


  Future<SubTrains> _getHeaderChildList(String token,String id) async{
    var response=await http.post(
        '${globals.ServerAddress}/api/v1/coach/category',
        body: {
          "id":"$id"
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }
    );
    var jsonresponse=json.decode(response.body);
    SubTrains jsondecode=SubTrains.fromJson(jsonresponse);
    return jsondecode;
  }

  _createChildDWlist()  {
    String _catId;
    if (_mySelection==null)
      _catId="0";
    else
      _catId=_mySelection;
    
    List<DropdownMenuItem<SubTrainsChilds>> childTags = new List();
    
    _getHeaderChildList(globals.token, _catId).then((x){
      setState(() {
        for (SubTrainsChilds i in x.children) {
          childTags.add(new DropdownMenuItem(
            child: new Text(i.name),
            value: i,
          ));

        }
      });

    });


    return childTags;
  }

  Future<Workouts> _getWorkoutImages(String token,String id) async{
    var response=await http.post(
        '${globals.ServerAddress}/api/v1/coach/workout',
        body: {
          "id":"$id"
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }
    );
    var jsonresponse=json.decode(response.body);
    Workouts jsondecode=Workouts.fromJson(jsonresponse);
    return jsondecode;
  }





  @override
  void initState() {
    // TODO: implement initState
    //this._getHeaderTagList(globals.token);
    headTags = _createHeadDWlist();
    super.initState();
/*    _controller = VideoPlayerController.network(
        'https://tci1.asset.aparat.com/aparat-video/9e30764ba06e2bd089fdd0153020efe513681805-480p__15621.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });*/
    //this._getHeaderTagList(globals.token);
    //this._mySelection=headTags[0].value.id.toString();
  }

  Widget headDropDown() {
    if (headTags.length>0)
    return DropdownButton(
      hint: new Text('دسته بندی حرکات'),

      items: headTags.map((item) {
        return new DropdownMenuItem(
          child: new Text(item.value.name),
          value: item.value.id.toString(),
        );
      }).toList(),
      onChanged: (newVal) {
        if (newVal != null) {
          debugPrint(newVal);
        }

        setState(() {
          _mySelection = newVal;
          _myChildSelection=null;
          childTags=_createChildDWlist();
        });
      },
      value: _mySelection,
    );
    else
      return new Text('Loading');
  }

  Widget childDropDown() {
    if (childTags.length>0)
      return DropdownButton(
        hint: new Text('لیست حرکات'),

        items: childTags.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.value.name),
            value: item.value.id.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          if (newVal != null) {
            debugPrint(newVal);
          }

          setState(() {
            _myChildSelection = newVal;
            _imageRadios=workoutVideoRadios();
          });
        },
        value: _myChildSelection,
      );
    else
      return new SizedBox(height: 4.0,);
  }

  Widget workoutVideoRadios(){
    if (_myChildSelection!=null)
    return FutureBuilder<Workouts>(
      future: _getWorkoutImages(globals.token, _myChildSelection),
      builder: (context,snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
            case ConnectionState.active:
              return new Text('Images Loading');
          case ConnectionState.none:
            return new Text('No Connection');
          case ConnectionState.done:
            {
              if (!snapshot.hasData)
                return new Text('فیلمی وجود ندارد');
              else{
                var ls=snapshot.data;
                List<Widget> _widgets=new List();
                ls.data.forEach((x){
                  debugPrint(x.title);
                  _widgets.add(
                    new Text(x.title),
/*
                  new GestureDetector(
                    child:
                    new Card(
                      margin: EdgeInsets.all(5.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                                color: Colors.pinkAccent.shade200,
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 3.0
                                )
                            ),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(Icons.play_arrow,
                                  color: Colors.blue,
                                  size: 55.0,

                                ),
                                new Padding(padding: EdgeInsets.all(3.0)),
                                new Text(x.title,textScaleFactor: 2.0,)

                              ],
                            ),
                          )

                        ],
                      ),
                    )
                  )
*/

                  );

                });
                return new ListView(
                  children: _widgets,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(5.0),

                );

              }
            }
        }
      },

    );

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new
        Directionality(textDirection: TextDirection.rtl,
        child:     Scaffold(
          key: _globalKey,
          body:
            new Stack(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/bgfirst.jpg'),
                    fit: BoxFit.cover
                    )
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(8.0 , 55.0, 8.0, 25.0),
                    child:
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        headDropDown(),
                        childDropDown(),
                        _imageRadios,

/*
                        new Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            _controller.value.initialized
                                ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,

                              child: VideoPlayer(_controller,

                              ),
                            )
                                : Container(

                            ),
                            new Center(
                              child:
                              new IconButton(icon: _icon,
                                //color: Colors.black,


                                iconSize:65.0
                                
                                , onPressed:
                                    () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();

                                    _controller.value.isPlaying
                                        ? _icon=Icon(Icons.pause,color: Colors.white.withOpacity(0.5),)
                                        : _icon=Icon(Icons.play_arrow,color: Colors.amber,);


                                  });
                                },

                              )
                              ,
                            )

                          ],
                        )
*/







                      ],
                    ),

                  ),
                ),
                custWidgets.buildTopHeader('', true, true, _globalKey)

              ],
            )
        )
    );
  }
}
