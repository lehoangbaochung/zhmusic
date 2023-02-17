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
        onPressed: () {
          songs.value = library.where(
            (song) {
              final syntax = syntaxEditingController.text.toLowerCase();
              return song.id == syntax || song.getName(MusicLanguage.vi).toLowerCase().contains(syntax);
            },
          );
        },
      ),
      expandChild: TextField(
        controller: syntaxEditingController,
        onSubmitted: (_) {
          songs.value = library.where(
            (song) {
              final syntax = syntaxEditingController.text.toLowerCase();
              return song.id == syntax || song.getName(MusicLanguage.vi).toLowerCase().contains(syntax);
            },
          );
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
          hintText: songs.value.random.getName(MusicLanguage.vi),
          hintStyle: context.bodyTextStyle,
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
        builder: (context, songs, child) {
          return songs.isEmpty
              ? Text(
                  'Không tìm thấy bài hát nào phù hợp',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.labelTextStyle,
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs.elementAt(index);
                    return InkWell(
                      child: Tooltip(
                        message: song.getName(MusicLanguage.vi),
                        child: SizedBox.square(
                          dimension: context.songBarHeight,
                          child: Image.network(
                            fit: BoxFit.cover,
                            song.getImageUrl(
                              YoutubeThumbnail.hqdefault,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        context.showHorizontalDialog(
                          HorizontalSongDialog(song, 0),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
