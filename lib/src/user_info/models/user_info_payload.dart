import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart' show immutable;
import 'package:gd_store/src/auth/backends/authenticator.dart';


@immutable
class UserInfoPayload extends MapView<String, String> {
  // This is a method that would be used to create a new instance of the [UserInfoPayload]
  // with the new values serialized into the map
  UserInfoPayload({
    required UserId userId,
    required String? email,
    required String? displayName,
  }) : super({
          'uid': userId,
          'email': email ?? '',
          'displayname': displayName ?? '',
        });
}
