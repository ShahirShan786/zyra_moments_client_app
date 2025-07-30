part of 'auth_sign_bloc.dart';

sealed class AuthSignEvent extends Equatable {
  const AuthSignEvent();

  @override
  List<Object> get props => [];
}

//  Save first page data
class FirstPageSubmitted extends AuthSignEvent{
  final String firstName;
  final String lastName;
  final String phone;

  const FirstPageSubmitted({required this.firstName, required this.lastName, required this.phone});

    @override
  List<Object> get props => [firstName , lastName , phone]; 

}

// Save second page data
class RegisterUserEvent extends AuthSignEvent{
  final String email;
  final String password;
  final String? confirmPassword;

  const RegisterUserEvent({required this.email, required this.password, this.confirmPassword});


  @override
  List<Object> get props => [email , password , confirmPassword!]; 
}


class RegisteWIthGoogleEvent extends AuthSignEvent{
  const RegisteWIthGoogleEvent();
}
  
class  ToggleSignPasswordVisibilityEvent extends AuthSignEvent{}