import 'package:crud_app/data/datasource.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateScreen extends StatefulWidget {
  final String name;
  final int id;
  final String degree;
  
  const UpdateScreen({
    super.key, 
    required this.name, 
    required this.id, 
    required this.degree
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-filling the controllers with the data passed from the StudentCard
    nameController.text = widget.name;
    idController.text = widget.id.toString();
    degreeController.text = widget.degree;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
        centerTitle: true,
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    // TODO: Implement the Update Form UI
    // 1. Create TextFields for Name, ID, and Degree using their respective controllers.
    // 2. Add an ElevatedButton to submit the update.
    // Hint: Construct a Map<String, dynamic> with the updated values and pass it 
    //       to Database().updateStudentDetails(studentDetails, idController.text).
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.clear),
                      onTap: () => nameController.clear(),
                    ),
                    labelText: 'Name',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.clear),
                      onTap: () => idController.clear(),
                    ),
                    labelText: 'Id',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: degreeController,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.clear),
                      onTap: () => degreeController.clear(),
                    ),
                    labelText: 'Degree',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text.trim();
                    final String idText = idController.text.trim();
                    final String degree = degreeController.text.trim();

                    if (name.isEmpty || idText.isEmpty || degree.isEmpty) {
                      Fluttertoast.showToast(msg: "Please fill in all fields");
                      return;
                    }

                    Map<String, dynamic> studentDetails = {
                      'name': name,
                      'id': int.tryParse(idText) ?? idText,
                      'degree': degree,
                    };

                    try {
                      await Database().updateStudentDetails(studentDetails, idText);
                      Fluttertoast.showToast(msg: "Student updated successfully!");
                      if (mounted) {
                        Navigator.pop(context, true);
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Error updating student: $e");
                    }
                  },
                  child: const Text("Update Student"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}