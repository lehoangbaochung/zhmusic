import 'package:flutter/material.dart';
import 'package:television/pages/horivertical/horivertical_page.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

import '../horizontal_secondary_tile.dart';
import 'horizontal_subtitle_dialog.dart';

class HorizontalPlayerDialog extends StatelessWidget {
  const HorizontalPlayerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.play_circle,
        label: 'Trình phát',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: Row(
        children: [
          Expanded(
            child: HorizontalSecondaryTile.icon(
              icon: Icons.volume_up,
              label: 'Âm lượng',
              onPressed: () {
                context.showHorizontalDialog(
                  const HorizontalVolumeDialog(),
                );
              },
            ),
          ),
          Expanded(
            child: HorizontalSecondaryTile.icon(
              icon: Icons.skip_previous,
              label: 'Bài trước',
              onPressed: null,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: player.playingStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final playing = snapshot.requireData;
                  return HorizontalSecondaryTile.icon(
                    icon: playing ? Icons.pause : Icons.play_arrow,
                    label: playing ? 'Tạm dừng' : 'Phát',
                    onPressed: () async {
                      if (playing) {
                        await player.pause();
                      } else {
                        await player.play();
                      }
                    },
                  );
                }
                return centeredLoadingIndicator;
              },
            ),
          ),
          Expanded(
            child: HorizontalSecondaryTile.icon(
              icon: Icons.skip_next,
              label: 'Bài sau',
              onPressed: () => context.horiverticalCubit.next(),
            ),
          ),
          Expanded(
            child: HorizontalSecondaryTile.icon(
              icon: Icons.subtitles,
              label: 'Phụ đề',
              onPressed: () async {
                context.showHorizontalDialog(
                  const HorizontalSubtitleDialog(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
