class AppException implements Exception {
  String title;
  String errorMsg;
  AppException({required this.title, required this.errorMsg});
}

class FetchDataException extends AppException {
  String errorMsg;

  FetchDataException({required this.errorMsg})
      : super(title: "Network Error !!: ", errorMsg: errorMsg);
}

class BadRequestException extends AppException {
  String errorMsg;

  BadRequestException({required this.errorMsg})
      : super(title: "Invalid Request!!: ", errorMsg: errorMsg);
}

class UnauthourisedException extends AppException {
  String errorMsg;

  UnauthourisedException({required this.errorMsg})
      : super(title: "Unauthorised: ", errorMsg: errorMsg);
}

class InvalidInputException extends AppException {
  String errorMsg;

  InvalidInputException({required this.errorMsg})
      : super(title: "Invalid Input: ", errorMsg: errorMsg);
}
