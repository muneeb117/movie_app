import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/view/screens/sign_in/bloc/signin_events.dart';
import 'package:movie_app/view/screens/sign_in/bloc/signin_states.dart';

class SignInBlocs extends Bloc<SignInEvents, SignInState> {
  SignInBlocs() : super(const SignInState()) {
    on<EmailEvents>(_emailEvent);
    on<PasswordEvents>(_passwordEvent);
  }
  void _emailEvent(EmailEvents event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvents event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }
}
