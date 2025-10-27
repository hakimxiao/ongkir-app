class Province {
  String? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  static List<Province> fromJsonList(List list) {
    if (list.isEmpty) return List<Province>.empty();
    return list.map((item) => Province.fromJson(item)).toList();
  }
}
