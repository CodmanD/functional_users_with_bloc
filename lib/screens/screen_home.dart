import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodman_for_gbk_functional/bloc/bloc_event.dart';
import 'package:kodman_for_gbk_functional/bloc/bloc_main.dart';
import 'package:kodman_for_gbk_functional/bloc/bloc_state.dart';
import 'package:kodman_for_gbk_functional/model/person.dart';
import 'package:kodman_for_gbk_functional/screens/screen_person.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  // GlobalKey key = GlobalKey();
  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  PersonBloc bloc = PersonBloc(InitState());

  @override
  Widget build(BuildContext context) {
    List<Person> _list;

    return BlocProvider<PersonBloc>(
      create: (context) => bloc,
      child: Scaffold(
          appBar: AppBar(
            title: Text("GetUsers"),
          ),
          body: BlocBuilder<PersonBloc, PersonState>(builder: (context, state) {
            if (state is InitState) {
              bloc.add(LoadPersonEvent());
              return CircularProgressIndicator();
            } else if (state is LoadedState) {
              _list = (state as LoadedState).list;
              return ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    Person person = _list[index];
                    return Card(
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonSrceen(
                                        person: person,
                                        bloc: bloc,
                                      )));

                          setState(() {
                            print("-------------setstate");
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(person.foto),
                            Column(
                              children: [
                                Text(person.name),
                                Text(person.lastName),
                                Text(person.email),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _list.removeAt(index);
                                    bloc.add(DeletePersonEvent(person.uuid));
                                  });
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Text("UNKNOW ERROR");
          })),
    );
  }
}
