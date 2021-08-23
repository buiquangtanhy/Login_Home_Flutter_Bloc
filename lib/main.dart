import 'package:flutter/material.dart';
import 'package:flutter_app_login_bloc/screen/home_page.dart';
import 'package:flutter_app_login_bloc/screen/login_page.dart';
import 'package:flutter_app_login_bloc/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_event.dart';
import 'blocs/authentication_state.dart';

void main() => runApp(
  // Injects the Authentication service
    RepositoryProvider<AuthenticationService>(
      create: (context) {
        return FakeAuthenticationService();
      },
      // Injects the Authentication BLoC
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          final authService = RepositoryProvider.of<AuthenticationService>(context);
          return AuthenticationBloc(authService)..add(AppLoaded());
        },
        child: MyApp(),
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // show home page
            return HomePage(
              user: state.user,
            );
          }
          // otherwise show login page
          return LoginPage();
        },
      ),
    );
  }
}
