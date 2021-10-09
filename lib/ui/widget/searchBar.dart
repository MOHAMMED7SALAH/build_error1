import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/helper/appLocalization.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onChange;
  final Function onClose;
  final TextEditingController controller;
  const SearchBar({Key key, this.onChange, this.onClose, this.controller})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        // onTap: () => push(context, SreachPage()),
        onChanged: widget.onChange ?? (v) {},
        decoration: InputDecoration(
          fillColor: Colors.white,
          suffixIcon: InkWell(
            onTap: widget.onClose,
            child: Padding(
                padding: const EdgeInsets.all(15.0), child: Icon(Icons.close)),
          ),

          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              "assets/svg/zoom-in.svg",
              height: 10,
              width: 10,
            ),
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintText: localization.text("writehere") + " ...",
          // hintStyle: lightStyle,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
        ),
      ),
    );
  }
}
