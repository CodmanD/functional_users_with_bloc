import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:kodman_for_gbk_functional/model/person.dart';
import 'package:kodman_for_gbk_functional/repo/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  String _getUsers = "https://randomuser.me/api/?results=20";

  void _savePersonToDB(List<Person> persons) {
    persons.forEach((person) async {
      var res = await PersonDatabase.instance.create(person);
    });
  }

  Future<List<Person>> getPersons() async {
    List<Person> persons;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (prefs.containsKey("firstLaunch")) {
        // print("---------Two Launch");
        persons = await getPersonsFromDB();
      } else {
        // print("---------First Launch");
        persons = await getPersonsFromServer();
        _savePersonToDB(persons);
        prefs.setBool("firstLaunch", false);
      }
    } catch (_) {
      throw Exception('Error :' + _.toString());
    }

    return persons;
  }

  Future<List<Person>> getPersonsFromDB() async {
    return PersonDatabase.instance.readAllPersons();
  }

  Future<List<Person>> getPersonsFromServer() async {
    try {
      var url = Uri.parse(_getUsers);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var userJson = json.decode(response.body);
        final List<dynamic> list = userJson["results"];
        final List<Person> persons =
            list.map((json) => Person.fromJson(json)).toList();

        return persons;
      } else {
        //print('EEEERRRROOOR');
        throw Exception('Server Error : ' + response.statusCode.toString());
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
