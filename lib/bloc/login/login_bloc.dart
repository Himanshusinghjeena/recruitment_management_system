import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_management_system/Services/dbhelper.dart';
import 'package:recruitment_management_system/bloc/login/login_event.dart';
import 'package:recruitment_management_system/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(InitialState()){
    on<OnLoginEvent>(_LoginEvent);
    on<OnSignupEvent>(_SignupEvent);
    on<OnForgotEvent>(_ForgotEvent);
    on<OnInitialEvent>(_initialEvent);
  }
  void _LoginEvent(OnLoginEvent event, Emitter<LoginState> emit) async {
    print("Event Called");
    print(event.email);
    print(event.password);
    bool isValid = await AppDataBase().checkLoginCredentials(event.email,event.password);
    if (isValid) {
      emit(LoginSuccessState());
    } else {
      emit(LoginFailureState("Invalid username or password"));
    }
  }

  void _SignupEvent(OnSignupEvent event ,Emitter<LoginState>emit) {
    emit(SignupState());
  }
  void _ForgotEvent(OnForgotEvent event,Emitter<LoginState>emit){
    emit(ForgotPassState());
  }

  void _initialEvent(OnInitialEvent event,Emitter<LoginState>emit)
  {
    emit(InitialState());
  }




}