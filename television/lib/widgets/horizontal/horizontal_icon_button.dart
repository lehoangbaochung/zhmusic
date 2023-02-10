part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const HorizontalIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: context.songBarHeight,
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36),
              Text(
                text,
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
