class CatEntity {
  String id;
  String name;
  String origin;

  CatEntity({
    required this.id,
    required this.name,
    required this.origin,
  });

  factory CatEntity.fromJson(Map json) {
    return CatEntity(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
    );
  }

  @override
  String toString() {
    return 'Cat: {id: $id, name: $name, origin: $origin}';
  }
}
