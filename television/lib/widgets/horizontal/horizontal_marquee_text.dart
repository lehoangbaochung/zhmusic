import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';

import '/pages/horizontal/horizontal_widget.dart';

class HorizontalMarqueeText extends StatelessWidget {
  const HorizontalMarqueeText({
    super.key,
    required this.text,
    this.onDone,
    this.onPressed,
  });

  final String text;
  final void Function()? onDone;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.horiverticalState.theme;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size.fromHeight(
          context.marqueeTextHeight,
        ),
      ),
      child: Marquee(
        text: text,
        onDone: onDone,
        velocity: context.mediaWidth / 12,
        blankSpace: context.mediaWidth,
        style: TextStyle(
          fontSize: context.fontSize,
          color: theme.playlistTextColor,
        ),
        pauseAfterRound: const Duration(seconds: 1),
      ),
    );
  }
}
