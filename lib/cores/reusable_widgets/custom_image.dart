import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A reusable image widget that provides consistent styling and behavior for displaying images.
///
/// ### Parameters:
/// - [imageUrl]: The URL of the image to display (required for network images).
/// - [assetPath]: The path to the local asset image (required for local images).
/// - [width]: The width of the image (default: 100.0).
/// - [height]: The height of the image (default: 100.0).
/// - [fit]: How the image should be inscribed into the box (default: BoxFit.cover).
/// - [borderRadius]: The border radius of the image (default: 0.0).
/// - [placeholder]: The widget to display while the image is loading (default: CircularProgressIndicator).
/// - [errorWidget]: The widget to display if the image fails to load (default: Icon(Icons.error)).
/// - [isNetworkImage]: Whether the image is from a network URL (default: true). If false, use [assetPath].

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  final Widget placeholder;
  final Widget errorWidget;
  final bool isNetworkImage;

  const CustomImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.width = 100.0,
    this.height = 100.0,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
    this.placeholder = const CircularProgressIndicator(),
    this.errorWidget = const Icon(Icons.error, size: 40, color: Colors.red),
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: isNetworkImage
          ? _buildNetworkImage()
          : _buildAssetImage(),
    );
  }

  /// Builds a network image with caching and error handling.
  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: Center(child: placeholder),
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: Center(child: errorWidget),
      ),
    );
  }

  /// Builds a local asset image.
  Widget _buildAssetImage() {
    return Image.asset(
      assetPath ?? "",
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: Center(child: errorWidget),
        );
      },
    );
  }
}