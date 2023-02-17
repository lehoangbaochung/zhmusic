part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalMarqueeText extends StatelessWidget {
  const HorizontalMarqueeText({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size.fromHeight(
          context.songBarHeight / 5,
        ),
      ),
      child: Marquee(
        text: text,
        velocity: context.mediaWidth / 12,
        blankSpace: context.mediaWidth,
        style: context.marqueeTextStyle,
        pauseAfterRound: const Duration(seconds: 1),
      ),
    );
  }
}
