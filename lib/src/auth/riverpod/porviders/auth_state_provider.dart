import 'package:gd_store/src/auth/models/auth_state.dart';
import 'package:gd_store/src/auth/riverpod/notifiers/auth_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
