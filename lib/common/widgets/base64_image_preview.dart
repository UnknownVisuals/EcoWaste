import 'dart:convert';
import 'dart:typed_data';

import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:eco_waste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// A reusable widget for displaying base64 encoded images with error handling
///
/// This widget handles:
/// - Base64 string decoding (with or without data URI prefix)
/// - Network image fallback
/// - Error states with customizable placeholders
/// - Loading states
/// - Responsive error handling
class REYBase64ImagePreview extends StatelessWidget {
  /// Creates a Base64ImageWidget
  ///
  /// The [imageData] parameter is required and should contain either:
  /// - A base64 encoded string (with or without data URI prefix)
  /// - A network URL
  ///
  /// The [fit] parameter controls how the image should be fitted within its container
  /// The [width] and [height] parameters control the size of the container
  /// The [borderRadius] parameter controls the border radius of the image
  /// The [errorIcon] parameter allows customization of the error placeholder icon
  /// The [errorIconSize] parameter controls the size of the error icon
  /// The [errorText] parameter allows customization of the error placeholder text
  /// The [showErrorText] parameter controls whether to show error text
  const REYBase64ImagePreview({
    super.key,
    required this.imageData,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.errorIcon = Iconsax.gallery,
    this.errorIconSize = REYSizes.iconSm,
    this.errorText = 'N/A',
    this.showErrorText = true,
    this.backgroundColor,
    this.errorColor,
  });

  /// The image data - can be base64 string or network URL
  final String imageData;

  /// How the image should be fitted within its container
  final BoxFit fit;

  /// The width of the image container
  final double? width;

  /// The height of the image container
  final double? height;

  /// The border radius of the image
  final BorderRadius? borderRadius;

  /// The icon to show in error state
  final IconData errorIcon;

  /// The size of the error icon
  final double errorIconSize;

  /// The text to show in error state
  final String errorText;

  /// Whether to show error text
  final bool showErrorText;

  /// Background color for the error state container
  final Color? backgroundColor;

  /// Color for error icon and text
  final Color? errorColor;

  /// Safely decode base64 image string to Uint8List
  Uint8List? _decodeBase64Image(String base64String) {
    try {
      // Remove data:image/xxx;base64, prefix if present
      String cleanBase64 = base64String;
      if (base64String.contains(',')) {
        cleanBase64 = base64String.split(',').last;
      }

      // Decode base64 string
      return base64Decode(cleanBase64);
    } catch (e) {
      // Return null if decoding fails
      return null;
    }
  }

  /// Build the error placeholder widget
  Widget _buildErrorPlaceholder(BuildContext context) {
    final dark = REYHelperFunctions.isDarkMode(context);
    final bgColor =
        backgroundColor ?? (dark ? REYColors.darkerGrey : REYColors.light);
    final iconColor = errorColor ?? REYColors.darkGrey;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(errorIcon, size: errorIconSize, color: iconColor),
            if (showErrorText) ...[
              const SizedBox(height: 2),
              Text(
                errorText,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: iconColor,
                  fontSize: 10,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Build image widget based on the type of image data
  Widget _buildImage(BuildContext context) {
    // Check if it's a base64 image (starts with data:image) or just base64 string
    if (imageData.startsWith('data:image') || !imageData.startsWith('http')) {
      // Handle base64 images
      final imageBytes = _decodeBase64Image(imageData);

      if (imageBytes != null) {
        return Image.memory(
          imageBytes,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) =>
              _buildErrorPlaceholder(context),
        );
      } else {
        // Base64 decoding failed
        return _buildErrorPlaceholder(context);
      }
    } else {
      // Handle network images
      return Image.network(
        imageData,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorPlaceholder(context),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor ?? REYColors.grey.withValues(alpha: 0.1),
              borderRadius: borderRadius,
            ),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
                color: REYColors.primary,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageData.isEmpty) {
      return _buildErrorPlaceholder(context);
    }

    Widget image = _buildImage(context);

    // Apply border radius if specified
    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}
