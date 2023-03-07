import 'package:flutter/material.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalSecondaryTile {
  const HorizontalSecondaryTile._();
  
  static Widget text({
    required String title,
    required String subtitle,
  }) {
    return Builder(
      builder: (context) {
        return ExcludeFocus(
          child: AbsorbPointer(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                fixedSize: Size.fromWidth(context.songBarHeight),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: context.fontSize),
                    ),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: context.fontSize),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget icon({
    required String label,
    required IconData icon,
    required void Function()? onPressed,
  }) {
    return Builder(
      builder: (context) {
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
            fixedSize: Size.fromWidth(context.songBarHeight),
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
                  style: TextStyle(fontSize: context.fontSize),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
