import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:images_picker/images_picker.dart';
import 'package:todo_app/generated/l10n.dart';

class ActionSheetImage {
  String path = '';

  ActionSheetImage(this.path);
}

class ActionSheet {
  static void selectImage(
    BuildContext context, {
    int max = 1,
    bool crop = false,
    required Function(List<ActionSheetImage>) onSelected,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text(S.of(context).tips),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                S.of(context).camera,
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () async {
                Navigator.pop(context);
                List<ActionSheetImage> list = await pickImages(
                  max,
                  camera: true,
                  crop: crop,
                );
                onSelected.call(list);
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                S.of(context).album,
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () async {
                Navigator.pop(context);
                List<ActionSheetImage> list = await pickImages(
                  max,
                  camera: false,
                  crop: crop,
                );

                onSelected.call(list);
              },
            ),
            CupertinoActionSheetAction(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.pop(context);
              },
              isDestructiveAction: true,
            ),
          ],
        );
      },
    );
  }

  static Future<List<ActionSheetImage>> pickImages(
    int count, {
    bool camera = false,
    bool crop = false,
  }) async {
    Future<List<ActionSheetImage>> convertImages(List<Media> list) async {
      List<ActionSheetImage> result = [];
      for (var image in list) {
        try {
          result.add(ActionSheetImage(image.path));
        } catch (e) {}
      }
      return result;
    }

    try {
      var cropOpt = crop
          ? CropOption(
              aspectRatio: CropAspectRatio(1, 1),
              cropType: CropType.rect,
            )
          : null;
      if (camera) {
        List<Media> result = (await ImagesPicker.openCamera(
              quality: 0.8,
              pickType: PickType.image,
              language: Language.Chinese,
              cropOpt: cropOpt,
              maxSize: 1000,
            )) ??
            [];
        return await convertImages(result);
      } else {
        List<Media> result = (await ImagesPicker.pick(
              count: count,
              pickType: PickType.image,
              quality: 0.8,
              language: Language.Chinese,
              cropOpt: cropOpt,
              maxSize: 1000,
            )) ??
            [];
        return await convertImages(result);
      }
    } catch (e) {}
    return [];
  }
}
