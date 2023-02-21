import 'package:flutter/material.dart';
import 'package:src/exports/widgets.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

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
              child: Icon(
                icon,
                size: context.mediaHeight / 36,
              ),
            ),
            label: Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.bodyTextStyle,
            ),
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
                  Icon(
                    icon,
                    size: context.iconSize,
                  ),
                  Text(
                    label,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.mediaHeight / 36,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
