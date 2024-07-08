abstract final class FormCheck {
  static String? emailCheck(String? value) {
    if (value == null || value.isEmpty) {
      return "이메일을 입력해 주세요";
    }

    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!regExp.hasMatch(value)) {
      return "이메일 형식이 맞지 않아요.";
    }

    return null;
  }

  static String? passwordCheck(String? value) {
    if (value == null || value.isEmpty) {
      return "비밀번호를 입력해 주세요.";
    }

    if (value.length < 8) {
      return "비밀번호는 8글자 보다 길어야합니다.";
    }

    return null;
  }
}
