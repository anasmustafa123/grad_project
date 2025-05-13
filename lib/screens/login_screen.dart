import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/validate.dart';
import '../widgets/header/header_widget.dart';
import '../widgets/footer/footer_widget.dart';
import 'login/components/login_form_fields.dart';
import 'login/components/login_actions.dart';
import '../navigation/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Bypass authentication and go directly to home page
    if (_formKey.currentState!.validate()) {
      try {
        await loginUserWithEmailAndPassword();
        Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        errorMessage = e.code;
        if (e.code == 'invalid-credential') {
          errorMessage = 'Invalid Email or Password';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred.')),
        );
      }
    }
  }


  Future<void> loginUserWithEmailAndPassword() async {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(), password: _passwordController.text.trim()
      );
      print(userCredential);
  }

  // Future<void> createUserWithEmailAndPassword() async{
  //   final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _emailController.text.trim(), password: _passwordController.text.trim()
  //   );
  //   print(userCredential);
  // }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password screen
  }

  void _handleSignup() {
    Navigator.pushNamed(context, AppRouter.signupRoute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const HeaderWidget(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginFormFields(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          isPasswordVisible: _isPasswordVisible,
                          onPasswordVisibilityChanged: (isVisible) {
                            setState(() {
                              _isPasswordVisible = isVisible;
                            });
                          },
                          formKey: _formKey,
                          emailValidator: Validators.validateEmail,
                          passwordValidator: Validators.validatePassword,
                        ),
                        LoginActions(
                          onLoginPressed: _handleLogin,
                          onForgotPasswordPressed: _handleForgotPassword,
                          onSignupPressed: _handleSignup,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
} 