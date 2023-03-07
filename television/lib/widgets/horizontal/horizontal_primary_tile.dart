import 'package:flutter/material.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalPrimaryTile {
  const HorizontalPrimaryTile._();
  
  static Widget icon({
    required String label,
    required IconData icon,
    required void Function()? onPressed,
  }) {
    return Builder(builder: (context) {
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
                  fontSize: context.fontSize,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
