part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalVoteDialog extends StatelessWidget {
  const HorizontalVoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final songs = context.horiverticalState.library.shuffled;
    return HorizontalDialog(
      leading: HorizontalElevatedButton(
        icon: Icons.how_to_vote,
        label: 'Bình chọn',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) => HorizontalSongTile(songs.elementAt(index)),
      ),
    );
  }
}
