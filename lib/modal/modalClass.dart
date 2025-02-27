class ModalClass {
  late String name, url;
  int? id;


  ModalClass({this.id, required this.name, required this.url});

  factory ModalClass.fromMap(Map m1) {
    return ModalClass(name: m1['name'], url: m1['url'], id: m1['id']);
  }

  static Map<String, Object?> toMap(ModalClass items)
  {
    return {
      'id':items.id,
      'name':items.name,
      'url':items.url,
    };
  }
}
