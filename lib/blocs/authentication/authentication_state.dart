
part of 'authentication_cubit.dart';

enum CurrentUserStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final CurrentUserStatus status;
  final User? user;

  const AuthenticationState._(
      {this.status = CurrentUserStatus.unknown, this.user});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: CurrentUserStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: CurrentUserStatus.unauthenticated);

  @override
  List<Object?> get props => [status,user];
}

