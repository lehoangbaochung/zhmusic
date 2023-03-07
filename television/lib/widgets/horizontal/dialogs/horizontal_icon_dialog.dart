import 'package:flutter/material.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalIconDialog extends StatelessWidget {
  const HorizontalIconDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.theater_comedy,
        label: 'Nhãn dán',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: Text(
        'Tính năng đang được phát triển trong thời gian tới',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: context.fontSize,
        ),
      ),
    );
  }
}
