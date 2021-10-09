import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodman_for_gbk_functional/bloc/bloc_event.dart';
import 'package:kodman_for_gbk_functional/bloc/bloc_state.dart';
import 'package:kodman_for_gbk_functional/model/person.dart';
import 'package:kodman_for_gbk_functional/repo/database.dart';
import 'package:kodman_for_gbk_functional/repo/repository.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc(PersonState initialState) : super(initialState);

  Repository repo = Repository();
  late List<Person> persons = <Person>[];

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event is LoadPersonEvent) {
      try {
        if (this.persons.length == 0) {
          this.persons = await repo.getPersons();
        }
        yield LoadedState(this.persons);
      } catch (e) {
        yield LoadErrorState(e.toString());
      }
    } else if (event is DeletePersonEvent) {
      try {
        int res = await PersonDatabase.instance.delete(event.id);
      } catch (e) {
        yield LoadErrorState(e.toString());
      }
    } else if (event is UpdatePersonEvent) {
      int res = await PersonDatabase.instance.update(event.person);
    }
  }
}
