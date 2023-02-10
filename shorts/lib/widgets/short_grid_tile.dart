import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/widgets.dart';

import '/app/app_pages.dart';

class ShortGridTile extends StatelessWidget {
  const ShortGridTile({
    super.key,
    required this.index,
    required this.shorts,
  });

  final int index;
  final Iterable<Short> shorts;

  @override
  Widget build(BuildContext context) {
    final short = shorts.elementAt(index);
    return InkWell(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        width: context.mediaWidth / 3,
        imageUrl: short.getImageUrl(
          YoutubeThumbnail.hqdefault,
        ),
        placeholder: (_, __) => MusicType.short.image,
      ),
      onTap: () {
        AppPages.push(
          context,
          AppPages.short.path,
          {
            'index': index,
            'shorts': shorts,
          },
        );
      },
    );
  }
}
