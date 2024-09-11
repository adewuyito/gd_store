import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_store/src/auth/backends/authenticator.dart';
import 'package:gd_store/src/user_info/models/user_info_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Contiually gives us info so it does not need a notifier
final userInfoModelProvider = StreamProvider.autoDispose
    .family<UserInfoModel, UserId>((ref, UserId userId) {
  // First create a controller for the provider and return a stream as a result of the calculations
  // from the stream and dispose on dispose of the ref

  final controller = StreamController<UserInfoModel>();

  final sub = FirebaseFirestore.instance
      .collection('users')
      .where('uid')
      .limit(1)
      .snapshots()
      .listen(
    (snapShot) {
      final doc = snapShot.docs.first;
      final json = doc.data();
      final userInfoModel = UserInfoModel.fromJson(json, userId: userId);

      // Addig the data to the controller
      controller.add(userInfoModel);
    },
  );

  // Controller dispose
  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
