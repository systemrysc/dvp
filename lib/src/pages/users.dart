import 'package:dvp_app/src/data/appstate.dart';
import 'package:dvp_app/src/models/directions.dart';
import 'package:dvp_app/src/models/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//{}
//[]

class UsersPage extends StatefulWidget {
  const UsersPage({super.key, this.users});
  final Users? users;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _formKey = GlobalKey<FormState>();
  late int _id;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();
  List<String> directions = [];

  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
      _dateController.text =
          (selectedDate != null)
              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
              : '';
    });
  }

  @override
  void initState() {
    super.initState();
    _id = DateTime.now().microsecondsSinceEpoch;

    if (widget.users==null) return;

    _nameController.text = widget.users!.name;
    _lastnameController.text = widget.users!.lastname;
    _dateController.text = widget.users!.date;
    _id = widget.users!.id; 
    directions = Provider.of<AppState>(context,listen: false).getDirectionById(_id);      
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Usuario"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    spacing: 8,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Nombre"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresar el nombre del usuario';
                          }
                        },
                      ),
                      TextFormField(
                        controller: _lastnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Apellido"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresar el apellido del usuario';
                          }
                        },
                      ),
                      TextFormField(
                        controller: _dateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Fecha Nacimiento"),
                          suffix: IconButton.outlined(
                            onPressed: () {
                              _selectDate();
                            },
                            icon: Icon(Icons.calendar_month),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresar la fecha de nacimiento del usuario';
                          }
                        },
                      ),

                      TextFormField(
                        controller: _directionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Dirección"),
                          suffix: IconButton(
                            onPressed: () {
                              if (_directionController.text.isNotEmpty &&
                                  !directions.contains(
                                    _directionController.text,
                                  )) {
                                setState(() {
                                  directions.add(_directionController.text);
                                  _directionController.text = "";
                                });
                              }
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                        validator: (value) {
                          if (directions.isEmpty) {
                            return 'Por favor, ingresar dirección del usuario';
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: directions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.place),
                  title: Text(directions[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Por favor, ingresar los datos")),
            );
            return;
          }

          final user = Users(
            id: _id,
            name: _nameController.text.trim(),
            lastname: _lastnameController.text.trim(),
            date: _dateController.text.trim(),
            direction: _directionController.text.trim(),
          );
          Provider.of<AppState>(context, listen: false).userUpdate(user);
          for (final item in directions) {
            Provider.of<AppState>(
              context,
              listen: false,
            ).directionsUpdate(Directions(id: _id, direction: item));
          }

          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastnameController.dispose();
    _dateController.dispose();
    _directionController.dispose();
    super.dispose();
  }
}
