import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_management_system/bloc/signup/signup_event.dart';
import 'package:recruitment_management_system/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(InitialState()) {
    on<OnSignupEvent>(_LoginEvent);
    on<OnLoginEvent>(_SignupEvent);
  }
  void _LoginEvent(OnSignupEvent event, Emitter<SignupState> emit) {
    emit(LoginState());
  }

  void _SignupEvent(OnLoginEvent event, Emitter<SignupState> emit) {
    emit(SnackbarState("SignUp Successfully"));
    emit(LoginState());
  }
}
