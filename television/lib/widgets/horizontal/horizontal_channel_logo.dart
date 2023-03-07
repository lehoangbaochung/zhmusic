import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';

import '/pages/horizontal/horizontal_widget.dart';

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
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                fixedSize: Size.fromHeight(
                  context.marqueeTextHeight,
                ),
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Bạn muốn chuyển sang chế độ trực tuyến?',
                      ),
                      content: const Text(
                        'Thao tác này cũng sẽ xóa các bài hát đang có trong danh sách phát hiện tại',
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0),
                          onPressed: () async {
                            Navigator.pop(context);
                            //final television = await musicStorage.getTelevision();
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  title: const Text(
                                    'Quay về ngoại tuyến',
                                  ),
                                  content: const Text(
                                    'Hiện không có luồng phát trực tiếp nào',
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(elevation: 0),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Đồng ý'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Quay lại'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(width: context.mediaWidth / 256),
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
            ),
          ],
        ),
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
