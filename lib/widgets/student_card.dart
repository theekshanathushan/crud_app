import 'package:crud_app/screens/update.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final int id;
  final String degree;

  final VoidCallback? onUpdate;

  const StudentCard({
    super.key, 
    required this.name, 
    required this.id, 
    required this.degree,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the layout for the Student Card
    // 1. Return a Card widget containing the student's name, ID, and degree.
    // 2. Add an IconButton (e.g., an edit icon) that uses Navigator.push 
    //    to route the user to the UpdateScreen, passing along the student's data.
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(id.toString()),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Degree: $degree\nID: $id'),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () async {
            final updated = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateScreen(
                  name: name,
                  id: id,
                  degree: degree,
                ),
              ),
            );
            if (updated == true && onUpdate != null) {
              onUpdate!();
            }
          },
        ),
      ),
    );
  }
}