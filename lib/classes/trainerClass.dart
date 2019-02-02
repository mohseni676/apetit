class trainer{
  int id;
  String name;
  String family;
  String avatar;
  int privilege;
  int status;
  String code;
  dashboard dash;

  trainer({this.id, this.name, this.family, this.avatar, this.privilege,
      this.status, this.code, this.dash});
  factory trainer.fromJson(Map<String , dynamic> json){
    return trainer(
      id: json['id'],
      name: json['name'],
      family: json['family'],
      avatar: json['avatar'],
      code: json['code']
    );
  }

}

class dashboard{
  int id;
  int user_id;
  int waiting;
  int apperentice;
  int messages;
  int money;
  int excercises;
  int feeding;

}

/*
{
    "id": 14,
    "name": "محسن",
    "family": "رضوانفر",
    "avatar": "http://92.50.34.37/uploads/2/2018-12/9.jpg",
    "privilege": 3,
    "status": 0,
    "code": "mohsen01",
    "dashboard": null
}*/