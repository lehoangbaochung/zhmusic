import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';

class LyricPage extends StatelessWidget {
  const LyricPage(this.audio, {super.key});

  final Audio audio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListTile(
          textColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          title: Text(
            audio.getName(MusicLanguage.vi),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: FutureBuilder(
            future: audio.getArtists(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final artists = snapshot.requireData;
                return Text(
                  artists.getName(MusicLanguage.vi),
                  overflow: TextOverflow.ellipsis,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        actions: [
          StatefulBuilder(
            builder: (context, setState) {
              return IconButton(
                onPressed: () {},
                icon: const Icon(Icons.star_border),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Hiện không có lời cho bài hát này',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
