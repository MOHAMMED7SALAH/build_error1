import 'package:flutter/material.dart';
import 'package:saffi/helper/style.dart';

class CustomDropMenuo extends StatefulWidget {
  final double height;
  final double width;
  final String item;
  final List<String> items;
  final Function(String) onChanged;
  const CustomDropMenuo(
      {Key key, this.height, this.width, this.item, this.items, this.onChanged})
      : super(key: key);

  @override
  _CustomDropMenuoState createState() => _CustomDropMenuoState();
}

class _CustomDropMenuoState extends State<CustomDropMenuo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        icon: Icon(
          Icons.expand_more,
          color: Colors.black,
        ),
        underline: Container(
          color: Color(0x00000000),
        ),
        value: widget.item,
        isExpanded: true,
        elevation: 0,
        // style: boldStyle,
        dropdownColor: primaryColor,
        onChanged: widget.onChanged,
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
