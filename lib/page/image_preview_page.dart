import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImagePreviewPage extends StatefulWidget {
  final String tag;
  final String path;
  ImagePreviewPage({
    Key? key,
    required this.path,
    required this.tag,
  }) : super(key: key);

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Hero(
        tag: widget.tag,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.file(File(widget.path)),
                ),
              ),
              Positioned(
                left: 10,
                top: 5 + MediaQuery.of(context).padding.top,
                child: InkWell(
                  onTap: _didClickCloseButton,
                  child: Icon(Icons.close, color: Colors.grey, size: 24),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _didClickCloseButton() {
    Navigator.of(context).pop();
  }
}
