abstract class LoginState{}

class InitialState extends LoginState{}

class HomeScreenState extends LoginState{}

class SignupScreenState extends LoginState{}

class ForgotScreenState extends LoginState{}

class SnackbarState extends LoginState {
  final String message;

  SnackbarState(this.message);
}