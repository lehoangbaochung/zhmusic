import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';
import 'package:television/app/app_storage.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalChatDialog extends StatelessWidget {
  const HorizontalChatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = appStorage.instance.chat.toList()
      ..sort(
        (m1, m2) => m2.publishTime.compareTo(m1.publishTime),
      );
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.chat,
        label: 'Trò chuyện',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: FutureBuilder(
        future: musicStorage.getAccounts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: chat.length,
              itemBuilder: (context, index) {
                final message = chat.elementAt(index);
                final account = snapshot.requireData.singleWhere(
                  orElse: () => Account.anonymous,
                  (account) => account.id == message.id,
                );
                return ListTile(
                  dense: true,
                  title: Text(
                    account.name ?? '(nặc danh)',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: context.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(message.content),
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      account.avatar ?? '',
                    ),
                  ),
                  trailing: Text(
                    message.publishTime.format(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: context.fontSize * 0.6,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
              },
            );
          }
          return centeredLoadingIndicator;
        },
      ),
    );
  }
}
