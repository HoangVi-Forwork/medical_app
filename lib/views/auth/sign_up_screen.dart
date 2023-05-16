// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../widgets/auth_widgets/buttons_widget.dart';
import '../../widgets/auth_widgets/text_input_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernamedController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 14,
              ),
            ),
          ),
        ),
      ),
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
                            controller: usernamedController,
                            hintText: 'Username',
                            iconName: Icon(Icons.person),
                            inputType: 'username',
                            validatorType: 'usernameValid',
                          ),
                          buildTextFormField(
                            controller: passwordController,
                            hintText: 'Password',
                            iconName: Icon(Icons.lock),
                            inputType: 'password',
                            validatorType: 'passwordValid',
                          ),
                          SizedBox(
                            height: 36,
                          ),
                          buildSignInAndSignUpButton(
                            text: 'Register',
                            submitType: 'register',
                            submitButton: () {},
                          ),
                          Row(
                            children: [
                              buildComeBackButton(
                                text: 'I have a account!',
                              ),
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
        'https://i.pinimg.com/564x/e0/c8/0e/e0c80e4c6fad4391f14d371f9d86683f.jpg',
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
          'Sign Up',
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
          'Register to become a member of our healthcare community and experience top-notch healthcare services. ',
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
