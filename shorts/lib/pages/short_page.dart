import 'package:flutter/material.dart';
import 'package:shorts/widgets/short_fullscreen_tile.dart';
import 'package:src/exports/entities.dart';

class ShortPage extends StatelessWidget {
  const ShortPage({
    super.key,
    this.index = 0,
    required this.shorts,
  });

  final int index;
  final Iterable<Short> shorts;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: PageController(initialPage: index),
      itemCount: shorts.length,
      itemBuilder: (context, index) {
        return ShortFullscreenTile(
          shorts.elementAt(index),
          extendBody: true,
        );
      },
    );
  }
}
