import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/manager/file_manager.dart';
import 'package:todo_app/manager/todo_manager.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  @JsonKey(name: '_id')
  int id = 0;

  String title = '';
  String content = '';
  String image = '';
  @JsonKey(name: 'alarm_time')
  int alarmTimeStamp = DateTime.now().millisecondsSinceEpoch;
  @JsonKey(name: 'finished_time')
  int finishedTimeStamp = 0;

  @JsonKey(name: 'create_time')
  int createTimeStamp = DateTime.now().millisecondsSinceEpoch;
  @JsonKey(name: 'update_time')
  int updateTimeStamp = 0;

  bool get isFinished => finishedTimeStamp != 0;

  String get absolutePath => image == '' ? '' : FileManager.filePath(image);

  String get alarmTime {
    return formatDate(
      DateTime.fromMillisecondsSinceEpoch(alarmTimeStamp),
      [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn],
    );
  }

  /// tmp path
  ///
  /// if image is empty string, mean delete image
  @JsonKey(ignore: true)
  String? imagePath;

  Todo();

  Todo copy() => Todo.fromJson(this.toJson());

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Future deleteImage({bool justDeleteImage = false}) async {
    var file = File(absolutePath);
    if (file.existsSync()) file.deleteSync();
    image = '';
    if (!justDeleteImage) await TodoManager.update(this);
  }

  Future selectImage(String path, {bool justCopy = false}) async {
    var filename = await FileManager.copyImage(path);
    image = filename;
    if (!justCopy) await TodoManager.update(this);
  }
}

class TodoProvicer extends ChangeNotifier {
  late Todo _todo;

  TodoProvicer(Todo todo) {
    this._todo = todo;
  }

  Todo get todo => _todo;

  void update(Function(Todo) block) {
    block.call(_todo);
    notifyListeners();
  }
}
