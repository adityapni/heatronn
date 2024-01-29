class Error {
  Error({
    required this.method,
    required this.code,
    required this.message,
  });
  late final String? method;
  late final int code;
  late final String message;

  Error.fromJson(Map<String, dynamic> json){
    method = json['method'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['method'] = method;
    _data['code'] = code;
    _data['message'] = message;
    return _data;
  }
}