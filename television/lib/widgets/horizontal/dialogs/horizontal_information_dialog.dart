import 'package:flutter/material.dart';

import '/app/app_storage.dart';
import '/pages/horizontal/horizontal_dialog.dart';
import '/pages/horizontal/horizontal_widget.dart';

class HorizontalInformationDialog extends StatelessWidget {
  const HorizontalInformationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final informations = appStorage.instance.informations;
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.view_headline,
        label: 'Thông tin',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: PageView.builder(
        itemCount: informations.length,
        itemBuilder: (context, index) {
          final information = informations.elementAt(index);
          return Container(
            width: context.songBarWidth,
            height: context.songBarHeight,
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaWidth / 128,
            ),
            child: Center(
              child: Text(
                information,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: context.fontSize,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
