class TrainHeader {
  List<Trains> trains;

  TrainHeader({this.trains});

  TrainHeader.fromJson(Map<String, dynamic> json) {
    if (json['trains'] != null) {
      trains = new List<Trains>();
      json['trains'].forEach((v) {
        trains.add(new Trains.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trains != null) {
      data['trains'] = this.trains.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trains {
  int id;
  String name;
  String parent;

  Trains({this.id, this.name, this.parent});

  Trains.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    return data;
  }
}

class SubTrains {
  int id;
  String name;
  String parent;
  List<SubTrainsChilds> children;

  SubTrains({this.id, this.name, this.parent, this.children});

  SubTrains.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    if (json['children'] != null) {
      children = new List<SubTrainsChilds>();
      json['children'].forEach((v) {
        children.add(new SubTrainsChilds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubTrainsChilds {
  int id;
  String name;
  String parent;

  SubTrainsChilds({this.id, this.name, this.parent});

  SubTrainsChilds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    return data;
  }
}



