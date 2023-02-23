part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalMenuDialog extends StatelessWidget {
  const HorizontalMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog(
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
            icon: Icons.play_circle,
            label: 'Trình phát',
            onPressed: () {
              context.showHorizontalDialog(
                const HorizontalPlayerDialog(),
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
            icon: Icons.favorite,
            label: 'Yêu thích',
            onPressed: () async {
              context.showHorizontalDialog(
                const HorizontalFavoriteDialog(),
              );
            },
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.chat,
            label: 'Trò chuyện',
            onPressed: null,
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.theater_comedy,
            label: 'Nhãn dán',
            onPressed: null,
          ),
          HorizontalOutlinedButton.large(
            icon: Icons.color_lens,
            label: 'Chủ đề',
            onPressed: () async {
              context.showHorizontalDialog(
                const HorizontalThemeDialog(),
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
