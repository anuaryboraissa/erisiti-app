import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:erisiti/src/features/services/enpoints/register.dart';

import 'package:meta/meta.dart';

import '../../../services/enpoints/forgetPassword/forget_password.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>(registerEvent);
    on<ValidateTinNumberEvent>(validateTinNumberEvent);
    on<ValidateAccountEvent>(validateAccountEvent);
    on<ValidatePasswordEvent>(validatePasswordEvent);
    on<ValidatePasswordMatchEvent>(validatePasswordMatchEvent);
    on<StoreStateEvent>(storeStateEvent);
    on<RegistrationEvent>(registrationEvent);
    on<ResetPasswordEvent>(resetPasswordEvent);
  }

  FutureOr<void> registerEvent(
      RegisterEvent event, Emitter<RegisterState> emit) {}

  FutureOr<void> validateTinNumberEvent(
      ValidateTinNumberEvent event, Emitter<RegisterState> emit) {
    if (isInteger(int.parse(event.tinNumber)) && event.tinNumber.length == 9) {
      emit(ValidateTinNumberState(true));
    } else {
      emit(ValidateTinNumberState(false));
    }
  }

  FutureOr<void> validateAccountEvent(
      ValidateAccountEvent event, Emitter<RegisterState> emit) {
    if (event.userAccount == "User" || event.userAccount == "Business") {
      emit(ValidateUserAccountState(true));
    } else {
      emit(ValidateUserAccountState(false));
    }
  }

  FutureOr<void> validatePasswordEvent(
      ValidatePasswordEvent event, Emitter<RegisterState> emit) {
    if (isPasswordCompliant(event.password)) {
      emit(ValidatePasswordState(true));
    } else {
      emit(ValidatePasswordState(false));
    }
  }

  FutureOr<void> validatePasswordMatchEvent(
      ValidatePasswordMatchEvent event, Emitter<RegisterState> emit) {
    if (event.password == event.passwordConfirm) {
      emit(ValidatePasswordMatchState(true));
    } else {
      emit(ValidatePasswordMatchState(false));
    }
  }

  bool isPasswordCompliant(String password, [int minLength = 7]) {
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  FutureOr<void> storeStateEvent(
      StoreStateEvent event, Emitter<RegisterState> emit) {
    emit(StoredUserState(event.validity));
  }

  FutureOr<void> registrationEvent(
      RegistrationEvent event, Emitter<RegisterState> emit) async {
    if (event.password == event.passwordConfirm) {
      var result = await RegistrationService().registerUser(event.tinNumber,
          event.account, event.password, event.passwordConfirm);
      emit(RegistrationState(result));
    } else {
      emit(RegistrationState(
          const {"message": "passwords doesn't match ", "status": "fail"}));
    }
  }

  FutureOr<void> resetPasswordEvent(
      ResetPasswordEvent event, Emitter<RegisterState> emit) async {
    if (event.newPassword == event.rptPassword) {
      final response = await ForgetPasswordService.forgetPassword(
          event.tinNumber, event.newPassword, event.rptPassword);
      if (response['status'] == "success" &&
          response['message'] == "Password Updated Successful") {
        emit(PasswordResetState(true));
      } else {
        emit(PasswordResetState(false));
      }
    } else {
      emit(PasswordResetState(false));
    }
  }
}
