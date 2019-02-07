class data{
  List<apprentic> apprentics;

  data({this.apprentics});
  factory data.fromjson(List<dynamic> parsed){
    List<apprentic> list=new List<apprentic>();
    list=parsed.map((i)=>apprentic.fromjson(i)).toList();
    return new data(
      apprentics: list,
    );
  }

  }



class apprentic {
  int period_id;
  String description;
  int sessions;
  int price;
  List<User> user;
  List<Targets> targets;

  apprentic({this.period_id, this.description, this.sessions, this.price,
      this.user, this.targets});
  
  factory apprentic.fromjson(Map<String,dynamic> parsedJson){
    var list = parsedJson['targets'] as List;
    print(list.runtimeType);
    List<Targets> fetchedlist=list.map((i)=>Targets.fromjson(i)).toList();
    var list2=parsedJson['user'] as List;
    print(list2.runtimeType);
    List<User> fetchedUsers=list2.map((j)=>User.fromjasom(j)).toList();
    return apprentic(
      period_id: parsedJson['period_id'],
      description: parsedJson['description'],
      sessions: parsedJson['sessions'],
      price: parsedJson['price'],
      user: fetchedUsers ,
      targets: fetchedlist,
    );
  }
}

class User{
  int id;
  String name;
  String family;
  String avatar;
  int weight;
  int height;
  String birthday;
  int birth;
  int bmi;
  int illness;

  User({this.id, this.name, this.family, this.avatar, this.weight, this.height,
      this.birthday, this.birth, this.bmi, this.illness});

  factory User.fromjasom(Map<String,dynamic> parsedJson){
    return User(
      id: parsedJson['id'],
      name: parsedJson['name'],
      family: parsedJson['family'],
      avatar: parsedJson['avatar'],
      weight: parsedJson['weight'],
      height: parsedJson['height'],
      birthday: parsedJson['birthday'],
      birth: parsedJson['birth'],
      bmi: parsedJson['bmi'],
      illness: parsedJson['illness'],

    );
  }

}
class Targets{
  String title;
  String name;
  int value;
  String description;
  int type;

  Targets({this.title, this.name, this.value, this.description, this.type});

  factory Targets.fromjson(Map<String,dynamic> parsedJson){
    return Targets(
    title: parsedJson['title'],
      name: parsedJson['name'],
      value: parsedJson['value'],
      description: parsedJson['description'],
      type: parsedJson['type'],
    );
  }


}