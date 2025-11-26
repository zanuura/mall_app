// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class IconCircleButton extends StatelessWidget {
  final String assetIcon;
  final double size;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const IconCircleButton({
    super.key,
    required this.assetIcon,
    this.size = 40,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(size / 2),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              assetIcon,
              // width: size * 0.5,
              // height: size * 0.5,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.color,
              color: backgroundColor ?? Colors.white,
              // color: backgroundColor != null
              //     ? backgroundColor!.withOpacity(0.4)
              //     : Colors.white.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
