import 'package:flutter/material.dart';
import 'package:saffi/ui/Pages/product/productDetilsPage.dart';

class FilterColor extends StatefulWidget {
  @override
  _FilterColorState createState() => _FilterColorState();
}

class _FilterColorState extends State<FilterColor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),
        reverse: true,
        itemCount: selectColor.length,
        shrinkWrap: true,
        itemBuilder: (c, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: selectColor[index].color,
                borderRadius: BorderRadius.circular(10000),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < selectColor.length; i++) {
                      if (i != index) {
                        selectColor[i].sel = false;
                      } else {
                        selectColor[index].sel = true;
                      }
                    }
                  });
                },
                child: Visibility(
                  visible: selectColor[index].sel ?? false,
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
