import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/auth/auth_bloc.dart';
import 'package:furnix_admin/bloc/product/product_bloc.dart';
import 'package:furnix_admin/bloc/side_bar/side_menu_bar_bloc.dart';
import 'package:furnix_admin/views/screens/home/home_screen.dart';
import 'package:furnix_admin/views/screens/login/login_screen.dart';

class BlocProviderScope extends StatelessWidget {
  const BlocProviderScope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => SideMenuBarBloc()),
        BlocProvider(create:(context)=>ProductBloc()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const HomeScreen()),
    );
  }
}
