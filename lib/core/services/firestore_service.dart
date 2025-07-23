import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/order.dart' as myorder;

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) =>
      _db.collection('users').doc(user.uid).set(user.toMap());

  Future<UserModel?> fetchUser(String uid) async {
    final snap = await _db.collection('users').doc(uid).get();
    if (!snap.exists) return null;
    return UserModel.fromMap(snap.data()!);
  }

  Future<void> saveOrder(String uid, myorder.Order order) =>
      _db.collection('users').doc(uid).collection('orders').add(order.toMap());

  Stream<List<myorder.Order>> ordersStream(String uid) =>
      _db
          .collection('users')
          .doc(uid)
          .collection('orders')
          .orderBy('date', descending: true)
          .snapshots()
          .map((snap) => snap.docs.map((d) => myorder.Order.fromMap(d.data())).toList());
}