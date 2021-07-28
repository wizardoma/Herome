import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/commons/app/ui_helpers.dart';

import 'circular_progress_primary.dart';

class LoginButton extends StatelessWidget {
  final Function onSubmit;

  const LoginButton({Key key, this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSubmit,
      child: Container(
        padding: EdgeInsets.all(defaultSpacing * 0.2),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPurpleColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(

          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is AuthenticatingState) {
              return CircularProgress(
                color: kWhiteColor,
              );
            }
            return Text(
              "Log In",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            );
          }),
        ),
      ),
    );
  }
}
