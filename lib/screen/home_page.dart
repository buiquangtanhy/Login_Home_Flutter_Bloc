import 'package:flutter/material.dart';
import 'package:flutter_app_login_bloc/blocs/authentication_bloc.dart';
import 'package:flutter_app_login_bloc/blocs/authentication_event.dart';
import 'package:flutter_app_login_bloc/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {
  final User user;

  const HomePage({ required this.user}) : super();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Welcome, ${user.name}',
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Logout'),
                onPressed: (){
                  authBloc.add(UserLoggedOut());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
