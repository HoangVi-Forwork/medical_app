// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:medical_app/views/auth/sign_up_screen.dart';
import '../../colors.dart';

class BuildComeBackButton extends StatelessWidget {
  String text;
  BuildComeBackButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}

class BuildForgotPassword extends StatelessWidget {
  String text;
  String buttonType;
  final Function submitButton;

  BuildForgotPassword({
    Key? key,
    required this.text,
    required this.buttonType,
    required this.submitButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: submitButton(),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}

@immutable
class buildSignInButton extends StatelessWidget {
  String text;
  String submitType;
  Function submitButton;
  buildSignInButton({
    Key? key,
    required this.text,
    required this.submitType,
    required this.submitButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: submitType == 'login'
          ? () {
              submitButton();
            }
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              );
            },
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: submitType == 'login' ? AppColors.primaryColor : Colors.white,
          border: submitType == 'login'
              ? null
              : Border.all(
                  width: 1,
                  color: Colors.black,
                ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 12.0,
              spreadRadius: 0.0,
              offset: const Offset(0.0, 0.1),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color:
                  submitType == 'login' ? AppColors.whiteColor : Colors.black,
              fontSize: 16,
              fontWeight:
                  submitType == 'login' ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class BuildSignUpButton extends StatelessWidget {
  final String text;
  final String submitType;
  final Function submitButton;
  const BuildSignUpButton({
    Key? key,
    required this.text,
    required this.submitType,
    required this.submitButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        submitButton();
      },
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: submitType == 'login' ? AppColors.primaryColor : Colors.white,
          border: submitType == 'login'
              ? null
              : Border.all(
                  width: 1,
                  color: Colors.black,
                ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color:
                  submitType == 'login' ? AppColors.whiteColor : Colors.black,
              fontSize: 16,
              fontWeight:
                  submitType == 'login' ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
