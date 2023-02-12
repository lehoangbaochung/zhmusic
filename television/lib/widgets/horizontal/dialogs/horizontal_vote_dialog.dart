part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalVoteDialog extends StatelessWidget {
  const HorizontalVoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final syntaxEditingController = TextEditingController();
    final library = context.mainState.library.shuffled;
    final songs = ValueNotifier(library);
    return HorizontalBottomSheet.expand(
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
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        onSubmitted: (_) {
          songs.value = library.where(
            (song) {
              final syntax = syntaxEditingController.text.toLowerCase();
              return song.id == syntax || song.getName(MusicLanguage.vi).toLowerCase().contains(syntax);
            },
          );
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          hintMaxLines: 1,
          prefixIcon: const Icon(Icons.edit),
          suffixIcon: IconButton(
            onPressed: () {
              songs.value = library;
              syntaxEditingController.clear();
            },
            icon: const Icon(Icons.clear),
          ),
          hintText: 'Soạn theo cú pháp bình chọn hoặc nhập tên bài hát tại đây... (VD: ZHM Là gió thổi hoặc Là gió thổi)',
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
                  style: context.textTheme.headlineMedium,
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
                        await showModalBottomSheet(
                          context: context,
                          builder: (_) => HorizontalSongDialog(song, 0),
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
