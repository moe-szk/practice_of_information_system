// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int,
      userName: json['userName'] as String,
      status: json['status'] as int,
      stapleValue: json['stapleValue'] as int,
      mainValue: json['mainValue'] as int,
      sideValue: json['sideValue'] as int,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'status': instance.status,
      'stapleValue': instance.stapleValue,
      'mainValue': instance.mainValue,
      'sideValue': instance.sideValue,
    };
