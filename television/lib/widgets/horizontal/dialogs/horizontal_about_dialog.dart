part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalAboutDialog extends StatelessWidget {
  const HorizontalAboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalBottomSheet.normal(
      leading: HorizontalElevatedButton(
        icon: Icons.info,
        label: 'Giới thiệu',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => context.dialogCubit.pop(),
      ),
      child: Text(
        'Do Zither Harp Music tự động tạo',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.headlineMedium,
      ),
    );
  }
}
