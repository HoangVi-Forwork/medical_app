// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/views/landing/landing_screen.dart';
import '../../../blocs/auth/auth_bloc.dart';
import 'sign_up_utils.dart';
import '../../../widgets/buttons/auth/buttons_widget.dart';
import '../../../widgets/text_input_widgets/auth/text_input_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernamedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LandingScreen(),
            ));
          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/icons/medicine.gif',
                  width: 86,
                  height: 86,
                  filterQuality: FilterQuality.high,
                ),
              ),
            );
          }
          if (state is UnAuthenticated) {
            return _buildSignUpBodyScreen();
          }
          return _buildSignUpBodyScreen();
        },
      ),
    );
  }

  // Body of SignUpScreen
  SingleChildScrollView _buildSignUpBodyScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          topImage(context),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // topTitle(context),
                // const SizedBox(
                //   height: 44,
                // ),
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildTextFormField(
                          controller: emailController,
                          hintText: 'Nhập email',
                          iconName: Icon(Icons.email),
                          inputType: 'email',
                          validatorType: 'emailValid',
                        ),
                        buildTextFormField(
                          controller: usernamedController,
                          hintText: 'Tên đăng nhập',
                          iconName: Icon(Icons.person),
                          inputType: 'username',
                          validatorType: 'usernameValid',
                        ),
                        buildTextFormField(
                          controller: passwordController,
                          hintText: 'Mật khẩu',
                          iconName: Icon(Icons.lock),
                          inputType: 'password',
                          validatorType: 'passwordValid',
                        ),
                        buildTextFormField(
                          controller: passwordController,
                          hintText: 'Nhập lại mật khẩu',
                          iconName: Icon(Icons.lock),
                          inputType: 'password',
                          validatorType: 'passwordValid',
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        BuildSignUpButton(
                          text: 'Đăng ký',
                          submitType: 'register',
                          submitButton: () {
                            //_createNewAccountWithEmailAndPassword(context);
                          },
                        ),
                        Row(
                          children: [
                            BuildComeBackButton(
                              text: 'Tôi đã có tài khoản',
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
    );
  }

  // void _createNewAccountWithEmailAndPassword(context) {
  //   if (_formKey.currentState!.validate()) {
  //     BlocProvider.of<AuthBloc>(context).add(
  //       SignUpRequested(emailController.text, passwordController.text),
  //     );
  //   }
  // }
}
