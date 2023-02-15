import 'package:flutter/material.dart';
import 'package:src/exports/widgets.dart';

import '/pages/horizontal/horizontal_widget.dart';

class HorizontalMenuDialog extends StatelessWidget {
  const HorizontalMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalBottomSheet.normal(
      leading: HorizontalElevatedButton(
        icon: Icons.menu,
        label: 'Menu',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.close,
        label: 'Đóng',
        onPressed: () => Navigator.pop(context),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HorizontalOutlinedButton.large(
            icon: Icons.account_circle,
            label: 'Tài khoản',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalAccountDialog(),
              );
            },
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.how_to_vote,
            label: 'Bình chọn',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalVoteDialog(),
              );
            },
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.chat,
            label: 'Trò chuyện',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalChatDialog(),
              );
            },
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.theater_comedy,
            label: 'Nhãn dán',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalIconDialog(),
              );
            },
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.color_lens,
            label: 'Chủ đề',
            onPressed: () async {
              context.showHorizontalDialog(
                HorizontalBottomSheet.normal(
                  leading: HorizontalElevatedButton(
                    icon: Icons.color_lens,
                    label: 'Chủ đề',
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
                          icon: Icons.home,
                          label: 'Mặc định',
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        child: HorizontalOutlinedButton.large(
                          icon: Icons.light_mode,
                          label: 'Sáng',
                          onPressed: () {
                            Navigator.pop(context);
                            context.mainCubit.setThemeMode(true);
                          },
                        ),
                      ),
                      Expanded(
                        child: HorizontalOutlinedButton.large(
                          icon: Icons.dark_mode,
                          label: 'Tối',
                          onPressed: () {
                            Navigator.pop(context);
                            context.mainCubit.setThemeMode(false);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.favorite,
            label: 'Yêu thích',
            onPressed: () async {
              context.showHorizontalDialog(
                HorizontalBottomSheet.normal(
                  leading: HorizontalElevatedButton(
                    icon: Icons.favorite,
                    label: 'Yêu thích',
                    onPressed: () {},
                  ),
                  trailing: HorizontalElevatedButton(
                    icon: Icons.arrow_back,
                    label: 'Quay lại',
                    onPressed: () => Navigator.pop(context),
                  ),
                  child: Text(
                    'Hiện không có bài hát nào trong danh sách này',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.headlineMedium,
                  ),
                ),
              );
            },
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.volume_up,
            label: 'Âm lượng',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalVolumeDialog(),
              );
            },
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.help,
            label: 'Hướng dẫn',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalHelpDialog(),
              );
            },
          ),
          HorizontalOutlinedButton.large(
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
