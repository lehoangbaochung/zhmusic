import 'package:flutter/material.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalSubtitleDialog extends StatelessWidget {
  const HorizontalSubtitleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog(
      leading: HorizontalElevatedButton(
        icon: Icons.subtitles,
        label: 'Phụ đề',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: Row(
        children: [
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.subtitles_off,
              label: 'Tắt',
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.language,
              label: 'Tiếng Việt',
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.language,
              label: 'Bính âm',
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.language,
              label: 'Tiếng Trung (Giản thể)',
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.language,
              label: 'Tiếng Trung (Phồn thể)',
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}