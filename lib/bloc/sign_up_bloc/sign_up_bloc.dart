import 'package:bloc/bloc.dart';
import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:finplan/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:finplan/utilities/validators.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserAuth _userAuth;

  SignUpBloc({required UserAuth userAuth})
      : _userAuth = userAuth,
        super(SignUpState.initial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpEmailChange) {
      yield* _mapSignUpEmailChangeToState(event.email);
    } else if (event is SignUpPasswordChange) {
      yield* _mapSignUpPasswordChangeToState(event.password);
    } else if (event is SignUpWithCredentialsPressed) {
      yield* _mapSignUpWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<SignUpState> _mapSignUpEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email), isPasswordValid: false);
  }

  Stream<SignUpState> _mapSignUpPasswordChangeToState(String password) async* {
    yield state.update(isEmailValid: false, isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<SignUpState> _mapSignUpWithCredentialsPressedToState({required String email, required String password}) async* {
    yield SignUpState.loading();
    try {
      await _userAuth.signUp(email, password);
      yield SignUpState.success();
    } catch (e) {
      yield SignUpState.failure();
      print(e);
    }
  }
}
