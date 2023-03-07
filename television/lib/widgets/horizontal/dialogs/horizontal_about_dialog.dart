import 'package:flutter/material.dart';
import 'package:television/app/app_storage.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalAboutDialog extends StatelessWidget {
  const HorizontalAboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.info,
        label: 'Giới thiệu',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: context.mediaHeight / 32,
          horizontal: context.mediaWidth / 128,
        ),
        child: Text(
          appStorage.instance.about,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: context.fontSize),
        ),
      ),
    );
  }
}
