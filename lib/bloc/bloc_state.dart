import 'package:kodman_for_gbk_functional/model/person.dart';

abstract class PersonState {}

class InitState extends PersonState {}

class LoadingState extends PersonState {}

class UpdatedState extends PersonState {}

class LoadedState extends PersonState {
  List<Person> list;

  LoadedState(this.list);
}

class LoadErrorState extends PersonState {
  String message;

  LoadErrorState(this.message);
}
