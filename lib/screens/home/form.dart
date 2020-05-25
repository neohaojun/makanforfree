import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BuffetForm extends StatefulWidget {
  @override
  _BuffetFormState createState() => _BuffetFormState();
}

class _BuffetFormState extends State<BuffetForm> {

  @override
  void initState() { 
    super.initState();
    _titleController = TextEditingController(text: "");
    _locationController = TextEditingController(text: "");
    _choicesController = TextEditingController(text: "");
  }

  TextEditingController _titleController;
  TextEditingController _locationController;
  TextEditingController _choicesController;

  // final _user = User();
  final firestoreInstance = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String _date = "Buffet Expiry Date";
  String _time = "Buffet Expiry Time";
  var _day = 0;
  var _month = 0;
  var _year = 0;
  var _hour = 0;
  var _minute = 0;
  var _second = 0;
  var _expiryDate;
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
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0,),
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
                        Icons.title
                      ),
                      labelText: "Buffet Name (e.g. SLC Day 1 Lunch)",
                    ),
                    controller: _titleController,
                    maxLines: null,
                    validator: (val) => val.isEmpty ? 'This field cannot be empty' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.pin_drop,
                      ),
                      labelText: "Location (e.g. OTH, KKH)",
                    ),
                    controller: _locationController,
                    maxLines: null,
                    validator: (val) => val.isEmpty ? 'This field cannot be empty' : null,
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
                    validator: (val) => val.isEmpty ? 'This field cannot be empty' : null,
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
                      _date = '${date.day} - ${date.month} - ${date.year}';
                      _day = date.day;
                      _month = date.month;
                      _year = date.year;
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
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0
                                      ),
                                    ),
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
                      _hour = time.hour;
                      _minute = time.minute;
                      _second = time.second;
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
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0
                                      ),
                                    ),
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
                  // SizedBox(height: 1.0),
                  Divider(color: Colors.grey[600]),
                  // SizedBox(height: 1.0),
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
                  SizedBox(height: 15.0),
                  ButtonTheme(
                    minWidth: double.infinity,
                    height: 40.0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        color: Colors.blue.withOpacity(.26),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onPressed: () {
                          _expiryDate = DateTime(_year, _month, _day, _hour, _minute, _second);
                          firestoreInstance
                            .collection("buffets")
                            .add({
                              "title" : _titleController.text,
                              "location": _locationController.text,
                              "amount": _currentItemSelected,
                              "choices": _choicesController.text.replaceAll('\n', r'\n'),
                              "halal": _halal,
                              "vegetarian": _vegetarian,
                              "expiry": _expiryDate,
                            }).then((value){
                              print(value.documentID);
                            });
                        },
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