
abstract class SignupState{}

class InitialState extends SignupState{}

class LoginState extends SignupState{}


class SnackbarState extends SignupState {
  final String message;

  SnackbarState(this.message);
}

