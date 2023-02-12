part of '/pages/horizontal/horizontal_widget.dart';

enum HorizontalOutlinedButtonType {
  small,
  large;
}

class HorizontalOutlinedButton extends StatelessWidget {
  const HorizontalOutlinedButton._({
    required this.type,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  factory HorizontalOutlinedButton.small({
    required String label,
    required IconData icon,
    required void Function()? onPressed,
  }) {
    return HorizontalOutlinedButton._(
      type: HorizontalOutlinedButtonType.small,
      icon: icon,
      label: label,
      onPressed: onPressed,
    );
  }

  factory HorizontalOutlinedButton.large({
    required String label,
    required IconData icon,
    required void Function()? onPressed,
  }) {
    return HorizontalOutlinedButton._(
      type: HorizontalOutlinedButtonType.large,
      icon: icon,
      label: label,
      onPressed: onPressed,
    );
  }

  final String label;
  final IconData icon;
  final void Function()? onPressed;
  final HorizontalOutlinedButtonType type;

  @override
  Widget build(BuildContext context) {
    return type == HorizontalOutlinedButtonType.small
        ? OutlinedButton.icon(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(),
              fixedSize: Size.fromWidth(
                context.songBarHeight,
              ),
            ),
            icon: SizedBox(
              height: context.marqueeTextHeight,
              child: Icon(icon),
            ),
            label: Text(label),
          )
        : OutlinedButton(
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
                  Text(
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
