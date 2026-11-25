import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> saveUser(UserModel user) =>
      _users.doc(user.uid).set(user.toMap(), SetOptions(merge: true));

  Stream<UserModel?> watchUser(String uid) {
    return _users.doc(uid).snapshots().map((doc) {
      final data = doc.data();
      return data == null ? null : UserModel.fromMap(doc.id, data);
    });
  }
}
