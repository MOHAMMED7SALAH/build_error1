import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saffi/helper/style.dart';

class CustomFeild extends StatefulWidget {
  final String title;
  final String hint;
  final bool password;
  final TextEditingController controller;
  final String Function(String) validator;
  final TextInputType keyboardType;
  const CustomFeild(
      {Key key,
      this.title,
      this.hint,
      this.password,
      this.controller,
      this.validator,
      this.keyboardType})
      : super(key: key);

  @override
  _CustomFeildState createState() => _CustomFeildState();
}

class _CustomFeildState extends State<CustomFeild> {
  bool see = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.only(right: 15, left: 15, top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: boldStyle,
          ),
          TextFormField(
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            controller: widget.controller,
            obscureText: widget.password == true ? !see : false,
            decoration: InputDecoration(
              suffixIcon: widget.password == true
                  ? IconButton(
                      icon: SvgPicture.asset(
                        see == false
                            ? "assets/svg/unsee.svg"
                            : "assets/svg/see.svg",
                        height: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          see = !see;
                        });
                      })
                  : null,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
