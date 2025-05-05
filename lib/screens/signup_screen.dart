import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement actual signup logic
      Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
    }
  }

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
                        ),
                        SignupActions(
                          onSignupPressed: _handleSignup,
                          onLoginPressed: _handleLogin,
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