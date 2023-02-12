part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalMarqueeText extends StatelessWidget {
  const HorizontalMarqueeText({
    super.key,
    this.style,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final TextStyle? style;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size.fromHeight(
          context.songTextHeight,
        ),
      ),
      child: Marquee(
        text: text,
        velocity: 150,
        blankSpace: context.mediaWidth,
        pauseAfterRound: const Duration(seconds: 1),
        style: TextStyle(
          fontSize: 28,
          color: Colors.white,
          height: context.songTextHeight / 28,
        ),
      ),
    );
  }
}
