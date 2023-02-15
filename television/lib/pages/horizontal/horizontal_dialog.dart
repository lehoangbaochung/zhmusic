import 'package:flutter/material.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalDialog extends StatelessWidget {
  const HorizontalDialog._({
    required this.leading,
    required this.trailing,
    required this.child,
    this.expandLeading,
    this.expandTrailing,
    this.expandChild,
  });

  factory HorizontalDialog.normal({
    required Widget leading,
    required Widget trailing,
    required Widget child,
  }) {
    return HorizontalDialog._(
      leading: leading,
      trailing: trailing,
      child: child,
    );
  }

  factory HorizontalDialog.expand({
    required Widget expandLeading,
    required Widget expandTrailing,
    required Widget expandChild,
    required Widget leading,
    required Widget trailing,
    required Widget child,
  }) {
    return HorizontalDialog._(
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
