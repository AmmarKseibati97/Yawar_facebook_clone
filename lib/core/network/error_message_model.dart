import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final int status;
  final int errorCode;
  final String message;

  const ErrorMessageModel(
      {required this.status, required this.errorCode, required this.message});

  factory ErrorMessageModel.formJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      status: json["status"],
      errorCode: json["errorCode"],
      message: json["message"],
    );
  }

  @override
  List<Object?> get props => [status, errorCode, message];
}
