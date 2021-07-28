import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/commons/app/ui_helpers.dart';

class DashboardInfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const DashboardInfoCard({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: defaultSpacing, right: defaultSpacing * 0.3,bottom: defaultSpacing, top: defaultSpacing * 0.3),
      margin: EdgeInsets.symmetric(vertical: defaultSpacing * 0.3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kInputBorderColor, width: 0.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),
              ),

              Container(
                child: IconButton(
                  icon: Icon(Icons.more_vert, color: kGreyTextColor,),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          child
        ],
      ),
    );
  }
}
