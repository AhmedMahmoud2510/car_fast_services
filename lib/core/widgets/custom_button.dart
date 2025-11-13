import 'package:quick_cars_service/barrel.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? iconData; // Icon to display
  final String text; // Text to display
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final BorderSide? borderSide;
  final double? elevation;
  final bool? enableShadow;
  final bool? isEnabled;
  final List<Color>? gradientColors;
  final List<BoxShadow>? boxShadow;

  const CustomButton({
    super.key,
    this.onPressed,
    this.iconData, // Updated to accept IconData
    required this.text, // Updated to accept String
    this.color,
    this.textColor,
    this.fontSize = 20,
    this.fontWeight,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius = 10.0,
    this.borderSide,
    this.elevation,
    this.enableShadow,
    this.isEnabled,
    this.gradientColors,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // alignment: Alignment.centerRight,
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        height: height ?? 25.sp,
        margin: margin,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors!,
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                )
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderSide?.color ?? Colors.transparent),
          color: color ?? AppColors.primaryColor,
          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: Colors.grey.withAlpha(77),
                  spreadRadius: -1,
                  blurRadius: 5.sp,
                ),
              ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconData != null)
                Icon(iconData, color: textColor ?? Colors.white, size: 10.sp),
              if (iconData != null) 5.horizontalSpace,
              Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: fontWeight ?? FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
