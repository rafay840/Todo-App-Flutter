import 'package:flutter/material.dart';

class TScaffold extends StatefulWidget {
  final String? name;
  final Widget child;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  TScaffold({
    Key? key,
    this.name,
    this.actions,
    this.floatingActionButton,
    required this.child,
  }) : super(key: key);

  @override
  _TScaffoldState createState() => _TScaffoldState();
}

class _TScaffoldState extends State<TScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.name ?? ''),
        actions: widget.actions,
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: widget.child,
    );
  }
}
