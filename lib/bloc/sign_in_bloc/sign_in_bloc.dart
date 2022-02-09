import 'package:bloc/bloc.dart';
import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:finplan/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:finplan/utilities/validators.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserAuth _userAuth;

  SignInBloc({required UserAuth userAuth})
      : _userAuth = userAuth,
        super(SignInState.initial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInEmailChange) {
      yield* _mapSignInEmailChangeToState(event.email);
    } else if (event is SignInPasswordChange) {
      yield* _mapSignInPasswordChangeToState(event.password);
    } else if (event is SignInWithCredentialsPressed) {
      yield* _mapSignInWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<SignInState> _mapSignInEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email), isPasswordValid: false);
  }

  Stream<SignInState> _mapSignInPasswordChangeToState(String password) async* {
    yield state.update(isEmailValid: false, isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<SignInState> _mapSignInWithCredentialsPressedToState({required String email, required String password}) async* {
    yield SignInState.loading();
    try {
      await _userAuth.signInWithCredentials(email, password);
      yield SignInState.success();
    } catch (e) {
      yield SignInState.failure();
      print(e);
    }
  }
}
