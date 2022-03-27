class CustomException implements Exception {
  final message;
  final prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return '$prefix  $message';
  }
}

class ForbiddenRequestException extends CustomException {
  ForbiddenRequestException([message]) : super(message, 'Forbidden Request');
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, 'Invalid Request');
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, 'Unauthorised');
}

class CommunicationException extends CustomException {
  CommunicationException([String? message])
      : super(message, 'Communication Error');
}
