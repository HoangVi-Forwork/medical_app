import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/views/landing_screen.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../blocs/bloc/auth_bloc.dart';
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
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
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
                  margin: const EdgeInsets.only(bottom: 40),
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
                          iconName: const Icon(Icons.email),
                          inputType: 'email',
                          validatorType: 'emailValid',
                        ),
                        buildTextFormField(
                          controller: passwordController,
                          hintText: 'Password',
                          iconName: const Icon(Icons.lock),
                          inputType: 'password',
                          validatorType: 'passwordValid',
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        buildSignInAndSignUpButton(
                          text: 'Login',
                          submitType: 'login',
                          submitButton: () {
                            _authenticateWithEmailAndPassword(context);
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
                        buildSignInAndSignUpButton(
                          text: 'Register',
                          submitType: 'register',
                          submitButton: () {},
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
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: const Divider(
            height: 1,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
