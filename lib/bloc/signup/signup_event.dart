abstract class SignupEvent{}

class OnSignupSuccessEvent extends SignupEvent{
  final String username;
  final String email;
  final String password;
  final String phone;
  OnSignupSuccessEvent(
       this.username,
         this.email,
         this.password,
         this.phone);
}

class OnSignupFailureEvent extends SignupEvent{
  final String message;
  OnSignupFailureEvent({required this.message});
}

class OnLoginEvent extends SignupEvent{}
