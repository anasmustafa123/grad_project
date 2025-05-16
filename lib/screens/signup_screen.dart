import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/validate.dart';
import '../widgets/header/header_widget.dart';
import '../widgets/footer/footer_widget.dart';
import 'signup/components/signup_form_fields.dart';
import 'signup/components/signup_actions.dart';
import '../navigation/app_router.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;

  // String? _validateUsername(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Please enter a username.';
  //   }
  //   if (value.trim().length < 3) {
  //     return 'Username must be at least 3 characters.';
  //   }
  //   return null;
  // }
  //
  // String? _validateEmail(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Please enter an email.';
  //   }
  //   final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  //   if (!emailRegex.hasMatch(value.trim())) {
  //     return 'Please enter a valid email address.';
  //   }
  //   return null;
  // }
  //
  // String? _validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a password.';
  //   }
  //   if (value.length < 6) {
  //     return 'Password must be at least 6 characters long.';
  //   }
  //   return null;
  // }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }



  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async{
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), password: _passwordController.text.trim()
    );
    print(userCredential);
  }

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      try {
        await createUserWithEmailAndPassword();
        Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'email-already-in-use') {
          errorMessage = 'This email is already in use.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is invalid.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'The password is too weak.';
        } else {
          errorMessage = 'Signup failed. Please try again.';
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



  // void _handleSignup() {
  //   if (_formKey.currentState!.validate()) {
  //     // TODO: Implement actual signup logic
  //     Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
  //   }
  // }

  void _handleLogin() {
    Navigator.pushNamed(context, AppRouter.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const HeaderWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  key: const Key('signup'),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                    child: Column(
                      children: [
                        SignupFormFields(
                          usernameController: _usernameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                          isPasswordVisible: _isPasswordVisible,
                          onPasswordVisibilityChanged: (isVisible) {
                            setState(() {
                              _isPasswordVisible = isVisible;
                            });
                          },
                          formKey: _formKey,
                          usernameValidator: Validators.validateUsername,
                          emailValidator: Validators.validateEmail,
                          passwordValidator: Validators.validatePassword,
                          confirmPasswordValidator: _validateConfirmPassword,
                        ),
                        SignupActions(
                          onSignupPressed: _handleSignup,
                          onLoginPressed: _handleLogin,
                        ),
                        // SignupActions(
                        //   onSignupPressed: () async {
                        //     await createUserWithEmailAndPassword();
                        //   },
                        //   onLoginPressed: _handleLogin,
                        // ),
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