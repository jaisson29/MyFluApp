import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];

  QuerySnapshot queryPeopleSnapshot = await db.collection('people').get();

  for (var doc in queryPeopleSnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {"id": doc.id, "name": data['name'], "age": data['age']};
    people.add(person);
  }
  return people;
}

//Guardar una persona en la db
Future<void> addPeople(String name, int age) async {
  await db.collection('people').add({"name": name, "age": age});
}

Future<void> updatePeople(String id, String newName, int newAge) async {
  await db.collection('people').doc(id).set({"name": newName, "age": newAge});
}

Future<void> deletePeople(String id) async {
  await db.collection('people').doc(id).delete();
}
