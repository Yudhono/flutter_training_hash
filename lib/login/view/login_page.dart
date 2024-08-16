import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:new_shop/login/bloc/login_bloc.dart';
import 'package:new_shop/login/request/login_request.dart';

class CustomLoginScreen extends StatefulWidget {
  const CustomLoginScreen({super.key});

  @override
  _CustomLoginScreenState createState() => _CustomLoginScreenState();
}

class _CustomLoginScreenState extends State<CustomLoginScreen> {
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isUsernameFocused = false;
  bool _isPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {
        _isUsernameFocused = _usernameFocusNode.hasFocus;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFocused = _passwordFocusNode.hasFocus;
      });
    });

    context.read<LoginBloc>().add(SystemCheckTokenEvent());
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool? _validate() {
    return _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Login.png',
              height: 100,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.of(context).pushNamed('/home');
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return LoginForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isUsernameFocused: _isUsernameFocused,
                  isPasswordFocused: _isPasswordFocused,
                  usernameFocusNode: _usernameFocusNode,
                  passwordFocusNode: _passwordFocusNode,
                );
              },
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_validate() != null && _validate()!) {
                            context.read<LoginBloc>().add(
                                  UserTapLoginButtonEvent(
                                    request: LoginRequest(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  ),
                                );
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              _navigateAndWaitForResult(context);
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 1.5,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              // Add Forgot Password functionality here
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateAndWaitForResult(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/register');
    if (!context.mounted) return;

    if (result != null) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('$result'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
    }
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isUsernameFocused,
    required this.isPasswordFocused,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isUsernameFocused;
  final bool isPasswordFocused;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            focusNode: usernameFocusNode,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: isUsernameFocused ? Colors.blue : Colors.grey,
              ),
              border: const OutlineInputBorder(),
            ),
            validator: ValidationBuilder().email().build(),
            controller: emailController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            focusNode: passwordFocusNode,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(
                color: isPasswordFocused ? Colors.blue : Colors.grey,
              ),
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
            validator: ValidationBuilder().minLength(5).maxLength(50).build(),
            controller: passwordController,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
