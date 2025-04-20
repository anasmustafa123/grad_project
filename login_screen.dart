import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import '../widgets/header/secondary_header/index.dart';
import '../widgets/footer/footer_widget.dart';
import 'login/components/login_form_fields.dart';
import 'login/components/login_actions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement login logic
    }
  }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password screen
  }

  void _handleSignup() {
    // TODO: Navigate to signup page
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
        body: SafeArea(
          child: Column(
            children: [
              const HeaderWidget(),
              const SecondaryHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    key: const Key('login'),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                      child: Column(
                        children: [
                          LoginFormFields(
                            usernameController: _usernameController,
                            passwordController: _passwordController,
                            isPasswordVisible: _isPasswordVisible,
                            onPasswordVisibilityChanged: (isVisible) {
                              setState(() {
                                _isPasswordVisible = isVisible;
                              });
                            },
                            formKey: _formKey,
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
      ),
    );
  }
} 