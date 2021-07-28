import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

class SignUpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: kFooterBackgroundColor,
          border: Border(
              top: BorderSide(
            color: Color(0xffdddddd),
          ))),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "New to Heroku?",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 17,
                ),
          ),
          SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Sign Up",
              style: Theme.of(context).textTheme.headline4.copyWith(
                    decoration: TextDecoration.underline,
                    fontSize: 17,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
