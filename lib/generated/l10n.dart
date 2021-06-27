// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Todo`
  String get appName {
    return Intl.message(
      'Todo',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Create Todo`
  String get create_todo {
    return Intl.message(
      'Create Todo',
      name: 'create_todo',
      desc: '',
      args: [],
    );
  }

  /// `Update Todo`
  String get update_todo {
    return Intl.message(
      'Update Todo',
      name: 'update_todo',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Time: `
  String get alarm_time {
    return Intl.message(
      'Alarm Time: ',
      name: 'alarm_time',
      desc: '',
      args: [],
    );
  }

  /// `Please input title`
  String get title_hint {
    return Intl.message(
      'Please input title',
      name: 'title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please input content`
  String get content_hint {
    return Intl.message(
      'Please input content',
      name: 'content_hint',
      desc: '',
      args: [],
    );
  }

  /// `tips`
  String get tips {
    return Intl.message(
      'tips',
      name: 'tips',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete todo?`
  String get delete_todo_message {
    return Intl.message(
      'Confirm delete todo?',
      name: 'delete_todo_message',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete image?`
  String get delete_image_message {
    return Intl.message(
      'Confirm delete image?',
      name: 'delete_image_message',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Click to select image`
  String get select_image {
    return Intl.message(
      'Click to select image',
      name: 'select_image',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Album`
  String get album {
    return Intl.message(
      'Album',
      name: 'album',
      desc: '',
      args: [],
    );
  }

  /// `You have a todo in five minutes!`
  String get notification_title {
    return Intl.message(
      'You have a todo in five minutes!',
      name: 'notification_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
