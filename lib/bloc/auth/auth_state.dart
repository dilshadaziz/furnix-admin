part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthError extends AuthState {}

final class AuthLoading extends AuthState{}
final class AuthSuccess extends AuthState{}