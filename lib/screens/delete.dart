import 'package:crud_app/data/datasource.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete'),
        centerTitle: true,
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    // TODO: Implement the UI for the Delete Screen
    // 1. Return a SafeArea with Padding.
    // 2. Add a TextField hooked up to the `idController`.
    // 3. Add an ElevatedButton to trigger the deletion.
    // Hint: Call Database().deleteStudent(idController.text) inside onPressed
    //       and use Fluttertoast to show a success message.
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () => idController.clear(),
                  ),
                  labelText: 'Student ID to Delete',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final String id = idController.text.trim();
                  if (id.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter a student ID");
                    return;
                  }

                  try {
                    await Database().deleteStudent(id);
                    idController.clear();
                    Fluttertoast.showToast(msg: "Student deleted successfully!");
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Error deleting student: $e");
                  }
                },
                child: const Text("Delete Student"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}