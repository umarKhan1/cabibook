import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialButton extends StatelessWidget { 
   SocialButton({super.key,
    this.onPressed,
    this.label,
    this.icon,
    this.backgroundColor,
  });
  VoidCallback? onPressed;
  final String? label;
  final IconData? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor, // Facebook Blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: onPressed,
              icon: Icon(icon, color: Colors.white, size: 30.h,),
              label: Text(
                label ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
    );
       

  }
}
