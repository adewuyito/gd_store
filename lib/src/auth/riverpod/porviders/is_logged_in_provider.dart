import 'package:gd_store/src/auth/models/auth_result.dart';
import 'package:gd_store/src/auth/riverpod/porviders/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider to check if the user is logged in
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});
