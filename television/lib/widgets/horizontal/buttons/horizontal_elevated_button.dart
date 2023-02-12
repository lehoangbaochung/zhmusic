part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalElevatedButton extends StatelessWidget {
  const HorizontalElevatedButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(),
        ),
        fixedSize: MaterialStatePropertyAll(
          Size.fromWidth(
            context.songBarHeight,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36),
            AutoSizeText(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}
