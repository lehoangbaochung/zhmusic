import 'package:audio/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';

class PlayerBar extends StatefulWidget {
  const PlayerBar({super.key});

  @override
  State<PlayerBar> createState() => _PlayerBarState();
}

class _PlayerBarState extends State<PlayerBar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final playlist = context.appState.playlist;
    if (playlist.isEmpty) {
      return placeholder;
    } else {
      final playingSong = playlist.first;
      return ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.getWidth(8),
        ),
        title: Text(
          playingSong.getName(MusicLanguage.vi),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: FutureBuilder(
          future: playingSong.getArtists(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final artists = snapshot.requireData;
              return Text(
                artists.getName(MusicLanguage.vi),
                overflow: TextOverflow.ellipsis,
              );
            }
            return placeholder;
          },
        ),
        leading: const CircleAvatar(
          child: Center(
            child: Icon(Icons.play_circle),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.playlist_play),
            ),
          ],
        ),
      );
    }
  }
}
