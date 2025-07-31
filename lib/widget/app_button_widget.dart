import 'package:flutter/material.dart';

class ApplicationButton extends StatelessWidget {

  const ApplicationButton({
    required this.onPressed, required this.child, super.key,
    this.size,
    this.enabledColor,
    this.disabledColor,
  });
  final VoidCallback? onPressed;
  final Widget child;
  final Size? size;
  final Color? enabledColor;
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return SizedBox(
      width: size?.width,
      height: size?.height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (enabledColor ?? Theme.of(context).primaryColor)
              : (disabledColor ?? Theme.of(context).primaryColor.withOpacity(0.4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: child,
      ),
    );
  }
}
