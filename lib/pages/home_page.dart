import 'package:adsoapp/services/people_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.appTitle});
  final String appTitle;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _nVentanas = const <Tab>[
    Tab(icon: Icon(Icons.article_outlined, size: 30.0), text: 'Información'),
    Tab(icon: Icon(Icons.list, size: 30.0), text: 'Control'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _nVentanas.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.appTitle),
        ),
        body: FutureBuilder(
          future: getPeople(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(snapshot.data?[index]['name']),
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        isThreeLine: true,
                        onTap: () async {
                          await Navigator.pushNamed(context, '/addPeople',
                              arguments: {
                                "id": snapshot.data?[index]['id'],
                                "name": snapshot.data?[index]['name'],
                                "age": snapshot.data?[index]['age'],
                              });
                          setState(() {});
                        });
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/addPeople');
              setState(() {});
            },
            child: const Icon(Icons.add)),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
