import 'package:flutter/material.dart';
import 'package:makanforfree/models/user.dart';

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final _user = User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Container(
        padding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(),
                TextFormField(),
                TextFormField(),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                  child: Text('Subscibe'),
                ),
                SwitchListTile(
                  title: const Text('Halal'),
                  // value: _user.halaal,
                  value: null,
                  onChanged: (bool val) {
                    // setState(() => _user.halal = val);
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegetarian'),
                  // value: _user.vegetarian,
                  value: null,
                  onChanged: (bool val) {
                    // setState(() => _user.vegetarian = val);
                  },
                ),
                CheckboxListTile(value: null, onChanged: null)
              ]
            )
          ),
        ),
      ),
    );
  }
}