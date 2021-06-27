// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo()
    ..id = json['_id'] as int
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..image = json['image'] as String
    ..alarmTimeStamp = json['alarm_time'] as int
    ..finishedTimeStamp = json['finished_time'] as int
    ..createTimeStamp = json['create_time'] as int
    ..updateTimeStamp = json['update_time'] as int;
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'alarm_time': instance.alarmTimeStamp,
      'finished_time': instance.finishedTimeStamp,
      'create_time': instance.createTimeStamp,
      'update_time': instance.updateTimeStamp,
    };
