import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:zstore_flutter/features/authentication/data/modals/registration_request_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/on_error_message_model.dart';
import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_action.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/globals/show_app_bar.dart';
import '../../../../core/utils/services/secure_storage_servic.dart';
import '../../../../core/utils/validators/form_validator.dart';
import '../../../home/presentation/home_view_model/cart_provider.dart';
import '../../data/modals/forget_password_,request_model.dart';
import '../../data/modals/forget_password_response_model.dart';
import '../../data/modals/login_request_model.dart';
import '../../data/modals/login_response_modal.dart';
import '../../data/modals/logout_response_model.dart';
import '../../data/modals/registration_response_model.dart';
import '../../data/modals/update_password_request_model.dart';
import '../../data/modals/update_password_response_model.dart';
import '../../data/modals/validate_otp_request_model.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(
    this.loginUsecase,
    this.validateOtpUsecase,
    this.logoutUsecase,
    this.generateOtpUsecase,
    this.registerationUsecase,
    this.updatePasswordUsecase,
  );

  //valueNotifier
  ValueNotifier<bool> obsecurePasswordTextNotifier = ValueNotifier(true);
  ValueNotifier<bool> obsecureConfirmPasswordTextNotifier = ValueNotifier(true);
  ValueChanged<OnErrorMessageModel>? onErrorMessage;

  LoginUsecase loginUsecase;
  RegisterationUsecase registerationUsecase;
  // GenerateOtpUsecase forgetPasswordUsecase;
  UpdatePasswordUsecase updatePasswordUsecase;
  UpdatePasswordResponseModel? updatePasswordResponseModel;
  ForgetPasswordResponseModel? forgetPasswordResponseModel;
  LogoutUsecase logoutUsecase;
  LoginResponseModel? userDetails;
  LogoutResponseModel? logoutResponseModel;
  bool isPasswordButtonPressed = false;
  bool isConfirmPasswordButtonPressed = false;
  final _secureStorage = SecureStorageService();

  bool isLoginPasswordError = false;
  bool isForgetPasswordError = false;
  bool isConfirmPasswordError = false;
  CartProvider cartProvider = sl();

  //login content

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  ValueNotifier<bool> isLoginLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> obsecureLoginTextNotifier = ValueNotifier(true);
  ValueNotifier<bool> obsecureRegistrationPasswordTextNotifier =
      ValueNotifier(true);
  ValueNotifier<bool> obsecureRegistrationConfirmPasswordTextNotifier =
      ValueNotifier(true);

  final FocusNode loginEmailFocusNode = FocusNode();
  final FocusNode loginPasswordFocusNode = FocusNode();
  //controllers

  final TextEditingController loginEmailController =
      TextEditingController(text: 'aftabawan@gmail.com');
  // final TextEditingController loginEmailController =
  //     TextEditingController();
  final TextEditingController loginPasswordController =
      TextEditingController(text: 'Login@786');
  // final TextEditingController loginPasswordController =
  //     TextEditingController();
  bool isLoginButtonPressed = false;
  bool isLoginEmailError = false;

  //login function
  Future<void> login() async {
    isLoginLoadingNotifier.value = true;

    var params = LoginRequestModel(
        password: loginPasswordController.text.trim(),
        email: loginEmailController.text.trim());
    var loginEither = await loginUsecase(params);

    if (loginEither.isLeft()) {
      handleError(loginEither);

      isLoginLoadingNotifier.value = false;
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, login) {
        loginEither.foldRight(null, (response, _) async {
          userDetails = response;
          print('this is the user id ${userDetails!.data.userId}');
          setLoggedInUser(userDetails);

          SecureStorageService secureStore = sl();
          await secureStore.write(key: 'user', value: jsonEncode(userDetails));
          notifyListeners();
          moveToDashboardPage();
          isLoginLoadingNotifier.value = false;
        });
        isLoginLoadingNotifier.value = false;
      });
      isLoginLoadingNotifier.value = false;
    }
  }

  /// This method is to check if user is logged in or not, will return null if no user found
  Future<LoginResponseModel?> checkIfUserLoggedIn() async {
    final result = await _secureStorage.read(key: 'user');
    if (result == null) {
      return null;
    } else {
      final map = jsonDecode(result);
      return LoginResponseModel.fromJson(map);
    }
  }

  void setLoggedInUser(LoginResponseModel? value) {
    userDetails = value;
    notifyListeners();
  }

  Future<void> logoutUser(BuildContext context) async {
    _secureStorage.delete(key: 'user');

    cartProvider.emptyCounter();

    setLoggedInUser(null);
  }

  setCurrent(LoginResponseModel value) {
    userDetails = value;
    SecureStorageService secureStore = sl();
    secureStore.write(key: 'user', value: jsonEncode(userDetails));
    notifyListeners();
  }

  void onEmailChange(String value) {
    isLoginButtonPressed = false;
    if (isLoginEmailError) {
      loginFormKey.currentState!.validate();
    }
  }

  void onPasswordChange(String value) {
    isLoginButtonPressed = false;
    if (isLoginPasswordError) {
      loginFormKey.currentState!.validate();
    }
  }

  void onLoginEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(loginPasswordFocusNode);
  }

  void onLoginPasswordSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //login page moves
  void moveToDashboardPage() {
    appState.currentAction = PageAction(
        state: PageState.replaceAll, page: PageConfigs.dashboardPageConfig);
  }

  //register content

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  ValueNotifier<bool> isRegisterLoadingNotifier = ValueNotifier(false);
  ValueNotifier<bool> obsecureRegistrationEmailTextNotifier =
      ValueNotifier(true);
  ValueNotifier<bool> obsecureRegistrationConfirmTextNotifier =
      ValueNotifier(true);
  //focusNodes of register
  final FocusNode registerFirstNameFocusNode = FocusNode();
  final FocusNode registerLastNameFocusNode = FocusNode();
  final FocusNode registerEmailFocusNode = FocusNode();
  final FocusNode registerAddressFocusNode = FocusNode();
  final FocusNode registerPasswordFocusNode = FocusNode();
  final FocusNode registerConfirmPasswordFocusNode = FocusNode();
  final FocusNode registerMobileNumFocusNode = FocusNode();
  RegistrationResponseModel? registrationResponseModel;

  //controllers of register screen
  final TextEditingController registerFirstNameController =
      TextEditingController();
  final TextEditingController registerLastNameController =
      TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerAddressController =
      TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();
  final TextEditingController registerMobileNumberController =
      TextEditingController();

  RadioGroupController genderRadioController = RadioGroupController();
  final List<String> genderValues = [
    'Male',
    'Female',
  ];

  //registration function
  Future<void> registerUser() async {
    isRegisterLoadingNotifier.value = true;

    var params = RegistrationRequestModel(
      firstName: registerFirstNameController.text,
      lastName: registerLastNameController.text,
      email: registerEmailController.text,
      contact: registerMobileNumberController.text,
      reEnterPassword: registerConfirmPasswordController.text,
      password: registerPasswordController.text,
      address: registerAddressController.text,
      gender: genderRadioController.value == 1 ? 'female' : 'male',
    );
    var registerEither = await registerationUsecase(params);

    if (registerEither.isLeft()) {
      handleError(registerEither);
      isRegisterLoadingNotifier.value = false;
    } else if (registerEither.isRight()) {
      registerEither.foldRight(null, (response, register) {
        registerEither.foldRight(null, (response, _) {
          registrationResponseModel = response;
          notifyListeners();
          moveToLogin();
          clearRegistrationFields();
          isRegisterLoadingNotifier.value = false;
          // ShowSnackBar.show(userDetails..toString());
          // removeToDashboard();
          // clearFields();
        });
        isRegisterLoadingNotifier.value = false;
      });
      isRegisterLoadingNotifier.value = false;
    }
  }

  clearRegistrationFields() {
    registerFirstNameController.clear();
    registerLastNameController.clear();
    registerEmailController.clear();
    registerMobileNumberController.clear();
    registerConfirmPasswordController.clear();
    registerPasswordController.clear();
    registerAddressController.clear();
  }

  // onchange and submitted
  bool isRegisterButtonPressed = false;
  bool isRegisterFirstNameError = false;
  bool isRegisterLastNameError = false;
  bool isRegisterEmailError = false;
  bool isRegisterAddressError = false;
  bool isRegisterPasswordError = false;
  bool isRegisterConfirmPasswordError = false;
  bool isRegisterMobileNumError = false;

  void onRegisterFirstNameChange(String value) {
    isRegisterButtonPressed = false;
    if (isRegisterFirstNameError) {
      registerFormKey.currentState!.validate();
    }
  }

  void onRegisterLastNameChange(String value) {
    isRegisterButtonPressed = false;
    if (isRegisterLastNameError) {
      registerFormKey.currentState!.validate();
    }
  }

  void onRegisterEmailChange(String value) {
    isRegisterButtonPressed = false;
    if (isRegisterEmailError) {
      registerFormKey.currentState!.validate();
    }
  }

  void onRegisterAddressChange(String value) {
    isRegisterButtonPressed = false;
    if (isRegisterAddressError) {
      registerFormKey.currentState!.validate();
    }
  }

  void onRegisterPasswordChange(String value) {
    isRegisterButtonPressed = false;
    if (isRegisterPasswordError) {
      registerFormKey.currentState!.validate();
    }
  }

  void onRegisterConfirmPasswordChange(String value) {
    isRegisterButtonPressed = false;
    if (isRegisterConfirmPasswordError) {
      registerFormKey.currentState!.validate();
    }
  }

  void onRegisterMobileNumChange(String value) {
    isRegisterButtonPressed = false;
    if (isRegisterMobileNumError) {
      registerFormKey.currentState!.validate();
    }
  }

  void onRegisterFirstNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(registerLastNameFocusNode);
  }

  void onRegisterLastNameSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(registerEmailFocusNode);
  }

  void onRegisterEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(registerAddressFocusNode);
  }

  void onRegisterAddressSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(registerPasswordFocusNode);
  }

  void onRegisterPasswordSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(registerConfirmPasswordFocusNode);
  }

  void onRegisterConfirmPasswordSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(registerMobileNumFocusNode);
  }

  void onRegisterMobileSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //forgot password
  bool isForgotEmailButtonPressed = false;
  bool isForgetEmailError = false;
  final GlobalKey<FormState> forgetEmailFormKey = GlobalKey<FormState>();
  ValueNotifier<bool> confirmPasswordLoadingTextNotifier = ValueNotifier(false);
  ValueNotifier<bool> isEmailLoadingNotifier = ValueNotifier(false);
  final FocusNode forgetEmailFocusNode = FocusNode();
  final FocusNode forgotPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final GlobalKey<FormState> forgetConfirmPasswordFormKey =
      GlobalKey<FormState>();
  final TextEditingController forgetPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void onForgotEmailSubmitted(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onForgotEmailChange(String value) {
    isForgotEmailButtonPressed = false;
    if (isForgetEmailError) {
      forgetEmailFormKey.currentState!.validate();
    }
  }

  //otp content
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  ValueNotifier<bool> otpLoadingNotifier = ValueNotifier(false);
  final TextEditingController forgetEmailController = TextEditingController();

  //logout content
  ValueNotifier<bool> isLogoutLoadingNotifier = ValueNotifier(false);

  //usecases call

  Future<void> forgotPasswordEmail() async {
    isEmailLoadingNotifier.value = true;

    var params = GenerateOtpRequestModel(email: forgetEmailController.text);
    var forgotEmailEither = await generateOtpUsecase(params);

    if (forgotEmailEither.isLeft()) {
      handleError(forgotEmailEither);
      isEmailLoadingNotifier.value = false;
    } else if (forgotEmailEither.isRight()) {
      forgotEmailEither.foldRight(null, (response, login) {
        forgotEmailEither.foldRight(null, (response, _) {
          forgetPasswordResponseModel = response;
          notifyListeners();
          isEmailLoadingNotifier.value = false;
          moveToOtpScreen();
          // moveToOtp();
          // ShowSnackBar.show(userDetails..toString());
          // clearFields();
        });
        isEmailLoadingNotifier.value = false;
      });
      isEmailLoadingNotifier.value = false;
    }
  }

  Future<void> updatePassword() async {
    confirmPasswordLoadingTextNotifier.value = true;

    var params = UpdatePasswordRequestModel(
        email: forgetEmailController.text,
        password: confirmPasswordController.text,
        reEnterPassword: confirmPasswordController.text);
    var forgotEmailEither = await updatePasswordUsecase(params);

    if (forgotEmailEither.isLeft()) {
      handleError(forgotEmailEither);
      confirmPasswordLoadingTextNotifier.value = false;
    } else if (forgotEmailEither.isRight()) {
      forgotEmailEither.foldRight(null, (response, login) {
        forgotEmailEither.foldRight(null, (response, _) {
          updatePasswordResponseModel = response;
          notifyListeners();
          confirmPasswordLoadingTextNotifier.value = false;

          moveToLogin();
          // ShowSnackBar.show(userDetails..toString());
          // clearFields();
        });
        confirmPasswordLoadingTextNotifier.value = false;
      });
      confirmPasswordLoadingTextNotifier.value = false;
    }
  }

  TextEditingController otpController = TextEditingController();

  // Future<void> logout() async {
  //   isLogoutLoadingNotifier.value = true;
  //
  //   var params ='';
  //       // LogoutRequestModel(authorization: userDetails!.token.toString());
  //   var loginEither = await logoutUsecase(params"");
  //
  //   if (loginEither.isLeft()) {
  //     handleError(loginEither);
  //     isLogoutLoadingNotifier.value = false;
  //   } else if (loginEither.isRight()) {
  //     loginEither.foldRight(null, (response, login) {
  //       loginEither.foldRight(null, (response, _) {
  //         logoutResponseModel = response;
  //         notifyListeners();
  //         isLogoutLoadingNotifier.value = false;
  //         onErrorMessage?.call(OnErrorMessageModel(
  //             message: 'Successful', backgroundColor: Colors.green));
  //         // removeToDashboard();
  //         // clearFields();
  //       });
  //       isLogoutLoadingNotifier.value = false;
  //     });
  //     isLogoutLoadingNotifier.value = false;
  //   }
  // }

  // Methods

  String? validateConfirmPassword(String? value) {
    if (!isConfirmPasswordButtonPressed) {
      return null;
    }
    isConfirmPasswordError = true;
    var result = FormValidators.validateConfirmPassword(
        value, forgetPasswordController.text);
    if (result == null) {
      isConfirmPasswordError = false;
    }
    return result;
  }

  void onObsecureChangeLogin() {
    obsecureLoginTextNotifier.value = !obsecureLoginTextNotifier.value;
  }

  void onObsecureRegistrationPassword() {
    obsecureRegistrationPasswordTextNotifier.value =
        !obsecureRegistrationPasswordTextNotifier.value;
  }

  void onObsecureRegistrationConfirmPassword() {
    obsecureRegistrationConfirmPasswordTextNotifier.value =
        !obsecureRegistrationConfirmPasswordTextNotifier.value;
  }

  void onObsecurePasswordChange() {
    obsecurePasswordTextNotifier.value = !obsecurePasswordTextNotifier.value;
  }

  void onObsecureConfirmPasswordChange() {
    obsecureConfirmPasswordTextNotifier.value =
        !obsecureConfirmPasswordTextNotifier.value;
  }

  void onForgetPasswordChange(String value) {
    isPasswordButtonPressed = false;
    if (isForgetPasswordError) {
      forgetConfirmPasswordFormKey.currentState!.validate();
    }
  }

  void onConfirmPasswordChange(String value) {
    isConfirmPasswordButtonPressed = false;
    if (isConfirmPasswordError) {
      forgetConfirmPasswordFormKey.currentState!.validate();
    }
  }

  AppState appState = GetIt.I.get<AppState>();

  void moveToForgetPasswordEmail() {
    appState.currentAction = PageAction(
        state: PageState.addPage,
        page: PageConfigs.forgetPasswordEmailPageConfig);
  }

  void moveToConfirmForgetPassword() {
    appState.currentAction = PageAction(
        state: PageState.addPage,
        page: PageConfigs.forgetConfirmPasswordPageConfig);
  }

  void moveToOtpScreen() {
    appState.currentAction =
        PageAction(state: PageState.addPage, page: PageConfigs.otpPageConfig);
  }

  void moveToRegisterScreen() {
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.registrationPageConfig);
  }

  void moveToLogin() {
    appState.currentAction = PageAction(
        state: PageState.replaceAll, page: PageConfigs.loginPageConfig);
  }


  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoginLoadingNotifier.value = false;
    either.fold(
        (l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)),
        (r) => null);
  }

  // Usecases
  ValidateOtpUsecase validateOtpUsecase;
  GenerateOtpUsecase generateOtpUsecase;

  // Value Notifiers
  ValueNotifier<bool> isResendOtpNotifier = ValueNotifier(false);

  // Properties
  final StreamController<ErrorAnimationType> errorStream =
      StreamController<ErrorAnimationType>.broadcast();

  // Usecase Calls
  Future<void> validateOtp(String otp) async {
    isResendOtpNotifier.value = true;

    var email = forgetEmailController.text;

    if (email.isEmpty) {
      return;
    }

    var params = ValidateOtpRequestModel(otpCode: otp, email: email);

    var validateOtpEither = await validateOtpUsecase.call(params);

    if (validateOtpEither.isLeft()) {
      handleError(validateOtpEither);
      isResendOtpNotifier.value = false;
    } else if (validateOtpEither.isRight()) {
      validateOtpEither.foldRight(null, (response, _) {
        ShowSnackBar.show('OTP Verified');
        otpController.clear();
        appState.currentAction = PageAction(
            state: PageState.replace,
            page: PageConfigs.forgetConfirmPasswordPageConfig);
      });
      isResendOtpNotifier.value = false;
    }
  }

  Future<void> generateOtp() async {
    isResendOtpNotifier.value = true;

    var email = forgetEmailController.text;

    if (email.isEmpty) {
      return;
    }

    var params = GenerateOtpRequestModel(email: email);

    var generateOtpEither = await generateOtpUsecase.call(params);

    if (generateOtpEither.isLeft()) {
      handleError(generateOtpEither);
      isResendOtpNotifier.value = false;
    } else if (generateOtpEither.isRight()) {
      ShowSnackBar.show('OTP sent!');
      isResendOtpNotifier.value = false;
    }
  }

  // Methods
  void onCompleted(String value) {
    isResendOtpNotifier.value = false;
    print(value);
    appState.currentAction = PageAction(
        state: PageState.replace,
        page: PageConfigs.forgetConfirmPasswordPageConfig);
    validateOtp(value);
  }

  void onChanged(String value) {
    if (value.length == 4) {
      Logger().v(value);
      validateOtp(value);
    }
  }

  bool beforeTextPaste(String? value) {
    return true;
  }

}
