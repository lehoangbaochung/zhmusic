part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalAccountDialog extends StatelessWidget {
  const HorizontalAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog.normal(
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.android,
              label: 'Đăng nhập với Google',
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.facebook,
              label: 'Đăng nhập với Facebook',
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
