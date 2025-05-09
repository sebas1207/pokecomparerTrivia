import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/trivia_question.dart';

class TriviaService {
  static Future<List<TriviaQuestion>> fetchFromFirestore() async {
    final snapshot = await FirebaseFirestore.instance.collection('questions').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return TriviaQuestion(
        question: data['question'] ?? '',
        options: List<String>.from(data['options'] ?? []),
        correctIndex: data['correctIndex'] ?? 0,
      );
    }).toList();
  }

  static Future<void> saveScore({required int score, required int total}) async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('scores')
      .add({
        'score': score,
        'total': total,
        'timestamp': FieldValue.serverTimestamp(),
      });

  }
}


/*import '../models/trivia_question.dart';

class TriviaService {
  static Future<List<TriviaQuestion>> fetchSampleQuestions() async {
    return [
      TriviaQuestion(
        question: '¿Cuál es el tipo principal de Pikachu?',
        options: ['Fuego', 'Agua', 'Eléctrico', 'Planta'],
        correctIndex: 2,
      ),
      TriviaQuestion(
        question: '¿Qué Pokémon es conocido como el legendario del tipo fuego?',
        options: ['Zapdos', 'Articuno', 'Moltres', 'Mewtwo'],
        correctIndex: 2,
      ),
      TriviaQuestion(
        question: '¿Cuál de estos NO es una evolución de Eevee?',
        options: ['Vaporeon', 'Umbreon', 'Togepi', 'Flareon'],
        correctIndex: 2,
      ),
      TriviaQuestion(
        question: '¿Qué Pokémon tiene el número #001 en la Pokédex nacional?',
        options: ['Bulbasaur', 'Charmander', 'Squirtle', 'Pikachu'],
        correctIndex: 0,
      ),
      TriviaQuestion(
        question: '¿Cuál es el tipo de Gengar?',
        options: ['Psíquico', 'Fantasma/Veneno', 'Siniestro', 'Hada'],
        correctIndex: 1,
      ),
      TriviaQuestion(
        question:
            '¿Qué movimiento es súper efectivo contra Pokémon tipo Dragón?',
        options: ['Hielo', 'Fuego', 'Eléctrico', 'Bicho'],
        correctIndex: 0,
      ),
      TriviaQuestion(
        question: '¿Qué objeto permite evolucionar a Eevee en Espeon?',
        options: [
          'Piedra Agua',
          'Piedra Día',
          'Alta amistad de día',
          'Piedra Solar'
        ],
        correctIndex: 2,
      ),
      TriviaQuestion(
        question: '¿Qué Pokémon puede megaevolucionar?',
        options: ['Lucario', 'Infernape', 'Greninja', 'Zeraora'],
        correctIndex: 0,
      ),
      TriviaQuestion(
        question: '¿Qué tipo tiene ventaja sobre el tipo Agua?',
        options: ['Planta', 'Eléctrico', 'Ambos', 'Ninguno'],
        correctIndex: 2,
      ),
      TriviaQuestion(
        question: '¿Qué Pokémon es la evolución final de Charmander?',
        options: ['Charmeleon', 'Charizard', 'Camerupt', 'Blaziken'],
        correctIndex: 1,
      ),
    ];
  }
}
*/