import 'package:flutter/material.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalOutlinedTile extends StatelessWidget {
  const HorizontalOutlinedTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: AbsorbPointer(
        child: OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: const MaterialStatePropertyAll(
              RoundedRectangleBorder(),
            ),
            fixedSize: MaterialStatePropertyAll(
              Size.fromWidth(context.songBarHeight),
            ),
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
  }
}
