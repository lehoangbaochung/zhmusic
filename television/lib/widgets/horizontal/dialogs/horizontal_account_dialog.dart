import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

import '../horizontal_secondary_tile.dart';

class HorizontalAccountDialog extends StatelessWidget {
  const HorizontalAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Account.changes,
      initialData: Account.instance,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final account = snapshot.requireData!;
          return HorizontalDialog(
            leading: HorizontalPrimaryTile.icon(
              icon: Icons.account_circle,
              label: 'Tài khoản',
              onPressed: () {},
            ),
            trailing: HorizontalPrimaryTile.icon(
              icon: Icons.arrow_back,
              label: 'Quay lại',
              onPressed: () => Navigator.pop(context),
            ),
            child: Row(
              children: [
                Expanded(
                  child: HorizontalSecondaryTile.icon(
                    icon: Icons.manage_accounts,
                    label: 'Quản lý tài khoản',
                    onPressed: () async {
                      final avatar = account.avatar;
                      await context.showHorizontalDialog(
                        HorizontalDialog(
                          leading: avatar == null
                              ? HorizontalPrimaryTile.icon(
                                  icon: Icons.account_circle,
                                  label: 'Tài khoản',
                                  onPressed: () {},
                                )
                              : SizedBox.square(
                                  dimension: context.songBarHeight,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: avatar,
                                  ),
                                ),
                          trailing: HorizontalPrimaryTile.icon(
                            icon: Icons.arrow_back,
                            label: 'Quay lại',
                            onPressed: () => Navigator.pop(context),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: HorizontalSecondaryTile.text(
                                  title: 'Tên đăng nhập',
                                  subtitle: account.name ?? '(không hiển thị)',
                                ),
                              ),
                              Expanded(
                                child: HorizontalSecondaryTile.text(
                                  title: 'Email đăng nhập',
                                  subtitle: account.email ?? '(không hiển thị)',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: HorizontalSecondaryTile.icon(
                    icon: Icons.switch_account,
                    label: 'Thay đổi tài khoản',
                    onPressed: () async => await Account.signInWithGoogle(),
                  ),
                ),
                Expanded(
                  child: HorizontalSecondaryTile.icon(
                    icon: Icons.logout,
                    label: 'Đăng xuất tài khoản',
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Đăng xuất'),
                            content: const Text('Bạn chắc chắn muốn đăng xuất tài khoản?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await Account.signOut();
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
                  ),
                ),
              ],
            ),
          );
        }
        return HorizontalDialog(
          leading: HorizontalPrimaryTile.icon(
            icon: Icons.account_circle,
            label: 'Tài khoản',
            onPressed: () {},
          ),
          trailing: HorizontalPrimaryTile.icon(
            icon: Icons.arrow_back,
            label: 'Quay lại',
            onPressed: () => Navigator.pop(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: HorizontalSecondaryTile.icon(
                  icon: Icons.email,
                  label: 'Đăng nhập với Email',
                  onPressed: null,
                ),
              ),
              Expanded(
                child: HorizontalSecondaryTile.icon(
                  icon: Icons.android,
                  label: 'Đăng nhập với Google',
                  onPressed: () async => await Account.signInWithGoogle(),
                ),
              ),
              Expanded(
                child: HorizontalSecondaryTile.icon(
                  icon: Icons.facebook,
                  label: 'Đăng nhập với Facebook',
                  onPressed: null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
