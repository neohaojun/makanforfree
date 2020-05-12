import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:grouped_buttons/grouped_buttons.dart';
// import 'package:makanforfree/models/user.dart';

class FormMaterial extends StatefulWidget {
  @override
  _FormMaterialState createState() => _FormMaterialState();
}

class _FormMaterialState extends State<FormMaterial> {
  TextEditingController _locationController;
  TextEditingController _choicesController;

  @override
  void initState() { 
    super.initState();
    _locationController = TextEditingController(text: "");
    _choicesController = TextEditingController(text: "");
  }

  // final _user = User();
  final _formKey = GlobalKey<FormState>();
  String _date = "Buffet Expiry Date";
  String _time = "Buffet Expiry";
  bool _halal = false;
  bool _vegetarian = false;
  bool _permission = false;
  bool permissionStyle = false;

  List<String> _amounts = <String>['Abundant', 'Reasonable', 'Not much left'];
  String _currentItemSelected = 'Amount of Food Left';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Buffet'),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0,),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.pin_drop,
                      ),
                      labelText: "Location (e.g. OTH, KKH)",
                    ),
                    controller: _locationController,
                    maxLines: null,
                    validator: (val) => val.isEmpty ? 'Enter a valid location.' : null,
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      hint: Text(_currentItemSelected),
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          this._currentItemSelected = newValue;
                        });
                      },
                      items: _amounts.map((String dropdownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropdownStringItem,
                          child: Text(dropdownStringItem),
                        );
                      }).toList(), 
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.fastfood,
                      ),
                      labelText: "Food Choices Available",
                    ),
                    controller: _choicesController,
                    maxLines: null,
                  ),
                  SizedBox(height: 20.0),
                  FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                      print('confirm $date');
                      _date = '${date.year} - ${date.month} - ${date.day}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "   $_date",
                                    style: TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  Change",
                          style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.teal[400],
                ),
                SizedBox(height:10.0),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {
                    DatePicker.showTimePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true, onConfirm: (time) {
                      print('confirm $time');
                      _time = '${time.hour} : ${time.minute} : ${time.second}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "   $_time",
                                    style: TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  Change",
                          style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.green[400],
                ),
                  SizedBox(height: 10.0),
                  CheckboxListTile(
                    title: const Text(
                      'Halal'
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _halal,
                    onChanged: (bool newValue) {
                      setState(() {
                        _halal = newValue;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                      'Vegetarian'
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _vegetarian,
                    onChanged: (bool newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 5.0),
                  Divider(color: Colors.grey[600]),
                  SizedBox(height: 5.0),
                  CheckboxListTile(
                    title: Text(
                      "I have obtained the event organiser's permission",
                      style: permissionStyle
                        ? TextStyle(color: Colors.green)
                        : TextStyle(color: Colors.red),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _permission,
                    onChanged: (bool newValue) {
                      setState(() {
                        _permission = newValue;
                        permissionStyle = !permissionStyle;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  ButtonTheme(
                    minWidth: double.infinity,
                    height: 40.0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        color: Colors.blue.withOpacity(.26),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/tick.svg",
                              height: 20.0,
                            ),
                            Text('   SUBMIT')
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            )
          ),
        ),
      ),
    );
  }
}