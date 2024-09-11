import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../auth/backends/authenticator.dart';
import '../models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) async {
    try {
      // This is a reference to the user's information in the database
      final userInfo = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: userId)
          .limit(1)
          .get();

      // If the user's information is not found, then we create a new document
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          'displayname': displayName,
          'email': email ?? '',
        });

        return true;
      } else {
        final payLoad = UserInfoPayload(
          userId: userId,
          email: email,
          displayName: displayName,
        );
        await FirebaseFirestore.instance.collection('users').add(payLoad);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
