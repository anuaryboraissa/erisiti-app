import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../login/Login.dart';
import '../login/widgets/inputLabelsWidget.dart';
import 'bloc/register_bloc.dart';
import 'widgets/InputWidget.dart';
import 'widgets/PasswordFieldWidget.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _accountChoices = [
    "Tap to Choose Account",
    "User",
    "Business",
  ];
  String? _selectedAccount = "";
  _CreateAccountState() {
    _selectedAccount = _accountChoices[0];
  }

  // ignore: prefer_typing_uninitialized_variables
  var passwordValid;
  // ignore: prefer_typing_uninitialized_variables
  var accountValid;
  // ignore: prefer_typing_uninitialized_variables
  var passwordMatch;
  // ignore: prefer_typing_uninitialized_variables
  var tinValid;

  RegisterBloc registerBloc = RegisterBloc();
  TextEditingController realTinNumber = TextEditingController();
  TextEditingController realPassword = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(15.0),
          alignment: Alignment.bottomLeft,
          child: const Text("Create Account"),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'Popins',
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: ApplicationStyles.realAppColor,
        toolbarHeight: 70.0,
        elevation: 30.0,
        titleSpacing: 7.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: BlocBuilder<RegisterBloc, RegisterState>(
        bloc: registerBloc,
        builder: (context, state) {
          if (state is ValidateTinNumberState) {
            tinValid = state.valid;
          } else if (state is ValidateUserAccountState) {
            accountValid = state.valid;
          } else if (state is ValidatePasswordState) {
            passwordValid = state.valid;
          } else if (state is ValidatePasswordMatchState) {
            passwordMatch = state.valid;
          } else if (state is RegistrationState) {
            Fluttertoast.showToast(
                msg:
                    "code ${state.result['status']} status ${state.result['message']} }");
            realTinNumber.clear();
            realPassword.clear();
            passwordConfirm.clear();
            _selectedAccount = _accountChoices[0];
            passwordValid = null;
            passwordMatch = null;
            accountValid = null;
            tinValid = null;
          }
          return Container(
            padding: const EdgeInsets.all(21.0),
            child: ListView(
              children: [
                InputLabelsWidgets(label: "Tin Number"),
                InputWidget(
                  tinNumberEditing: realTinNumber,
                  loginBloc: LoginBloc(),
                  tinNumberValid: tinValid,
                  registerBloc: registerBloc,
                  tinNumberField: (tinNumber) {
                    // realTinNumber.text = tinNumber;
                  },
                  placeHolder: "000-000-000-000",
                  inputIcon: Icons.tag_outlined,
                  inputColor: ApplicationStyles.realAppColor,
                  borderRadius: 7.0,
                  passwordStyle: false,
                  login: false,
                ),
                InputLabelsWidgets(label: "Choose Account"),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: DropdownButtonFormField(
                    value: _selectedAccount,
                    items: _accountChoices
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      _selectedAccount = value as String;
                      registerBloc.add(ValidateAccountEvent(value));
                    },
                    dropdownColor: Colors.white,
                    icon: accountValid != null
                        ? accountValid
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: ApplicationStyles.realAppColor,
                              )
                            : const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.red,
                              )
                        : const Icon(
                            Icons.arrow_drop_down_circle,
                            color: ApplicationStyles.realAppColor,
                          ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: accountValid != null
                                ? !accountValid
                                    ? Colors.red
                                    : ApplicationStyles.realAppColor
                                : ApplicationStyles.realAppColor),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: accountValid != null
                                ? !accountValid
                                    ? Colors.red
                                    : ApplicationStyles.realAppColor
                                : ApplicationStyles.realAppColor),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ApplicationStyles.realAppColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                InputLabelsWidgets(label: "Password"),
                PasswordFieldWidget(
                  passwordEditing: realPassword,
                  confirmPassword: passwordConfirm.text,
                  passwordValid: passwordValid,
                  userPassword: (String password) {
                    // realPassword.text = password;
                  },
                  registerBloc: registerBloc,
                  primaryPassword: true,
                  login: false,
                ),
                InputLabelsWidgets(label: "Repeat Password"),
                PasswordFieldWidget(
                  passwordEditing: passwordConfirm,
                  login: false,
                  confirmPassword: passwordConfirm.text,
                  passwordMatch: passwordMatch,
                  currentPassword: realPassword.text,
                  userPassword: (password) {
                    // passwordConfirm.text = password;
                  },
                  registerBloc: registerBloc,
                  primaryPassword: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      minimumSize: const Size(200.0, 60.0),
                      backgroundColor: ApplicationStyles.realAppColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: (passwordValid != null &&
                                passwordValid != null &&
                                passwordMatch != null &&
                                accountValid != null &&
                                tinValid != null) &&
                            (passwordValid &&
                                passwordValid &&
                                passwordMatch &&
                                accountValid &&
                                tinValid)
                        ? () {
                            registerBloc.add(RegistrationEvent(
                                realTinNumber.text,
                                _selectedAccount!,
                                realPassword.text,
                                passwordConfirm.text));
                          }
                        : null,
                    child: Text(
                      "Sign up".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Popins',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have account ? ",
                        style: TextStyle(
                          fontFamily: 'Popins',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const Login();
                            }));
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              color: ApplicationStyles.realAppColor,
                              fontFamily: 'Popins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
