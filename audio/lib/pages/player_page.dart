import 'package:audio/widget_test.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: playerController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final audio = snapshot.requireData;
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: size.height / 2,
                    height: size.height / 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          audio.getImageUrl(
                            YoutubeThumbnail.hqdefault,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return centeredLoadingIndicator;
        },
      ),
      bottomSheet: Container(
        color: Colors.blue.withOpacity(0.4),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.skip_previous),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_circle),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.skip_next),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.playlist_play),
            ),
          ],
        ),
      ),
    );
  }
}
