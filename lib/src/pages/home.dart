import 'package:dvp_app/src/data/appstate.dart';
import 'package:dvp_app/src/models/users.dart';
import 'package:dvp_app/src/pages/directions.dart';
import 'package:dvp_app/src/pages/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset("images/logo.png", height: 50,), 
      backgroundColor: Theme.of(context).colorScheme.inversePrimary ,),
      body: Consumer<AppState>(
        builder: (context,provider,_){
          final users = provider.users;
          return UserListPage(users: users);
        }),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersPage()));
        },
        tooltip: "Adicionar Usuario",
        child: Icon(Icons.add),  
        
        ),  
    );
  }
}

class UserListPage extends StatelessWidget {
  const UserListPage({
    super.key,
    required this.users,
  });

  final List<Users> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
          final user = users[index];
          final dir = Provider.of<AppState>(context,listen: false).lastDirections(user.id);
          
          return Padding(
            padding: EdgeInsets.all(4),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.group),                   
                ),
                title: Text('${user.name} ${user.lastname}'),
                subtitle: Column(
                  spacing: 4,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Text(user.date)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.place),
                        Expanded(child: Text(dir, overflow: TextOverflow.ellipsis,))
                      ],
                    )
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=>DirectionsPage(),
                    settings: RouteSettings(arguments: user.id)));
                },
              ),
            ),
          );
      });
  }
}