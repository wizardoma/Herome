import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/application/authentication/login_request.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/commons/app/ui_helpers.dart';
import 'package:heromeapp/commons/utils/input_validator.dart';
import 'package:heromeapp/presentation/app/app_screen.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_screen.dart';
import 'package:heromeapp/presentation/login/login_textfield.dart';
import 'package:heromeapp/presentation/login/signup_section.dart';
import 'package:heromeapp/presentation/widgets/error_alert_widget.dart';
import 'package:heromeapp/presentation/widgets/login_button.dart';

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

  bool isObscure = true;

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
          listener: (ctx, state) async {
            if (state is AuthenticatedState) {
              var list = await context.read<AppsCubit>().fetchApps();
              var screenName = list.isEmpty
                  ? DashboardScreen.routeName
                  : AppScreen.routeName;
              Navigator.pushReplacementNamed(context, screenName);
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: size.width,
            height: size.height,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: defaultSpacing * 2),
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
                      Expanded(
                        child: LoginFormSection(),
                      ),
                      SignUpSection(),
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

  Widget LoginFormSection() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, state) {
        if (state is AuthenticationErrorState) {
          setState(() {
            isSubmitError = true;
            serverErrorMessage = state.errorMessage;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: defaultSpacing, horizontal: defaultSpacing),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  "Log in to your account",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 25,
                        color: kPurpleColor,
                      ),
                ),
              ),
              if (isSubmitError) ErrorAlertWidget(message: serverErrorMessage),
              LoginTextField(
                title: "Email address",
                icon: Icons.person,
                isPassword: false,
                validator: validateEmail,
                editingController: _emailEditingController,
              ),
              LoginTextField(
                isObscure: isObscure,
                toggleObscurity: toggleObscurity,
                title: "Password",
                icon: Icons.lock,
                validator: validatePassword,
                isPassword: true,
                editingController: _passwordEditingController,
              ),
              LoginButton(
                onSubmit: submit,
              ),
            ],
          ),
        ),
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
      context.read<AuthenticationBloc>().add(LoginEvent(loginRequest));
    }
  }

  void toggleObscurity() {
    setState(() {
      isObscure = !isObscure;
    });
  }
}
