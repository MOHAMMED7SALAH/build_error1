import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saffi/helper/style.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;

class ListTileProfile extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color color;
  final IconData icon;
  final Function onTap;
  final Color iconColor;

  const ListTileProfile(
      {Key key,
      this.title,
      this.iconPath,
      this.color,
      this.icon,
      this.onTap,
      this.iconColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ?? () {},
      title: Text("$title"),
      leading: CircleAvatar(
        backgroundColor: color ?? primaryColor,
        child: icon != null
            ? Icon(icon, color: Colors.white)
            : Padding(
                padding: EdgeInsets.all(5),
                child: ImageIcon(
                  svg.Svg(iconPath),
                  color: Colors.white,
                )),
      ),
    );
  }
}
