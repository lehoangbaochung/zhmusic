part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalBottomSheet extends StatelessWidget {
  const HorizontalBottomSheet._({
    required this.leading,
    required this.trailing,
    required this.child,
    this.expandLeading,
    this.expandTrailing,
    this.expandChild,
  });

  factory HorizontalBottomSheet.normal({
    required Widget leading,
    required Widget trailing,
    required Widget child,
  }) {
    return HorizontalBottomSheet._(
      leading: leading,
      trailing: trailing,
      child: child,
    );
  }

  factory HorizontalBottomSheet.expand({
    required Widget expandLeading,
    required Widget expandTrailing,
    required Widget expandChild,
    required Widget leading,
    required Widget trailing,
    required Widget child,
  }) {
    return HorizontalBottomSheet._(
      expandChild: expandChild,
      expandLeading: expandLeading,
      expandTrailing: expandTrailing,
      leading: leading,
      trailing: trailing,
      child: child,
    );
  }

  final Widget leading;
  final Widget trailing;
  final Widget child;
  final Widget? expandLeading;
  final Widget? expandTrailing;
  final Widget? expandChild;

  bool get normal => expandChild == null || expandLeading == null || expandTrailing == null;

  @override
  Widget build(BuildContext context) {
    return normal
        ? SizedBox(
            height: context.songBarHeight,
            child: Row(
              children: [
                IgnorePointer(child: leading),
                Expanded(child: child),
                trailing,
              ],
            ),
          )
        : SizedBox(
            height: context.songBarHeight + context.marqueeTextHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.marqueeTextHeight,
                  child: Row(
                    children: [
                      IgnorePointer(child: expandLeading),
                      Expanded(child: expandChild!),
                      expandTrailing!,
                    ],
                  ),
                ),
                SizedBox(
                  height: context.songBarHeight,
                  child: Row(
                    children: [
                      IgnorePointer(child: leading),
                      Expanded(child: child),
                      trailing,
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
