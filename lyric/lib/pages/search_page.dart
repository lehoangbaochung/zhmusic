import 'package:flutter/material.dart';
import 'package:lyric/app/app_pages.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';
import 'package:src/exports/widgets.dart';

class SearchPage extends SearchDelegate<String> {
  SearchPage()
      : super(
          searchFieldLabel: 'Tìm kiếm',
          searchFieldStyle: const TextStyle(),
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Visibility(
        visible: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = empty,
          icon: const Icon(Icons.clear),
        ),
      ),
      IconButton(
        onPressed: () => showResults(context),
        icon: const Icon(Icons.search),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, query),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: musicCollection.getAudios(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final audios = snapshot.requireData.where(
            // ignore: invalid_use_of_protected_member
            (audio) => audio.getName(MusicLanguage.vi).contains(query),
          );
          return audios.isEmpty
              ? Center(
                  child: Text(
                    'Không tìm thấy kết quả phù hợp',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              : ListView.builder(
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
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      leading: const SizedBox(
                        height: double.infinity,
                        child: Icon(Icons.audiotrack),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star_border),
                      ),
                      onTap: () => AppPages.push(context, AppPages.lyric.path, audio),
                    );
                  },
                );
        }
        return centeredLoadingIndicator;
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        'Tìm kiếm tại đây',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
