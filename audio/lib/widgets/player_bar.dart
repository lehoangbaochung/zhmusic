import 'package:audio/app/app_cubit.dart';
import 'package:audio/app/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';
import 'package:src/extensions/music.dart';

class PlayerBar extends StatefulWidget {
  const PlayerBar({super.key});

  @override
  State<PlayerBar> createState() => _PlayerBarState();
}

class _PlayerBarState extends State<PlayerBar> {
  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state;
    final audio = appState.currentSong;
    return ListTile(
      tileColor: Colors.blue.withOpacity(0.6),
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
            );
          }
          return const SizedBox.shrink();
        },
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          audio.getImageUrl(),
        ),
      ),
      trailing: IconButton(
        onPressed: () => context.read<AppCubit>().toggle(),
        icon: Icon(!appState.isPlaying ? Icons.play_arrow : Icons.pause),
      ),
      onTap: () => AppPages.push(context, AppPages.player.path, audio),
    );
  }
}
