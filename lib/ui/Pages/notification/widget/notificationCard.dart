import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saffi/helper/style.dart';

class NotificationCard extends StatelessWidget {
  final f = new DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ),
      padding: EdgeInsets.all(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: accentColor,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Image.network(
                "https://static.remove.bg/remove-bg-web/3661dd45c31a4ff23941855a7e4cedbbf6973643/assets/start-0e837dcc57769db2306d8d659f53555feb500b3c5d456879b9c843d1872e7baa.jpg",
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "shopix App",
                      style: lightStyle.copyWith(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      f.format(DateTime.now()),
                      style:
                          lightStyle.copyWith(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                Text(
                  "The consulting service request from the Garden Green Store has been accepted",
                  style: lightStyle.copyWith(
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
