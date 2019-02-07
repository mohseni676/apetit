class apprenticesClass {
  List<Data> data;
  Links links;
  Meta meta;
  bool success;

  apprenticesClass({this.data, this.links, this.meta, this.success});

  apprenticesClass.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int periodId;
  Null description;
  int sessions;
  int price;
  User user;
  List<Targets> targets;
  int sessionsApprentice;

  Data(
      {this.periodId,
        this.description,
        this.sessions,
        this.price,
        this.user,
        this.targets,
        this.sessionsApprentice});

  Data.fromJson(Map<String, dynamic> json) {
    periodId = json['period_id'];
    description = json['description'];
    sessions = json['sessions'];
    price = json['price'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['targets'] != null) {
      targets = new List<Targets>();
      json['targets'].forEach((v) {
        targets.add(new Targets.fromJson(v));
      });
    }
    sessionsApprentice = json['sessionsApprentice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period_id'] = this.periodId;
    data['description'] = this.description;
    data['sessions'] = this.sessions;
    data['price'] = this.price;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.targets != null) {
      data['targets'] = this.targets.map((v) => v.toJson()).toList();
    }
    data['sessionsApprentice'] = this.sessionsApprentice;
    return data;
  }
}

class User {
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

  User(
      {this.id,
        this.name,
        this.family,
        this.avatar,
        this.weight,
        this.height,
        this.birthday,
        this.birth,
        this.bmi,
        this.illness});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    family = json['family'];
    avatar = json['avatar'];
    weight = json['weight'];
    height = json['height'];
    birthday = json['birthday'];
    birth = json['birth'];
    bmi = json['bmi'];
    illness = json['illness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['family'] = this.family;
    data['avatar'] = this.avatar;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['birthday'] = this.birthday;
    data['birth'] = this.birth;
    data['bmi'] = this.bmi;
    data['illness'] = this.illness;
    return data;
  }
}

class Targets {
  String title;
  String name;
  int value;
  String description;
  int type;

  Targets({this.title, this.name, this.value, this.description, this.type});

  Targets.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    value = json['value'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['value'] = this.value;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}

class Links {
  String first;
  String last;
  Null prev;
  Null next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}