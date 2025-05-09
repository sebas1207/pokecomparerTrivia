import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/pokemon.dart';

class FavoritesService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> saveFavoriteComparison(Pokemon p1, Pokemon p2) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final favoriteData = {
      'pokemon1': p1.toMap(),
      'pokemon2': p2.toMap(),
      'fecha': FieldValue.serverTimestamp()
    };

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .add(favoriteData);
  }

  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .orderBy('fecha', descending: true)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
