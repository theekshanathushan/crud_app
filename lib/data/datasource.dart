import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/models/student.dart';
import 'package:flutter/foundation.dart';

class Database {
  // TODO 1: Implement the CREATE operation
  Future<void> addStudent(Map<String, dynamic> studentInfo, String id) async {
    try {
      // 1. Access FirebaseFirestore.instance
      // 2. Go to the "Students" collection
      // 3. Target the specific document using the provided 'id'
      // 4. Use .set() to save the 'studentInfo' map
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(id)
          .set(studentInfo);
    } catch (e) {
      debugPrint('Error adding student: $e');
      rethrow;
    }
  }

  // TODO 2: Implement the READ operation
  Future<List<Student>> getStudentDetails() async {
    List<Student> studentDetailsList = [];
    try {
      // 1. Fetch the QuerySnapshot from the "Students" collection using .get()
      // 2. Loop through the querySnapshot.docs
      // 3. Extract 'name', 'id', and 'degree' to instantiate Student objects
      // 4. Add each Student to 'studentDetailsList'
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Students').get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        int studentId = 0;
        if (data['id'] is int) {
          studentId = data['id'];
        } else if (data['id'] != null) {
          studentId = int.tryParse(data['id'].toString()) ?? 0;
        } else {
          studentId = int.tryParse(doc.id) ?? 0;
        }

        studentDetailsList.add(
          Student(
            name: data['name']?.toString() ?? '',
            id: studentId,
            degree: data['degree']?.toString() ?? '',
          ),
        );
      }

      return studentDetailsList;
    } catch (e) {
      debugPrint('Error fetching students: $e');
      return [];
    }
  }

  // TODO 3: Implement the UPDATE operation
  Future<void> updateStudentDetails(Map<String, dynamic> studentInfo, String id) async {
    try {
      // 1. Target the specific document in the "Students" collection by 'id'
      // 2. Use .update() to apply the 'studentInfo' map changes
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(id)
          .update(studentInfo);
    } catch (e) {
      debugPrint('Error updating student: $e');
      rethrow;
    }
  }

  // TODO 4: Implement the DELETE operation
  Future<void> deleteStudent(String id) async {
    try {
      // 1. Target the specific document in the "Students" collection by 'id'
      // 2. Use .delete() to remove it from Firestore
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(id)
          .delete();
    } catch (e) {
      debugPrint('Error deleting student: $e');
      rethrow;
    }
  }
}