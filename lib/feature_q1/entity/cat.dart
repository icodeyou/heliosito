//@JsonSerializable(createToJson: false)
class CatEntity {
  int id;

  String name;

  String tagline;

  String description;

  //@JsonKey(name: 'image_url')
  String imageUrl;

  CatEntity({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.imageUrl,
  });

  //FIXME
  /*factory CatEntity.fromJson(Map<String, dynamic> json) =>
      _$CatEntityFromJson(json);*/
}
