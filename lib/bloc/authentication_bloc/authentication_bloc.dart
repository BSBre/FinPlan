import 'package:bloc/bloc.dart';
import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/authentication_bloc/authentication_event.dart';
import 'package:finplan/bloc/authentication_bloc/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserAuth _userAuth;

  AuthenticationBloc({required UserAuth userAuth})
      : _userAuth = userAuth,
        super(AuthenticationInitial());


  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn){
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }
  //AuthenticationLoggedOut
  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState () async* {
    yield AuthenticationFailure();
    _userAuth.signOut();
  }



  //AuthenticationLoggedIn
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState () async* {
    yield AuthenticationSuccess(firebaseUser: await _userAuth.getUser());
  }


  //AuthenticationStarted
  Stream<AuthenticationState> _mapAuthenticationStartedToState () async* {
    final isSignedIn = await _userAuth.isSignedIn();

    if(isSignedIn) {
      final firebaseUser = await _userAuth.getUser();
      yield AuthenticationSuccess(firebaseUser: firebaseUser!);
    } else {
      yield AuthenticationFailure();
    }
  }
}