import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

class LoginTextField extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPassword;
  final Function(String) validator;
  final TextEditingController editingController;

  const LoginTextField(
      {Key key, this.title, this.icon, this.validator, this.isPassword, this.editingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: editingController,
            cursorColor: kPrimaryColor,
            style: Theme.of(context).textTheme.bodyText1,
            obscureText: isPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              hintText: title,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: kDarkTextColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: kDarkTextColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: kerrorBorderColor),
              )
            ),
            validator: validator,
          )
        ],
      ),
    );
  }
}
