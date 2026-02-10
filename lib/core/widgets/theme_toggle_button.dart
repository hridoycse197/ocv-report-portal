import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Global Theme Toggle Button Widget
/// Shows two clickable icons - one for light mode and one for dark mode
class ThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onPressed;

  const ThemeToggleButton({
    super.key,
    required this.isDark,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Two clickable icons side by side
    return Row(
      children: [
        // Light Mode Icon
        InkWell(
          onTap: () {
            if (isDark) onPressed();
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: !isDark
                  ? Colors.blue.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: !isDark
                    ? Colors.blue.withValues(alpha: 0.5)
                    : Colors.transparent,
                width: 1.5.w,
              ),
            ),
            child: Icon(
              Icons.light_mode,
              color: !isDark ? Colors.blue : (isDark ? Colors.white60 : Colors.black54),
              size: 20.r,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        // Dark Mode Icon
        InkWell(
          onTap: () {
            if (!isDark) onPressed();
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.blue.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isDark
                    ? Colors.blue.withValues(alpha: 0.5)
                    : Colors.transparent,
                width: 1.5.w,
              ),
            ),
            child: Icon(
              Icons.dark_mode,
              color: isDark ? Colors.blue : (isDark ? Colors.white60 : Colors.black54),
              size: 20.r,
            ),
          ),
        ),
      ],
    );
  }
}
