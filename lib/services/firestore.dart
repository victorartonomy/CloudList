import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {

  //Get Collection of data
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  //Create
  Future<void> addNote (String note, bool check) {
    return notes.add(
      {
        'note': note,
        'isComplete': check,
        'timestamp': Timestamp.now()
      }
    );
  }

  //Read
  Stream<QuerySnapshot<Object?>>? getNotesStream() {
    final notesStream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream.cast<QuerySnapshot>();
  }

  //Update

  //Delete

}