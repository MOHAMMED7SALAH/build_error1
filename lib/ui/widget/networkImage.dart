import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saffi/helper/loadingApp.dart';

// ignore: non_constant_identifier_names
Widget networkImage(String url, {double height, double width}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Image(
      image: imageProvider,
      fit: BoxFit.contain,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
    ),
    placeholder: (context, url) => LoaderPhoto(heghit: height, width: width),
    errorWidget: (context, url, error) => Image.asset(
      "assets/images/error_image.png",
    ),
  );
}
