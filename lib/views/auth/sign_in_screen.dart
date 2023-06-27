import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/views/home_screen.dart';
import 'package:medical_app/views/landing_screen.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../utils/sign_in_utils.dart';
import '../../widgets/buttons/auth/buttons_widget.dart';
import '../../widgets/text_input_widgets/auth/text_input_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';

  void login() async {
  const String apiUrl = 'http://localhost:5090/login';
  final response = await http.post(Uri.parse(apiUrl), body: {
    'email': emailController.text,
    'password': passwordController.text,
  });

  final responseBody = json.decode(response.body);

  if (response.statusCode == 200) {
    // Đăng nhập thành công
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LandingScreen()),
    );
  } else {
    // Hiển thị thông báo lỗi đăng nhập
    setState(() {
      message = responseBody['message'];
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LandingScreen()));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
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
            if (state is UnAuthenticated) _buildSignInScreen(context);
            return _buildSignInScreen(context);
          },
        ),
      ),
    );
  }

  //! MAIN LOGIN SCREEN BODY
  SingleChildScrollView _buildSignInScreen(BuildContext context) {
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
                topTile(context),
                // TopImage(),
                const SizedBox(
                  height: 44,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Form(
                    key: _formKey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            
                            message, 
                            style: TextStyle(
                              color:
                                 const Color.fromARGB(255, 255, 0, 0).withOpacity(1),
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                        
                            ),
                          ),
                        ),
                        buildTextFormField(
                          controller: emailController,
                          hintText: 'Tên đăng nhập',
                          iconName: const Icon(Icons.email),
                          inputType: 'email',
                          validatorType: 'emailValid',
                        ),
                        buildTextFormField(
                          controller: passwordController,
                          hintText: 'Mật khẩu',
                          iconName: const Icon(Icons.lock),
                          inputType: 'password',
                          validatorType: 'passwordValid',
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        buildSignInButton(
                          text: 'Login',
                          submitType: 'login',
                          submitButton: () {
                            login();
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: const Center(
                            child: Text(
                              '--- Or ---',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        buildSignInButton(
                          text: 'Register',
                          submitType: 'register',
                          submitButton: () {},
                        ),
                        Row(
                          children: [
                            buildForgotPassword(
                              submitButton: () {},
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
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(emailController.text, passwordController.text),
      );
    }
  }
}
