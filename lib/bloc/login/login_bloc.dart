import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_management_system/bloc/login/login_event.dart';
import 'package:recruitment_management_system/bloc/login/login_state.dart';
import 'package:recruitment_management_system/database/dbhelper.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(InitialState()){
    on<OnLoginEvent>(_LoginEvent);
    on<OnSignupEvent>(_SignupEvent);
    on<OnForgotEvent>(_ForgotEvent);
    on<OnInitialEvent>(_initialEvent);
  }
  void _LoginEvent(OnLoginEvent event, Emitter<LoginState> emit) async {
    bool isValid = await AppDataBase().checkLoginCredentials(event.email,event.password);
    if (isValid) {
      emit(SnackbarState("Login Successfully"));
      emit(HomeScreenState());
    } else {
      emit(SnackbarState("Invalid username or password"));
    }
  }

  void _SignupEvent(OnSignupEvent event ,Emitter<LoginState>emit) {
    emit(SignupScreenState());
  }
  void _ForgotEvent(OnForgotEvent event,Emitter<LoginState>emit){
    emit(ForgotScreenState());
  }

  void _initialEvent(OnInitialEvent event,Emitter<LoginState>emit)
  {
    emit(InitialState());
  }




}