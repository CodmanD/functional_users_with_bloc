import 'package:kodman_for_gbk_functional/model/person.dart';

abstract class PersonEvent {}

class LoadPersonEvent extends PersonEvent {}

class DeletePersonEvent extends PersonEvent {
  String id;

  DeletePersonEvent(this.id);
}

class UpdatePersonEvent extends PersonEvent {
  Person person;

  UpdatePersonEvent(this.person);
}
