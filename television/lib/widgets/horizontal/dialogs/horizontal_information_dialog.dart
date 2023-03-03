import 'package:flutter/material.dart';
import 'package:src/exports/widgets.dart';

import '/app/app_storage.dart';
import '/pages/horizontal/horizontal_dialog.dart';
import '/pages/horizontal/horizontal_widget.dart';

class HorizontalInformationDialog extends StatelessWidget {
  const HorizontalInformationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final informations = appStorage.instance.informations;
    return HorizontalDialog(
      leading: HorizontalElevatedButton(
        icon: Icons.view_headline,
        label: 'Thông tin',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: ListView.builder(
        itemCount: informations.length,
        itemBuilder: (context, index) {
          final information = informations.elementAt(index);
          return ListTile(
            title: Text(
              information,
              style: context.textTheme.bodyMedium,
            ),
          );
        },
      ),
    );
  }
}
