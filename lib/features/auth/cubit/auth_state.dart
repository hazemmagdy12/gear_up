abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String uid;
  AuthSuccess(this.uid);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// الحالات الجديدة الخاصة بجلب بيانات المستخدم
class GetUserLoading extends AuthState {}

class GetUserSuccess extends AuthState {}

class GetUserError extends AuthState {
  final String error;
  GetUserError(this.error);
}
class UpdateUserLoading extends AuthState {}

class UpdateUserSuccess extends AuthState {}

class UpdateUserError extends AuthState {
  final String error;
  UpdateUserError(this.error);
}