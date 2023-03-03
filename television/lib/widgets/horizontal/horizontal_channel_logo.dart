import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalChannelLogo extends StatelessWidget {
  const HorizontalChannelLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox.square(
              dimension: context.songBarHeight * 0.8,
              child: MusicType.music.image,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ngoại tuyến',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: context.mediaWidth / 512),
                Container(
                  width: context.mediaWidth / 128,
                  height: context.mediaWidth / 128,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
        //SizedBox(width: context.mediaWidth / 256),
        Text(
          'TV',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: context.fontSize * 1.5,
          ),
        ),
      ],
    );
  }
}
