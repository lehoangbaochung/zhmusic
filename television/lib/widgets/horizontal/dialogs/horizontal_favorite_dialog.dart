part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalFavoriteDialog extends StatelessWidget {
  const HorizontalFavoriteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog.normal(
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
      child: FutureBuilder(
        future: appStorage.getFavoriteSongs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final songs = snapshot.requireData;
            return songs.isEmpty
                ? Text(
                    'Hiện không có bài hát nào trong danh sách này',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.labelTextStyle,
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs.elementAt(index);
                      return IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: context.songBarHeight,
                        tooltip: song.getName(MusicLanguage.vi),
                        onPressed: () async {},
                        icon: SizedBox.square(
                          dimension: context.songBarHeight,
                          child: Image.network(
                            fit: BoxFit.cover,
                            song.getImageUrl(
                              YoutubeThumbnail.hqdefault,
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }
          return placeholder;
        },
      ),
    );
  }
}
