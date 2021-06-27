// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alarm_time": MessageLookupByLibrary.simpleMessage("提醒时间："),
        "album": MessageLookupByLibrary.simpleMessage("相册"),
        "appName": MessageLookupByLibrary.simpleMessage("待办"),
        "camera": MessageLookupByLibrary.simpleMessage("相机"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "content_hint": MessageLookupByLibrary.simpleMessage("请输入内容"),
        "create": MessageLookupByLibrary.simpleMessage("添加"),
        "create_todo": MessageLookupByLibrary.simpleMessage("新建待办"),
        "delete_image_message":
            MessageLookupByLibrary.simpleMessage("确认删除照片吗？"),
        "delete_todo_message":
            MessageLookupByLibrary.simpleMessage("确认删除Todo吗?"),
        "notification_title":
            MessageLookupByLibrary.simpleMessage("5分钟后你有一个待办!"),
        "ok": MessageLookupByLibrary.simpleMessage("确定"),
        "select_image": MessageLookupByLibrary.simpleMessage("点击选择照片"),
        "tips": MessageLookupByLibrary.simpleMessage("提示"),
        "title_hint": MessageLookupByLibrary.simpleMessage("请输入标题"),
        "update": MessageLookupByLibrary.simpleMessage("更新"),
        "update_todo": MessageLookupByLibrary.simpleMessage("更新待办")
      };
}
