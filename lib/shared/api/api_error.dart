class ApiError {
  final String code;
  final String message;
  final List<FieldError>? details;
  final int? retryAfter;

  const ApiError({
    required this.code,
    required this.message,
    this.details,
    this.retryAfter,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'] as String? ?? 'unknown',
      message: json['message'] as String? ?? 'An unknown error occurred',
      details: json['details'] != null
          ? (json['details'] as List<dynamic>)
              .map((e) => FieldError.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      retryAfter: json['retry_after'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        if (details != null)
          'details': details!.map((e) => e.toJson()).toList(),
        if (retryAfter != null) 'retry_after': retryAfter,
      };

  @override
  String toString() => 'ApiError(code: $code, message: $message)';
}

class FieldError {
  final String field;
  final String message;
  final String? code;

  const FieldError({
    required this.field,
    required this.message,
    this.code,
  });

  factory FieldError.fromJson(Map<String, dynamic> json) {
    return FieldError(
      field: json['field'] as String,
      message: json['message'] as String,
      code: json['code'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'field': field,
        'message': message,
        if (code != null) 'code': code,
      };

  @override
  String toString() => 'FieldError(field: $field, message: $message)';
}
