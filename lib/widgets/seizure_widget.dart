import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final List<Map<String, dynamic>> _myItems = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: _myItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: ListTile(
                    tileColor: const Color(0xFFF8E8EE),
                    title: Text("Seizure Name: ${_myItems[index]['name']}"),
                    subtitle: Text(
                      "Seizure Peroid: ${_myItems[index]['period']} minutes",
                    ),
                    trailing: Text(_myItems[index]['time']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add a new item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Seizure name',
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _periodController,
                      decoration: const InputDecoration(
                        labelText: 'Period of seizure in minutes',
                      ),
                    ),
                    FormBuilder(
                      child: Column(
                        children: [
                          FormBuilderDateTimePicker(
                            controller: _timeController,
                            name: 'time_field',
                            inputType: InputType.time,
                            format: DateFormat('hh:mm a'),
                            decoration: const InputDecoration(
                              labelText: 'Time',
                              // border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _myItems.add({
                          'name': _nameController.text,
                          'period': _periodController.text,
                          'time': _timeController.text
                        });
                        _nameController.clear();
                        _periodController.clear();
                        _timeController.clear();
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
