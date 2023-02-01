import 'package:json_annotation/json_annotation.dart';

part 'pet.g.dart';

@JsonSerializable()
class Pet {
  Pet(
    this.id,
    this.name,
    this.breed,
    this.age,
    this.distance,
    this.image,
    this.gender,
    this.origin,
    this.summary,
  );

  final int id;
  final String name;
  final String breed;
  final String age;
  final String distance;
  final String image;
  final String gender;
  final String origin;
  final String summary;

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);
  Map<String, dynamic> toJson() => _$PetToJson(this);
}
