class UserExceptionResponse {
  int? responseCode;
  String? message;

  UserExceptionResponse(responseCode, responseDetail, message);

  UserExceptionResponse.fromJson(Map<String, dynamic> json) {
    responseCode = int.parse(json['responseCode'] as String);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['message'] = this.message;
    return data;
  }
}
