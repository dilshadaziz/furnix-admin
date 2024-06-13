import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/auth/auth_bloc.dart';
import 'package:furnix_admin/navigations/right_to_left.dart';
import 'package:furnix_admin/utils/constants/toasts.dart';
import 'package:furnix_admin/views/screens/home/home_screen.dart';
import 'package:furnix_admin/views/screens/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Login"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              rightToLeft(const HomeScreen(),
                  duration: const Duration(milliseconds: 350)),
              (route) => false,
            );
          } else if (state is AuthError) {
            print('auth error');
            toast('email or password is incorrect');
          }
        },
        builder: (context, state) {
          // if (state is AuthLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          return SafeArea(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: loginForm(context, authBloc, _formKey, emailController,
                passwordController),
          ));
        },
      ),
    );
  }
}
