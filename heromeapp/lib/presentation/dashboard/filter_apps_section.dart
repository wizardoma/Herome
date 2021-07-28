import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

class FilterAppSection extends StatelessWidget {
  final Function(String value) onSearchApp;

  const FilterAppSection({Key key, this.onSearchApp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: kInputBorderColor, width: 0.5),
          )),
      height: 70,
      child: TextField(
        onChanged: onSearchApp,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: kDarkTextColor,
          ),
//          contentPadding: EdgeInsets.all(20),
          hintText: "Filter apps",
          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: kInputBorderColor)),
          focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: kPurpleColor)),
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: kInputBorderColor)),
        ),
      ),
    );
  }
}
