import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

class DashboardInfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const DashboardInfoCard({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 5,bottom: 15, top: 5),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
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
                  fontWeight: FontWeight.w400,
                  fontSize: 18
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
          SizedBox(height: 20,),
          child
        ],
      ),
    );
  }
}
