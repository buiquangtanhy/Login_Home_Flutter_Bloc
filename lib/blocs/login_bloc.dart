import 'package:bloc/bloc.dart';
import 'package:flutter_app_login_bloc/model/user.dart';
import 'package:flutter_app_login_bloc/services/authentication.dart';
import 'package:flutter_app_login_bloc/services/service.dart';
import 'authentication_bloc.dart';
import 'authentication_event.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  LoginBloc(AuthenticationBloc authenticationBloc, AuthenticationService authenticationService)
      : _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      final user = await _authenticationService.signInWithEmailAndPassword(event.email, event.password);
      if (user != User(name: '', email: '')) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } on AuthenticationException catch (e) {
      yield LoginFailure(error: e.message);
    } catch (err) {
      yield LoginFailure(error: 'An unknown error occured');
    }
  }
}
