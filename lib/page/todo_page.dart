import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/manager/todo_manager.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/page/component/image_cell.dart';
import 'package:todo_app/page/image_preview_page.dart';
import 'package:todo_app/utils/action_sheet.dart';
import 'package:todo_app/utils/keyboard_utils.dart';
import 'package:todo_app/utils/navigator_utils.dart';
import 'package:todo_app/widget/tscaffold.dart';

class TodoPage extends StatefulWidget {
  final Todo? todo;
  TodoPage({
    Key? key,
    this.todo,
  }) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  bool get isCreate => widget.todo == null;

  late TodoProvicer _todoProvicer;
  String? alarmTime = '';

  @override
  void initState() {
    super.initState();
    var todo = widget.todo?.copy() ?? Todo();
    todo.imagePath = todo.absolutePath;
    alarmTime = todo.alarmTime;
    _todoProvicer = TodoProvicer(todo);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _todoProvicer),
      ],
      child: TScaffold(
        name: isCreate ? S.of(context).create_todo : S.of(context).update_todo,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _didClickCreateButton,
          label: Text(isCreate ? S.of(context).create : S.of(context).update),
          icon: Icon(Icons.add),
        ),
        actions: isCreate
            ? null
            : [
                IconButton(
                  onPressed: _didClickDeleteButton,
                  icon: Icon(Icons.delete),
                )
              ],
        child: Consumer<TodoProvicer>(
          builder: (context, todoProvicer, child) {
            var todo = todoProvicer.todo;
            return Container(
              padding: EdgeInsets.all(12),
              child: ListView(
                children: [
                  // title
                  TextFormField(
                    initialValue: _todoProvicer.todo.title,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: S.of(context).title_hint,
                    ),
                    onChanged: (v) => todo.title = v,
                  ),
                  // content
                  TextFormField(
                    initialValue: _todoProvicer.todo.content,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: S.of(context).content_hint,
                    ),
                    onChanged: (v) => todo.content = v,
                  ),
                  // alarm time
                  InkWell(
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child:
                          Text('${S.of(context).alarm_time} ${todo.alarmTime}'),
                    ),
                    onTap: _didClickAlarmTime,
                  ),
                  // image
                  ImageCell(
                    todo: todo,
                    onPressed: _didClickSelectImage,
                    onImagePressed: _didClickImage,
                    onDeletePressed: _didClickDeleteImage,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _didClickImage(String path) async {
    KeyboardUtils.hideKeyboard(context);
    NavigatorUtils.present(context,
        page: ImagePreviewPage(path: path, tag: 'image'));
  }

  void _didClickSelectImage(Todo todo) async {
    KeyboardUtils.hideKeyboard(context);
    ActionSheet.selectImage(context, onSelected: (images) {
      if (images.isEmpty) return;
      _todoProvicer.update((todo) => todo.imagePath = images[0].path);
    });
  }

  void _didClickDeleteImage(Todo todo) async {
    KeyboardUtils.hideKeyboard(context);
    var result = await showOkCancelAlertDialog(
      context: context,
      title: S.of(context).tips,
      message: S.of(context).delete_image_message,
      okLabel: S.of(context).ok,
      cancelLabel: S.of(context).cancel,
    );

    if (result == OkCancelResult.ok) {
      _todoProvicer.update((todo) => todo.imagePath = '');
    }
  }

  void _didClickDeleteButton() async {
    KeyboardUtils.hideKeyboard(context);
    var result = await showOkCancelAlertDialog(
      context: context,
      title: S.of(context).tips,
      message: S.of(context).delete_todo_message,
      okLabel: S.of(context).ok,
      cancelLabel: S.of(context).cancel,
    );

    if (result == OkCancelResult.ok) {
      var todo = _todoProvicer.todo;
      await TodoManager.delete(todo);
      Navigator.of(context).pop(todo);
    }
  }

  void _didClickAlarmTime() {
    KeyboardUtils.hideKeyboard(context);
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      currentTime: DateTime.fromMillisecondsSinceEpoch(
          _todoProvicer.todo.alarmTimeStamp),
      onChanged: (date) {},
      onConfirm: (date) {
        _todoProvicer.update(
            (todo) => todo.alarmTimeStamp = date.millisecondsSinceEpoch);
      },
    );
  }

  void _didClickCreateButton() async {
    KeyboardUtils.hideKeyboard(context);
    var todo = _todoProvicer.todo;
    if (todo.imagePath == '') await todo.deleteImage(justDeleteImage: true);
    if (todo.imagePath != '' && todo.imagePath != null)
      await todo.selectImage(todo.imagePath!, justCopy: true);
    if (isCreate) {
      await TodoManager.add(todo);
    } else {
      await TodoManager.update(todo, isUpdateTime: alarmTime != todo.alarmTime);
    }
    Navigator.of(context).pop(todo);
  }
}
