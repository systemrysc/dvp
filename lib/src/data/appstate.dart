import 'dart:convert';
import 'package:dvp_app/src/models/directions.dart';
import 'package:dvp_app/src/models/users.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class AppState extends ChangeNotifier {
  List<Users> _users = [];
  List<Users> get users => _users;

  List<Directions> _directions = [];
  List<Directions> get directions => _directions;

  final LocalStorage storage;

  AppState(this.storage) {
    _usersLoad();
    _directionsLoad();
  }

  userUpdate(Users user) {
    try {
      final index = _users.indexWhere((item) => user.id == item.id);

      if (index == -1) {
        _users.add(user);
      } else {
        _users[index] = user;
      }
      _usersSave();
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  _usersLoad() {
    try {
      final data = storage.getItem("users_dvp");
      if (data == null) return;

      _users = List<Users>.from(
        (jsonDecode(data) as List).map(
          (item) => Users.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  _usersSave() {
    try {
      storage.setItem(
        "users_dvp",
        jsonEncode(_users.map((item) => item.toJson()).toList()),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  directionsUpdate(Directions directions){
    
    try{
      _directions.add(directions);
      _directionsSave();
    }catch(e){
      throw Exception(e);
    }
    
  }

  _directionsLoad() {
    try {
      final data = storage.getItem("directions_dvp");
      if (data == null) return;
      _directions = List<Directions>.from(
        (jsonDecode(data) as List).map((item) => Directions.fromJson(item as Map<String,dynamic>)),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  _directionsSave() {
    try {
      
      storage.setItem(
        "directions_dvp",
        jsonEncode(_directions.map((item) => item.toJson()).toList())); 
       
    }catch(e){
      throw Exception(e);
    }    
  }

  String lastDirections(int id){
     final data = directions.lastWhere((item)=>item.id==id);
     return data.direction;
  }

  List<Directions> getDirectionById(int id){
     return _directions.where((item)=> item.id==id).toList();
    
  }
}
