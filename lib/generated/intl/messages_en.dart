// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alarm_time": MessageLookupByLibrary.simpleMessage("Alarm Time: "),
        "album": MessageLookupByLibrary.simpleMessage("Album"),
        "appName": MessageLookupByLibrary.simpleMessage("Todo"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "content_hint":
            MessageLookupByLibrary.simpleMessage("Please input content"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "create_todo": MessageLookupByLibrary.simpleMessage("Create Todo"),
        "delete_image_message":
            MessageLookupByLibrary.simpleMessage("Confirm delete image?"),
        "delete_todo_message":
            MessageLookupByLibrary.simpleMessage("Confirm delete todo?"),
        "notification_title": MessageLookupByLibrary.simpleMessage(
            "You have a todo in five minutes!"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "select_image":
            MessageLookupByLibrary.simpleMessage("Click to select image"),
        "tips": MessageLookupByLibrary.simpleMessage("tips"),
        "title_hint":
            MessageLookupByLibrary.simpleMessage("Please input title"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "update_todo": MessageLookupByLibrary.simpleMessage("Update Todo")
      };
}
