import 'package:honak/shared/api/api_error.dart';
import 'package:honak/shared/api/pagination.dart';

class ApiResponse<T> {
  final T? data;
  final ApiError? error;
  final PaginationMeta? meta;

  const ApiResponse({this.data, this.error, this.meta});

  bool get isSuccess => error == null;
  bool get isError => error != null;
  bool get hasData => data != null;

  factory ApiResponse.success(T data, {PaginationMeta? meta}) {
    return ApiResponse(data: data, meta: meta);
  }

  factory ApiResponse.failure(ApiError error) {
    return ApiResponse(error: error);
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJson,
  ) {
    final errorJson = json['error'];
    if (errorJson != null) {
      return ApiResponse(
        error: ApiError.fromJson(errorJson as Map<String, dynamic>),
      );
    }

    final metaJson = json['meta'];
    return ApiResponse(
      data: fromJson != null && json['data'] != null
          ? fromJson(json['data'])
          : json['data'] as T?,
      meta: metaJson != null
          ? PaginationMeta.fromJson(metaJson as Map<String, dynamic>)
          : null,
    );
  }

  R when<R>({
    required R Function(T data, PaginationMeta? meta) success,
    required R Function(ApiError error) failure,
  }) {
    if (isSuccess && hasData) {
      return success(data as T, meta);
    }
    return failure(error!);
  }
}
