// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_History _$$_HistoryFromJson(Map<String, dynamic> json) => _$_History(
      id: json['id'] as int,
      userId: json['userId'] as int,
      imageBase64: json['imageBase64'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$_HistoryToJson(_$_History instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'imageBase64': instance.imageBase64,
      'createdAt': instance.createdAt,
    };
