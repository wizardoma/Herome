import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpSection extends StatelessWidget {
  final String herokuSignupUrl  = "https://signup.heroku.com/";
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
            onPressed: _launchUrl,
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

  void _launchUrl()async {
    if (await canLaunch(herokuSignupUrl)){
      await launch(herokuSignupUrl, forceWebView: true,webOnlyWindowName: "Herome");
    }
    else {
      print("cannot launch");
    }
  }
}
