class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  static List<City> fromJsonList(List list) {
    if (list.isEmpty) return List<City>.empty();
    return list.map((item) => City.fromJson(item)).toList();
  }
}
