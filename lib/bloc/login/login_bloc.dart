import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_management_system/bloc/login/login_event.dart';
import 'package:recruitment_management_system/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(InitialState()){
    on<OnLoginEvent>(_LoginEvent);
    on<OnSignupEvent>(_SignupEvent);
    on<OnForgotEvent>(_ForgotEvent);
  }

  void _LoginEvent(OnLoginEvent event , Emitter<LoginState>emit){
    emit(SnackbarState("Login Successfully"));
    emit(HomeScreenState());
  }
  void _SignupEvent(OnSignupEvent event ,Emitter<LoginState>emit) {
    emit(SignupScreenState());
  }
  void _ForgotEvent(OnForgotEvent event,Emitter<LoginState>emit){
    emit(ForgotScreenState());
  }
}