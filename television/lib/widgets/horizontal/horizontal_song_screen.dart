import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalSongScreen extends StatelessWidget {
  const HorizontalSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playingSong = context.horiverticalState.playingSong;
    return Padding(
      padding: EdgeInsets.only(bottom: context.songBarHeight),
      child: Center(
        child: CachedNetworkImage(
          imageUrl: playingSong.getImageUrl(
            YoutubeThumbnail.maxresdefault,
          ),
          fit: BoxFit.fill,
          placeholder: (_, __) => placeholder,
        ),
      ),
    );
  }
}
