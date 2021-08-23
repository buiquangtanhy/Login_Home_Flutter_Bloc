import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
@override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginInWithEmailButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginInWithEmailButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
