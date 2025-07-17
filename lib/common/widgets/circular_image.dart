import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class REYCircularImage extends StatelessWidget {
  const REYCircularImage({
    super.key,
    required this.image,
    this.isNetworkImage = false,
    this.width = 56,
    this.height = 56,
    this.padding = REYSizes.sm,
    this.backgroundColor,
    this.overlayColor,
    this.fit = BoxFit.cover,
  });

  final String image;
  final bool isNetworkImage;
  final double width, height, padding;
  final Color? backgroundColor, overlayColor;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (REYHelperFunctions.isDarkMode(context)
                ? REYColors.black
                : REYColors.white),
      ),
      child: Center(
        child: Image(
          fit: fit,
          image: isNetworkImage
              ? NetworkImage(image)
              : AssetImage(image) as ImageProvider,
          color: overlayColor,
        ),
      ),
    );
  }
}
