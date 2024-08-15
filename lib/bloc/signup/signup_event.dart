abstract class SignupEvent{}

class OnSignupSuccessEvent extends SignupEvent{
  final String username;
  final String email;
  final String password;
  final String phone;
  final String designation;
  OnSignupSuccessEvent({
     required  this.username,
        required this.email,
       required  this.password,
        required this.phone,
        required this.designation
  });
}

class OnSignupFailureEvent extends SignupEvent{
  final String message;
  OnSignupFailureEvent({required this.message});
}

class OnLoginEvent extends SignupEvent{}
