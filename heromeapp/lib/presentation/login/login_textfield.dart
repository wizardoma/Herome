import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

import '../../commons/app/colors.dart';

class LoginTextField extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPassword;
  final bool isObscure;
  final Function(String) validator;
  final TextEditingController editingController;
  final Function toggleObscurity;

  const LoginTextField(
      {Key key, this.title, this.icon, this.validator, this.isObscure, this.isPassword, this.editingController, this.toggleObscurity})
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
            cursorColor: kPurpleColor,
            style: Theme.of(context).textTheme.bodyText1,
            obscureText: isPassword && isObscure,
            decoration: InputDecoration(
              suffixIcon: isPassword ? IconButton(icon: Icon(Icons.remove_red_eye, color: isObscure ? Colors.black87: kPurpleColor,), onPressed: toggleObscurity,): null,
              prefixIcon: Icon(
                icon,
                color: kPurpleColor,
              ),
              hintText: title,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: kPurpleColor),
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
