import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override

  List<Object?> get props => [];
}

class SignUpEmailChange extends SignUpEvent {
  final String email;

  SignUpEmailChange({required this.email});

  @override
  List<Object?> get props => [email];

}

class SignUpPasswordChange extends SignUpEvent {
  final String password;

  SignUpPasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class SignUpWithCredentialsPressed extends SignUpEvent {
  final String email;
  final String password;

  SignUpWithCredentialsPressed({required this.email,required this.password});

  @override
  List<Object?> get props => [email, password];
}