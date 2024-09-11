import 'package:gd_store/src/auth/backends/authenticator.dart';
import 'package:gd_store/src/auth/riverpod/porviders/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = Provider<UserId?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.userId;
});