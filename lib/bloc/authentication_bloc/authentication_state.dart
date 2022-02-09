import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User? firebaseUser;

  AuthenticationSuccess({required this.firebaseUser});

  @override
  List<Object> get props => [firebaseUser!];
}

class AuthenticationFailure extends AuthenticationState {

}