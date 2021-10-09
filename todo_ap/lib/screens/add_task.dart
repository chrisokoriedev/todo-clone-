import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _dataTime = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateController.text=_dateFormatter.format(_dataTime);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateController.dispose();
  }

  final List<String> priorities = ['Low', 'Medium', 'High'];

  //  the code that handle date and it formatter
  final DateFormat _dateFormatter = DateFormat('MMM dd,yyyy');

  _handlerDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _dataTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _dataTime) {
      setState(() {
        _dataTime = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  //the code here is to save the project am typing
  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title, $_dataTime, $_priority');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Add Task',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                                hoverColor: Theme.of(context).primaryColor,
                                labelText: 'title',
                                labelStyle: TextStyle(fontSize: 18.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            validator: (input) => input.trim().isEmpty
                                ? 'input field is empty'
                                : null,
                            onSaved: (input) => _title = input,
                            initialValue: _title,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            readOnly: true,
                            controller: _dateController,
                            style: TextStyle(fontSize: 18.0),
                            onTap: _handlerDatePicker,
                            decoration: InputDecoration(
                                hoverColor: Theme.of(context).primaryColor,
                                labelText: 'Date',
                                labelStyle: TextStyle(fontSize: 18.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DropdownButtonFormField(
                            isDense: true,
                            icon: Icon(Icons.arrow_circle_down_rounded),
                            iconEnabledColor: Theme.of(context).primaryColor,
                            iconSize: 26.0,
                            items: priorities.map((String prior) {
                              return DropdownMenuItem(
                                value: prior,
                                child: Text(
                                  prior,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.0),
                                ),
                              );
                            }).toList(),
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                                hoverColor: Theme.of(context).primaryColor,
                                labelText: 'Priority',
                                labelStyle: TextStyle(fontSize: 18.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            validator: (input) => _priority == null
                                ? 'Please select a priority level'
                                : null,
                            onChanged: (value) {
                              setState(() {
                                _priority = value;
                              });
                            },
                            value: _priority,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          height: 60.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: FlatButton(
                            onPressed: _submit,
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
