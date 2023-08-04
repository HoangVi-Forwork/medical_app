// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, camel_case_types, unused_element

import 'package:flutter/material.dart';
import '../../../views/auth/sign_up/sign_up_screen.dart';
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

// FORGOT PASSWORD BUTTON - CALL UPDATE PASSWORD FORM
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

// SUBMIT SIGNIN BUTTON - USING INTO LOGIN SCREEN
// IF "submitType == login" -> NAVIAGTOR TO LANDINGCREEN
// ELSE -> CALL RESIGTER FORM
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

  // TOP TITLE
  Container _topTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Đăng ký tài khoản',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            'Tạo tài khoản để nhận những thông tin mới nhất',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // SUBMIT RESIGTER BUTTON
  GestureDetector resigterButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 48,
        margin: const EdgeInsets.only(top: 36),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: GestureDetector(
          child: const Center(
            child: Text('Gữi mã xác nhận'),
          ),
        ),
      ),
    );
  }

  // INPUT TEXTFORMFIELD
  Container buildResigerTextFormField(String lableText, iconName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: lableText.toString(),
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          prefixIcon: Icon(
            iconName,
            color: Colors.white,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// SUBMIT RESIGTER BUTTON - USING INTO SIGNUP SCREEN
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
