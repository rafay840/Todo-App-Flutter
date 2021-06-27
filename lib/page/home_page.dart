import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/manager/todo_manager.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/page/component/todo_cell.dart';
import 'package:todo_app/utils/navigator_utils.dart';
import 'package:todo_app/widget/tscaffold.dart';

import 'todo_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final int initialPage = 1;

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<Todo> _todos = [];
  int _page = initialPage;
  int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    initNotifications();
  }

  void initNotifications() {}

  @override
  Widget build(BuildContext context) {
    return TScaffold(
      name: S.of(context).appName,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _didClickAddButton,
        label: Text(S.of(context).create),
        icon: Icon(Icons.add),
      ),
      child: SafeArea(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: true,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          child: ListView.separated(
            itemBuilder: (_, i) => TodoCell(
              todo: _todos[i],
              onPressed: _didClickTodo,
              onCheckboxChanged: _didClickTodoCheckbox,
            ),
            separatorBuilder: (_, i) => Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
              margin: EdgeInsets.only(left: 12),
            ),
            itemCount: _todos.length,
          ),
        ),
      ),
    );
  }

  Future _onLoadData({required bool isReset}) async {
    if (isReset) {
      _todos = [];
      _page = initialPage;
      _refreshController.resetNoData();
    }
    var list = await TodoManager.list(page: _page, pageSize: _pageSize);
    _todos.addAll(list);
    _page += 1;
    if (mounted) setState(() {});

    if (isReset) _refreshController.refreshCompleted();

    if (list.length < _pageSize) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  Future _onRefresh() => _onLoadData(isReset: true);

  Future _onLoading() => _onLoadData(isReset: false);

  void _didClickTodoCheckbox(Todo todo, bool isSelected) async {
    todo.finishedTimeStamp =
        isSelected ? 0 : DateTime.now().millisecondsSinceEpoch;
    await TodoManager.update(todo);
    setState(() {});
  }

  void _didClickTodo(Todo todo) {
    NavigatorUtils.present(
      context,
      page: TodoPage(todo: todo),
    ).then((value) {
      if (value == null) return;
      _refreshController.requestRefresh();
    });
  }

  void _didClickAddButton() async {
    NavigatorUtils.present(
      context,
      page: TodoPage(),
    ).then(
      (value) {
        if (value == null) return;
        _refreshController.requestRefresh();
      },
    );
  }
}
