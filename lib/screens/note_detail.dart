import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  NoteDetail(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailState(this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  final String appBarTitle;
  static var _priorities = ['High', 'Low'];

  //TextStyle? textStyle = Theme.of(context).textTheme.labelMedium;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(

        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              final bool shouldPop = await _showBackDialog() ?? false;
              if (context.mounted && shouldPop) {
                Navigator.pop(context);
              }
            },
          ),
        ),

        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[

              ListTile(
                title: DropdownButton(
                  items: _priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String> (
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),

                  //style: textStyle,

                  value: 'Low',

                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  //style: textStyle,
                  onChanged: (value) {
                    debugPrint('Something change in Title Text Field');
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    //labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: descriptionController,
                  //style: textStyle,
                  onChanged: (value) {
                    debugPrint('Something change in Description Text Field');
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                    //labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Save'),
                        onPressed: () {
                          setState(() {
                            debugPrint('Save button is pressed');
                          });
                        },
                      ),
                    ),

                    Container(width: 5.0,),

                    Expanded(
                      child: ElevatedButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          setState(() {
                            debugPrint('Cancel button is pressed');
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Stay'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}