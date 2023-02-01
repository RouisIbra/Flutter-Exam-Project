// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      json['id'] as int,
      json['name'] as String,
      json['breed'] as String,
      json['age'] as String,
      json['distance'] as String,
      json['image'] as String,
      json['gender'] as String,
      json['origin'] as String,
      json['summary'] as String,
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'breed': instance.breed,
      'age': instance.age,
      'distance': instance.distance,
      'image': instance.image,
      'gender': instance.gender,
      'origin': instance.origin,
      'summary': instance.summary,
    };
