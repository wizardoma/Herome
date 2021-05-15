import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/application/authentication/login_request.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/commons/utils/input_validator.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_screen.dart';
import 'package:heromeapp/presentation/login/login_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputValidator {
  var _formkey = GlobalKey<FormState>();
  TextEditingController _emailEditingController;
  TextEditingController _passwordEditingController;
  var isSubmitError = false;
  var serverErrorMessage = "An error occurred";

  @override
  void initState() {
    _emailEditingController = new TextEditingController();
    _passwordEditingController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (ctx, state) {
            if (state is Authenticated)
              Navigator.pushReplacementNamed(
                  context, DashboardScreen.routeName);
          },
          child: Container(
            alignment: Alignment.center,
            width: size.width,
            height: size.height,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: 30),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kDeepPurple1, kDeepPurple2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.6, 1])),
            child: Column(
              children: [
                Container(
                  height: size.height * 0.3,
                  child: Image.asset(
                    "assets/logos/logo.jpg",
                    width: 100,
                    height: 100,
                  ),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoginFormSection(),
                      SignupSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SignupSection() {
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
              style: Theme.of(context).textTheme.headline1.copyWith(
                    decoration: TextDecoration.underline,
                    fontSize: 17,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget LoginFormSection() {
    return Expanded(
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (BuildContext context, state) {
          if (state is AuthenticationError) {
            setState(() {
              isSubmitError = true;
              serverErrorMessage = state.errorMessage;
            });
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    "Log in to your account",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 25),
                  ),
                ),
                if (isSubmitError) errorAlert(),
                emailField(),
                passwordField(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget errorAlert() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: kerrorBgColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kerrorBorderColor),
      ),
      child: Center(
        child: Text(
          serverErrorMessage,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }

  Widget emailField() {
    return LoginTextField(
      title: "Email address",
      icon: Icons.person,
      isPassword: false,
      validator: validateEmail,
      editingController: _emailEditingController,
    );
  }

  Widget passwordField() {
    return LoginTextField(
      title: "Password",
      icon: Icons.lock,
      validator: validatePassword,
      isPassword: true,
      editingController: _passwordEditingController,
    );
  }

  Widget loginButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
        onPressed: submit,
        color: kPrimaryColor,
        textColor: kWhiteColor,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          print(state);
          if (state is Authenticating) {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kWhiteColor),
            );
          }
          return Text(
            "Log In",
            style: TextStyle(fontSize: 20),
          );
        }),
      ),
    );
  }

  void submit() {
    setState(() {
      isSubmitError = false;
    });
    if (_formkey.currentState.validate()) {
      var email = _emailEditingController.text.toLowerCase().trim();
      var password = _passwordEditingController.text;
      LoginRequest loginRequest = LoginRequest(email, password);
      print("email: $email , password: $password");
      context.read<AuthenticationBloc>().add(LoginEvent(loginRequest));
    }
  }
}
