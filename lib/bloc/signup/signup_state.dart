abstract class SignupState {}

class InitialState extends SignupState {}

class AlreadySignupState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupFailureState extends SignupState {
  final String message;
  SignupFailureState({required this.message});
}
