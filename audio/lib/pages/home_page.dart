import 'package:audio/app/app_cubit.dart';
import 'package:audio/app/app_pages.dart';
import 'package:audio/widget_test.dart';
import 'package:audio/widgets/player_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AppCubit>(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: true,
          title: const Text('Audio'),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [],
          ),
        ),
        body: FutureBuilder(
          future: musicCollection.getAudios(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final audios = snapshot.requireData;
              return ListView.separated(
                itemCount: audios.length,
                itemBuilder: (context, index) {
                  final audio = audios.elementAt(index);
                  return ListTile(
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
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                    onTap: () {
                      context.read<AppCubit>().setPlaylist(index, audios);
                      AppPages.push(context, AppPages.player.path, audio);
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(thickness: 1),
              );
            }
            return centeredLoadingIndicator;
          },
        ),
        bottomSheet: Builder(
          builder: (context) {
            final state = context.read<AppCubit>().state;
            return state.playlist.isEmpty
                ? const SizedBox.shrink()
                : BlocProvider.value(
                    value: context.watch<AppCubit>(),
                    child: const PlayerBar(),
                  );
          },
        ),
      ),
    );
  }
}
