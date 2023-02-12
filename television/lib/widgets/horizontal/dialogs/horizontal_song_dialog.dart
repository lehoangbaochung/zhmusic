part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalSongDialog extends StatelessWidget {
  const HorizontalSongDialog(
    this.song,
    this.vote, {
    super.key,
  });

  final int vote;
  final YoutubeMusic song;

  @override
  Widget build(BuildContext context) {
    return HorizontalBottomSheet.expand(
      expandLeading: HorizontalOutlinedButton.small(
        label: song.id,
        icon: Icons.code,
        onPressed: () {},
      ),
      expandTrailing: HorizontalOutlinedButton.small(
        label: '$vote',
        icon: Icons.how_to_vote,
        onPressed: () {},
      ),
      expandChild: FutureBuilder(
        future: song.getArtists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final artists = snapshot.requireData;
            return ColoredBox(
              color: AppColors.primaryColor,
              child: Text(
                artists.isEmpty ? song.getName(MusicLanguage.vi) : '${song.getName(MusicLanguage.vi)} - ${artists.getName(MusicLanguage.vi)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }
          return placeholder;
        },
      ),
      leading: HorizontalElevatedButton(
        icon: Icons.music_note,
        label: 'Bài hát',
        onPressed: () => Navigator.pop(context),
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
              icon: Icons.how_to_vote,
              label: 'Bình chọn',
              onPressed: () {
                Navigator.pop(context);
                context.mainCubit.vote(song);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.favorite,
              label: 'Yêu thích',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.share,
              label: 'Chia sẻ',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
