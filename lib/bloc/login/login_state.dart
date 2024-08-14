abstract class LoginState{}

class InitialState extends LoginState{}

class LoginSuccessState extends LoginState{}

class LoginFailureState extends LoginState{
  final String message;

  LoginFailureState(this.message);
}

class SignupState extends LoginState {}

class ForgotPassState extends LoginState {}