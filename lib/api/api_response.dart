class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? errorMessage;
  final int? statusCode;

  ApiResponse.success(this.data, this.statusCode)
      : success = true,
        errorMessage = null;

  ApiResponse.failure(this.errorMessage, this.statusCode)
      : success = false,
        data = null;
}