import 'package:bloc/bloc.dart';
import 'package:flutter_app_login_bloc/model/user.dart';
import 'package:flutter_app_login_bloc/services/service.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
      : _authenticationService = authenticationService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final User? currentUser = await _authenticationService.getCurrentUser();

      if (currentUser != null) {
        print(currentUser);
        yield AuthenticationAuthenticated(user: currentUser);
        print(currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(message: 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }
}
