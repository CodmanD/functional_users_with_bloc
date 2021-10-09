import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodman_for_gbk_functional/bloc/bloc_event.dart';
import 'package:kodman_for_gbk_functional/bloc/bloc_main.dart';
import 'package:kodman_for_gbk_functional/model/person.dart';

class PersonSrceen extends StatefulWidget {
  const PersonSrceen({Key? key, required this.person, required this.bloc})
      : super(key: key);

  final Person person;
  final PersonBloc bloc;

  @override
  _PersonSrceenState createState() => _PersonSrceenState();
}

class _PersonSrceenState extends State<PersonSrceen> {
  late TextController _nameController;
  late TextController _lastnameController;
  late TextController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();

    _nameController = TextController(text: widget.person.name);
    _lastnameController = TextController(text: widget.person.lastName);
    _emailController = TextController(text: widget.person.email);
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonBloc>(
      create: (context) => widget.bloc,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    widget.person.name = _nameController.text;
                    widget.person.lastName = _lastnameController.text;
                    widget.person.email = _emailController.text;
                    widget.bloc.add(UpdatePersonEvent(widget.person));
                  });
                  Navigator.pop(context);
                } else {
                  print("------No validate");
                }
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(widget.person.largeFoto),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => _nameController.text = value,
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      validator: (value) =>
                          value!.isEmpty ? 'Name cannot be empty' : null,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) => _lastnameController.text = value,
                      controller: _lastnameController,
                      textAlign: TextAlign.center,
                      validator: (value) =>
                          value!.isEmpty ? 'Lastname cannot be empty' : null,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'LastName',
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) => _emailController.text = value,
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be empty' : null,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextController extends TextEditingController {
  TextController({required String text}) {
    this.text = text;
  }

  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}
