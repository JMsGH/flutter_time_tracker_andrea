import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.primaryColor = Colors.white,
    this.borderRadius = 2.0,
    this.height = 50.0,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final Color primaryColor;
  final double borderRadius;
  final double height;
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return primaryColor;
            } else if (states.contains(MaterialState.disabled)) {
              return primaryColor.withOpacity(0.5);
            }
            return primaryColor;
          }),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
