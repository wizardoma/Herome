import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/commons/app/colors.dart';

import 'circular_progress_primary.dart';

class LoginButton extends StatelessWidget {
  final Function onSubmit;

  const LoginButton({Key key, this.onSubmit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        color: kPurpleColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: GestureDetector(
        onTap: onSubmit,
        child: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is Authenticating) {
                  return CircularProgress(
                    color: kWhiteColor,
                  );
                }
                return Text(
                  "Log In",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                );
              }),
        ),
      ),
    );

  }
}
