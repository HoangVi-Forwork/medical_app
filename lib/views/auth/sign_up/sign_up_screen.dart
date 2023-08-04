import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../config/url_config.dart';
import '../../../widgets/buttons/auth/buttons_widget.dart';
import '../../landing/landing_screen.dart';
import '../sign_in/sign_in_screen.dart';
import '../sign_in/sign_in_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

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
          return _buildSignUpBodyScreen();
        },
      ),
    );
  }

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
                          controller: usernameController,
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
                          controller: confirmPasswordController,
                          hintText: 'Nhập lại mật khẩu',
                          iconName: Icon(Icons.lock),
                          inputType: 'password',
                          validatorType: 'confirmPasswordValid',
                          passwordController: passwordController,
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        BuildSignUpButton(
                          text: 'Đăng ký',
                          submitType: 'register',
                          submitButton: () {
                            _createNewAccountWithEmailAndPassword(context);
                          },
                        ),
                        Row(
                          children: [
                            BuildComeBackButton(
                              text: '',
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

  void _createNewAccountWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> userData = {
        'email': emailController.text,
        'password': passwordController.text,
        'setpassword': confirmPasswordController.text,
        'ten': usernameController.text,
      };

      final response = await http.post(
        Uri.parse(
            '${Configs.IP4Local}api/registerd'), // Replace with your backend URL
        body: userData,
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ));
      } else if (response.statusCode == 400) {
        final errorMessage = json.decode(response.body)['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Đã xảy ra lỗi. Vui lòng thử lại sau.'),
        ));
      }
    }
  }
}

Widget buildTextFormField({
  required TextEditingController controller,
  required String hintText,
  required Icon iconName,
  required String inputType,
  required String validatorType,
  TextEditingController? passwordController,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: iconName,
    ),
    obscureText: inputType == 'password',
    validator: (value) {
      if (validatorType == 'emailValid') {
        if (value!.isEmpty) {
          return 'Vui lòng nhập email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Email không hợp lệ';
        }
        return null;
      } else if (validatorType == 'usernameValid') {
        // Validate username (optional, you can add your own rules)
        return null;
      } else if (validatorType == 'passwordValid') {
        if (value!.isEmpty) {
          return 'Vui lòng nhập mật khẩu';
        }
        if (value.length < 8) {
          return 'Mật khẩu phải có ít nhất 8 ký tự';
        }
        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z\d]{8,}$')
            .hasMatch(value)) {
          return 'Mật khẩu phải chứa ít nhất 1 chữ hoa và 1 chữ thường';
        }
        return null;
      } else if (validatorType == 'confirmPasswordValid') {
        if (value!.isEmpty) {
          return 'Vui lòng nhập lại mật khẩu';
        }
        if (value != passwordController?.text) {
          return 'Mật khẩu không khớp';
        }
        return null;
      }
      return null;
    },
  );
}
