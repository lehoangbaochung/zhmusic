part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalVoteDialog extends StatelessWidget {
  const HorizontalVoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final syntaxEditingController = TextEditingController();
    final library = context.playerState.library.shuffled;
    final songs = ValueNotifier(library);
    return HorizontalDialog.expand(
      expandLeading: HorizontalOutlinedButton.small(
        label: 'Từ khóa',
        icon: Icons.keyboard,
        onPressed: () {},
      ),
      expandTrailing: HorizontalOutlinedButton.small(
        label: 'Tìm kiếm',
        icon: Icons.search,
        onPressed: () async {
          final results = <YoutubeMusic>[];
          final syntax = syntaxEditingController.text.trim().toLowerCase();
          for (final song in library) {
            final artists = await song.getArtists();
            final songName = song.getName(MusicLanguage.vi).toLowerCase();
            final artistsName = artists.getName(MusicLanguage.vi).toLowerCase();
            if (songName.contains(syntax) || artistsName.contains(syntax)) {
              results.add(song);
            }
          }
          songs.value = results;
        },
      ),
      expandChild: TextField(
        controller: syntaxEditingController,
        onSubmitted: (value) async {
          final results = <YoutubeMusic>[];
          final syntax = syntaxEditingController.text.trim().toLowerCase();
          for (final song in library) {
            final artists = await song.getArtists();
            final songName = song.getName(MusicLanguage.vi).toLowerCase();
            final artistsName = artists.getName(MusicLanguage.vi).toLowerCase();
            if (songName.contains(syntax) || artistsName.contains(syntax)) {
              results.add(song);
            }
          }
          songs.value = results;
        },
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.mediaHeight / 48,
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.mediaWidth / 64,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaWidth / 256,
            ),
            child: Icon(
              Icons.edit,
              size: context.iconSize,
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaWidth / 256,
            ),
            child: InkWell(
              onTap: () {
                songs.value = library;
                syntaxEditingController.clear();
              },
              child: Icon(
                Icons.clear,
                size: context.iconSize,
              ),
            ),
          ),
          hintMaxLines: 1,
          hintStyle: context.bodyTextStyle,
          hintText: songs.value.random.getName(MusicLanguage.vi),
        ),
      ),
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
      child: ValueListenableBuilder(
        valueListenable: songs,
        child: Text(
          'Không tìm thấy bài hát nào phù hợp',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: context.labelTextStyle,
        ),
        builder: (context, songs, child) {
          return songs.isEmpty
              ? child!
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return HorizontalSongTile(
                      songs.elementAt(index),
                    );
                  },
                );
        },
      ),
    );
  }
}
