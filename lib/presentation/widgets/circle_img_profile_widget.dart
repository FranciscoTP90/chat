import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/utils/asset_location.dart';

class CircleImgProfile extends StatelessWidget {
  final String url;
  final double size;
  const CircleImgProfile({super.key, required this.url, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(36.0)),
      child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: size,
          height: size,
          placeholder: (context, url) => Image.asset(
                AssetsLocation.profile,
                fit: BoxFit.cover,
                width: size,
                height: size,
              ),
          errorWidget: (context, url, error) => Image.asset(
                AssetsLocation.profile,
                fit: BoxFit.cover,
                width: size,
                height: size,
              )),
    );
  }
}
