import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_country_picker/constant/app_colors.dart';

class ImageDescriptionItem extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String trailingDescription;
  final double height;
  final EdgeInsets padding;
  final double imageWidth;
  final double imageHeight;
  final TextStyle descriptionStyle;
  final TextStyle trailingDescriptionStyle;
  final Function() onTap;

  ImageDescriptionItem({
    @required this.imageUrl,
    @required this.description,
    this.trailingDescription = '',
    this.height = 38,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.imageWidth,
    this.imageHeight,
    this.descriptionStyle = const TextStyle(fontSize: 14, color: AppColors.black),
    this.trailingDescriptionStyle = const TextStyle(fontSize: 14, color: AppColors.black),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (imageUrl.endsWith('.svg')) {
      image = SvgPicture.asset(
        imageUrl,
        width: imageWidth,
        height: imageHeight,
      );
    } else {
      image = Image.asset(
        imageUrl,
        width: imageWidth,
        height: imageHeight,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding,
        child: Row(
          children: <Widget>[
            image,
            SizedBox(width: 10),
            Flexible(
              child: Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: descriptionStyle,
              ),
            ),
            SizedBox(width: trailingDescription.isEmpty ? 0 : 10),
            Text(
              trailingDescription,
              style: trailingDescriptionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
