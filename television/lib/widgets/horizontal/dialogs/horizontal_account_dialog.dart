part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalAccountDialog extends StatelessWidget {
  const HorizontalAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
   if (true) {
      final account = Account.instance;
      if (account == null) {
        return HorizontalDialog(
          leading: HorizontalElevatedButton(
            icon: Icons.account_circle,
            label: 'Tài khoản',
            onPressed: () {},
          ),
          trailing: HorizontalElevatedButton(
            icon: Icons.arrow_back,
            label: 'Quay lại',
            onPressed: () => Navigator.pop(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: HorizontalOutlinedButton.large(
                  icon: Icons.email,
                  label: 'Đăng nhập với Email',
                  onPressed: null,
                ),
              ),
              Expanded(
                child: HorizontalOutlinedButton.large(
                  icon: Icons.android,
                  label: 'Đăng nhập với Google',
                  onPressed: () async => await Account.signInWithGoogle(),
                ),
              ),
              Expanded(
                child: HorizontalOutlinedButton.large(
                  icon: Icons.facebook,
                  label: 'Đăng nhập với Facebook',
                  onPressed: null,
                ),
              ),
            ],
          ),
        );
      } else {
        return HorizontalDialog(
          leading: HorizontalElevatedButton(
            icon: Icons.account_circle,
            label: 'Tài khoản',
            onPressed: () {},
          ),
          trailing: HorizontalElevatedButton(
            icon: Icons.arrow_back,
            label: 'Quay lại',
            onPressed: () => Navigator.pop(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: HorizontalOutlinedButton.large(
                  icon: Icons.manage_accounts,
                  label: 'Quản lý tài khoản',
                  onPressed: () async {
                    await context.showHorizontalDialog(
                      HorizontalDialog(
                        leading: account.photoUrl == null
                            ? HorizontalElevatedButton(
                                icon: Icons.account_circle,
                                label: 'Tài khoản',
                                onPressed: () {},
                              )
                            : SizedBox.square(
                                dimension: context.songBarHeight,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: account.photoUrl!,
                                ),
                              ),
                        trailing: HorizontalElevatedButton(
                          icon: Icons.arrow_back,
                          label: 'Quay lại',
                          onPressed: () => Navigator.pop(context),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: HorizontalOutlinedTile(
                                title: 'Tên đăng nhập',
                                subtitle: account.name ?? '(không hiển thị)',
                              ),
                            ),
                            Expanded(
                              child: HorizontalOutlinedTile(
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
                child: HorizontalOutlinedButton.large(
                  icon: Icons.switch_account,
                  label: 'Thay đổi tài khoản',
                  onPressed: () async => await Account.signInWithGoogle(),
                ),
              ),
              Expanded(
                child: HorizontalOutlinedButton.large(
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
                            TextButton(
                              onPressed: () async => await Account.signOut(),
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
    }
  }
}
