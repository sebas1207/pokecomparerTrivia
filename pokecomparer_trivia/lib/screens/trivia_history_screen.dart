import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TriviaHistoryScreen extends StatelessWidget {
  const TriviaHistoryScreen({super.key});

  Future<List<Map<String, dynamic>>> _fetchScores() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('scores')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final timestamp = data['timestamp'] as Timestamp?;
      return {
        'score': data['score'],
        'total': data['total'],
        'date': timestamp?.toDate(),
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Trivia')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final scores = snapshot.data ?? [];

          if (scores.isEmpty) {
            return const Center(child: Text('No hay puntuaciones registradas'));
          }

          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final entry = scores[index];
              final date = entry['date'] as DateTime?;
              final formattedDate = date != null
                  ? '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}'
                  : 'Fecha desconocida';

              return ListTile(
                leading: const Icon(Icons.quiz),
                title: Text('Puntaje: ${entry['score']} de ${entry['total']}'),
                subtitle: Text(formattedDate),
              );
            },
          );
        },
      ),
    );
  }
}
