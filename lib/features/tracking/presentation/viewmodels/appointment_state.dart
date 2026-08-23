import '../../domain/entities/token.dart';

class AppointmentState {
  final List<Token> tokens;
  final bool isLoading;
  final String? errorMessage;
  final bool isFromCache;

  const AppointmentState({
    this.tokens = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isFromCache = false,
  });

  AppointmentState copyWith({
    List<Token>? tokens,
    bool? isLoading,
    String? errorMessage,
    bool? isFromCache,
  }) {
    return AppointmentState(
      tokens: tokens ?? this.tokens,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isFromCache: isFromCache ?? this.isFromCache,
    );
  }
}
