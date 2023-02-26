import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:television/app/app_storage.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalSubtitleDialog extends StatelessWidget {
  const HorizontalSubtitleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.horizontalCubit;
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
                cubit.changeSubtitleLanguage(null);
                await appStorage.setSubtitleLanguage(null);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.language,
              label: 'Tiếng Việt',
              onPressed: () async {
                Navigator.pop(context);
                cubit.changeSubtitleLanguage(MusicLanguage.vi);
                await appStorage.setSubtitleLanguage(MusicLanguage.vi);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.language,
              label: 'Bính âm',
              onPressed: () async {
                Navigator.pop(context);
                cubit.changeSubtitleLanguage(MusicLanguage.zh);
                await appStorage.setSubtitleLanguage(MusicLanguage.zh);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.language,
              label: 'Tiếng Trung (Giản thể)',
              onPressed: () async {
                Navigator.pop(context);
                cubit.changeSubtitleLanguage(MusicLanguage.zhHans);
                await appStorage.setSubtitleLanguage(MusicLanguage.zhHans);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.language,
              label: 'Tiếng Trung (Phồn thể)',
              onPressed: () async {
                Navigator.pop(context);
                cubit.changeSubtitleLanguage(MusicLanguage.zhHant);
                await appStorage.setSubtitleLanguage(MusicLanguage.zhHant);
              },
            ),
          ),
        ],
      ),
    );
  }
}
