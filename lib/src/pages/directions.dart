import 'package:dvp_app/src/data/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DirectionsPage extends StatefulWidget {
  const DirectionsPage({super.key});

  @override
  State<DirectionsPage> createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  
  @override
  Widget build(BuildContext context) {
    
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(title: Text("Direcciones"),),
      body: SafeArea(
        child: Consumer<AppState>(
          builder: (context,provider,_){
             final directions = provider.getDirectionById(id);
             return ListView.builder(
              itemCount: directions.length,
              itemBuilder: (context,index){
                final direction = directions[index].direction;
                return ListTile(
                  leading: Icon(Icons.place),
                  title: Text(direction),
                );
              });   
          }
        )
      ),
    );
  }
}