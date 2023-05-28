// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../widgets/auth_widgets/buttons_widget.dart';
import '../../widgets/auth_widgets/text_input_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _topImage(),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const _topTitle(),
                  const SizedBox(
                    height: 44,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Form(
                      key: _formKey,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildTextFormField(
                            controller: emailController,
                            hintText: 'Enter your email',
                            iconName: Icon(Icons.email),
                            inputType: 'email',
                            validatorType: 'emailValid',
                          ),
                          buildTextFormField(
                            controller: passwordController,
                            hintText: 'Password',
                            iconName: Icon(Icons.lock),
                            inputType: 'password',
                            validatorType: 'passwordValid',
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          buildSignInAndSignUpButton(
                            text: 'Login',
                            submitType: 'login',
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            child: Center(
                              child: Text(
                                '--- Or ---',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          buildSignInAndSignUpButton(
                            text: 'Register',
                            submitType: 'register',
                          ),
                          Row(
                            children: [
                              buildForgotPassword(
                                text: 'Forgot your password?',
                                buttonType: 'forgotButton',
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// top image widgets
class _topImage extends StatelessWidget {
  const _topImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey,
      child: Image.network(
        'https://i.pinimg.com/564x/d0/54/14/d0541464bb5055e62b2d98435184ceb6.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

// top title
class _topTitle extends StatelessWidget {
  const _topTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Login Account',
          style: TextStyle(
            color: AppColors.textColor.withOpacity(1),
            fontSize: 26,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Please log in to continue using our professional and convenient healthcare services.',
          style: TextStyle(
            color: AppColors.textColor.withOpacity(0.6),
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Divider(
            height: 1,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
