class FormValidators {
  static String? validateEmail(String? value) {
    var emptyEmailError = 'Email address is empty';
    var invalidEmailError = 'Invalid email address';
    var lessLengthError = 'Please Enter At least 16 letters';

    if (value!.isEmpty) {
      return emptyEmailError;
    } else {
      final emailValidate = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);

      if (!emailValidate) {
        return invalidEmailError;
      }
      if (value.length < 16) {
        return lessLengthError;
      }
      else {
        return null;
      }
    }
  }

  static String? validateName(String? value) {
    var emptyNameError = 'Name is empty';
    var invalidNameError = 'Name is not appropriate!';

    if (value!.isEmpty) {
      return emptyNameError;
    } else {
      final nameValidate =
          RegExp(r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$")
              .hasMatch(value);
      if (!nameValidate) {
        return invalidNameError;
      } else {
        return null;
      }
    }
  }

  static String? validatePhone(String? value) {
    var emptyPhoneError = 'number is empty';
    var invalidPhoneError = 'Invalid number';
    var invalidformat = 'Number must start with 03,0092 or +92!';


    if (value!.isEmpty) {
      return emptyPhoneError;
    } else {
      String pattern = r'(^(?:[+0][1-9])?[0-9]{8,13}$)';
      RegExp phoneValidate = RegExp(pattern);

      if (!phoneValidate.hasMatch(value)) {
        return invalidPhoneError;
      }

      if (!value.startsWith('03') &&
          !value.startsWith('0092') &&
          !value.startsWith('+92')) {
        return invalidformat;
      } else {
        return null;
      }
    }
  }

  static String? validatePassword(String? value) {
    var emptyPasswordError = 'Password is empty';
    var lessLengthError = 'Please Enter At least 5 letters';

    if (value!.isEmpty) {
      return emptyPasswordError;
    }
    if (value.length < 5) {
      return lessLengthError;
    }
    return null;
  }

  static String? validateAccountNumber(String? value) {
    var emptyPasswordError = 'Field is empty';

    if (value!.isEmpty) {
      return emptyPasswordError;
    }
    return null;
  }

  static String? validateExpiryDate(String? value) {
    var emptyError = 'Please select expiry date';

    if (value!.isEmpty) {
      return emptyError;
    }
    return null;
  }


  static String? validateConfirmPassword(String? value, String existing) {
    var emptyPasswordError = 'Password is empty';
    var invalidPasswordError = 'Password does not match';

    if (value!.isEmpty) {
      return emptyPasswordError;
    } else {
      if (value != existing) {
        return invalidPasswordError;
      }
    }
    return null;
  }

  static String? validateDetails(String? value) {
    var emptyReasonError = 'Field is empty';
    var lessLengthError = 'Please Enter At least 5 letters';

    if (value!.isEmpty) {
      return emptyReasonError;
    }
    if (value.length < 5) {
      return lessLengthError;
    }
    return null;
  }
}
