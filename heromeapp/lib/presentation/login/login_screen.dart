import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heromeapp/commons/colors.dart';
import 'package:heromeapp/presentation/login/login_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController;
  TextEditingController passwordEditingController;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
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
                    Expanded(child: LoginFormSection()),
                    SignupSection(),
                  ],
                ),
              )
            ],
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              "Log in to your account",
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 25),
            ),
          ),
          emailField(),
          passwordField(),
          loginButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    return LoginTextField(
      title: "Email address",
      icon: Icons.person,
      isPassword: false,
      editingController: emailEditingController,
    );
  }

  Widget passwordField() {
    return LoginTextField(
      title: "Password",
      icon: Icons.lock,
      isPassword: true,
      editingController: passwordEditingController,
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
        onPressed: () {},
        color: kPrimaryColor,
        textColor: kWhiteColor,
        child: Text(
          "Log In",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
