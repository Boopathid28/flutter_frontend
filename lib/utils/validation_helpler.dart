
import 'package:email_validator/email_validator.dart';

class ValidationHelper {
  static String username(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (value.contains(" ")) {
      return "Don't use spaces inbetween";
    } else {
      return "";
    }
  }

  static String password(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (value.contains(" ")) {
      return "Don't use spaces inbetween";
    } else if (value.length < 5) {
      return "The value less than 5";
    } else {
      return "";
    }
  }

  static String confirmPassword(String value1, String value2) {
    if (value1.isEmpty) {
      return "This field is required";
    } else if (value1.contains(" ")) {
      return "Don't use spaces inbetween";
    } else if (value1.length < 5) {
      return "The value less than 5";
    } else if (value1 != value2) {
      return "Pasword must be same";
    } else {
      return "";
    }
  }

  static String defaultTextField(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else {
      return "";
    }
  }


static String defaultDoubleField(String value) {
  if (value.isEmpty) {
    return "This field is required";
  } else {
    final double? strictValue = double.tryParse(value);
  if (strictValue == null) {
    return "this field is require a decimal value";
  }
    return "";
  }
}

  static String email(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (!(EmailValidator.validate(value))) {
      return "The email is not valid";
    }else {
      return "";
    }
  }

  static String phone(String value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)) {
      return "The mobile no is not valid";
    } else if (value.length < 10) {
      return "The value less than 10";
    } else {
      return "";
    }
  }

  
}