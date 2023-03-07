import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:television/app/app_storage.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';
import 'package:television/widgets/horizontal/horizontal_secondary_tile.dart';

import 'horizontal_theme_dialog.dart';

class HorizontalMenuDialog extends StatelessWidget {
  const HorizontalMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final signedIn = Account.instance == null;
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.menu,
        label: 'Menu',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.close,
        label: 'Đóng',
        onPressed: () => Navigator.pop(context),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HorizontalSecondaryTile.icon(
            icon: Icons.account_circle,
            label: 'Tài khoản',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalAccountDialog(),
              );
            },
          ),
          HorizontalSecondaryTile.icon(
            icon: Icons.play_circle,
            label: 'Trình phát',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalPlayerDialog(),
              );
            },
          ),
          HorizontalSecondaryTile.icon(
            icon: Icons.how_to_vote,
            label: 'Bình chọn',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalVoteDialog(),
              );
            },
          ),
          HorizontalSecondaryTile.icon(
            icon: Icons.favorite,
            label: 'Yêu thích',
            onPressed: () async {
              context.showHorizontalDialog(
                const HorizontalFavoriteDialog(),
              );
            },
          ),
          HorizontalSecondaryTile.icon(
            icon: Icons.chat,
            label: 'Trò chuyện',
            onPressed: signedIn
                ? null
                : () async {
                    await context.showHorizontalDialog(
                      const HorizontalChatDialog(),
                    );
                  },
          ),
          HorizontalSecondaryTile.icon(
            icon: Icons.theater_comedy,
            label: 'Nhãn dán',
            onPressed: signedIn
                ? null
                : () async {
                    await context.showHorizontalDialog(
                      const HorizontalIconDialog(),
                    );
                  },
          ),
          HorizontalSecondaryTile.icon(
            icon: Icons.color_lens,
            label: 'Chủ đề',
            onPressed: () async {
              await context.showHorizontalDialog(
                const HorizontalThemeDialog(),
              );
            },
          ),
          HorizontalSecondaryTile.icon(
            icon: Icons.help,
            label: 'Hướng dẫn',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalHelpDialog(),
              );
            },
          ),
          HorizontalSecondaryTile.icon(
            icon: Icons.info,
            label: 'Giới thiệu',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalAboutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
