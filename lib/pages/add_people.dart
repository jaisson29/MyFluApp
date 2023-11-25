import 'package:adsoapp/services/people_service.dart';
import 'package:flutter/material.dart';

class AddPeople extends StatefulWidget {
  const AddPeople({super.key});

  @override
  State<AddPeople> createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController ageController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = args['name'];
    ageController.text = args['age'].toString();
    return Scaffold(
      appBar: AppBar(title: const Text("Add people")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (args['id'] != '')
              Container(
                height: 50.0,
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.red[400],
                  splashColor: Colors.red[300],
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar eliminación'),
                            content:
                                const Text("¿Deseas eliminar este registro?"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Cancelar")),
                              TextButton(
                                child: const Text('Eliminar'),
                                onPressed: () async {
                                  deletePeople(args['id']).then((_) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }).catchError((onError) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: const Icon(Icons.delete_forever_outlined),
                ),
              ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  hintText: 'ingrese el nombre', labelText: "Nombre"),
              onSubmitted: (String valor) async {},
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              maxLength: 3,
              decoration: const InputDecoration(
                labelText: 'Edad',
              ),
              onSubmitted: (String valor) async {},
            ),
            const SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              minWidth: 200.0,
              height: 40.0,
              onPressed: () async {
                if (args['id'] != '') {
                  updatePeople(args["id"], nameController.text,
                          int.parse(ageController.text))
                      .then((_) => Navigator.pop(context))
                      .catchError((onError) => _verToast(context,
                          message: "Error $onError", button: "Ok"))
                      .whenComplete(() {
                    nameController.clear();
                    ageController.clear();
                  });
                } else {
                  addPeople(nameController.text, int.parse(ageController.text))
                      .then((_) => Navigator.pop(context))
                      .catchError((onError) => _verToast(context,
                          message: "Error $onError", button: "Ok"))
                      .whenComplete(() {
                    nameController.clear();
                    ageController.clear();
                  });
                }
              },
              color: Colors.cyan[100],
              child: Text(args['id'] != '' ? 'Actualizar' : 'Ingresar',
                  style: const TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

void _verToast(BuildContext context,
    {message = 'Accion Ok', button = 'Action'}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: button, onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
