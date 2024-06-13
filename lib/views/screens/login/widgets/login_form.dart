import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnix_admin/bloc/auth/auth_bloc.dart';
import 'package:furnix_admin/utils/constants/colors.dart';
import 'package:furnix_admin/utils/device/responsive.dart';
import 'package:furnix_admin/views/screens/login/widgets/elevated_button.dart';
import 'package:furnix_admin/views/screens/login/widgets/text_form_field.dart';

Form loginForm(
    BuildContext context,
    AuthBloc authBloc,
    GlobalKey<FormState> formKey,
    TextEditingController passwordController,
    TextEditingController emailController) {
  return Form(
    key: formKey,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          
          // alignment: Alignment.bottomCenter,
          height: getHeight(context)*0.7,
          width: getWidth(context)*0.3,
          child: Card(
          elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: getWidth(context) * 0.3,
                  // ),
                  
                  const Text('Welcome Back'),
                  const Text('Login to your account'),
                  const SizedBox(
                    height: 20,
                  ),
                  FormContainerWidget(
                    isPassword: false,
                    inputType: TextInputType.emailAddress,
                    icon: CupertinoIcons.mail,
                    hintText: 'Email address',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                      inputType: TextInputType.name,
                      icon: Icons.lock_outlined,
                      hintText: 'Password',
                      isPassword: true,
                      controller: passwordController),
                  const SizedBox(
                    height: 20,
                  ),
                  elevatedButton(
                      text: 'Sign In',
                      context: context,
              
                      onTap: () {
                        _loginClicked(
                            authBloc: authBloc,
                            emailController: emailController,
                            passwordController: passwordController,formKey: formKey);
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(onTap: (){
                    // Navigator.push(context, rightToLeft(ForgotPasswordPage()));
                  },child: const Text('Forgot Password?',style: TextStyle(color: FColors.primaryColor),)),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                 
                  
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<void> _loginClicked(
    {required AuthBloc authBloc,
    required passwordController,
    required emailController,required GlobalKey<FormState> formKey}) async {
    if(formKey.currentState!.validate()){
  authBloc.add(
    AuthLoginRequested(
      email: emailController.text,
      password: passwordController.text,
    ),
  );
    }
}
