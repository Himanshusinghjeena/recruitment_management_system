abstract class LoginEvent {}

class OnInitialEvent extends LoginEvent {}

class OnLoginEvent extends LoginEvent {
  final String email;
  final String password;

  OnLoginEvent({required this.email, required this.password});
}

class OnSignupEvent extends LoginEvent {}

class OnForgotEvent extends LoginEvent {}
