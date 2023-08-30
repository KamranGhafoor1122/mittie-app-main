

import 'package:flutter/material.dart';
class MyDropDown extends StatelessWidget {
  final List<String> items;
  final String val;
  final String hint;
  final Function(String val) onChanged;
   MyDropDown({Key key,@required this.items,@required this.onChanged,@required this.val,@required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: val,
      underline: SizedBox(),
      hint: Text(hint,style: TextStyle(
         fontSize: 12,
          color: Colors.grey[800]
      ),),
      iconEnabledColor: Theme.of(context).primaryColor,
      iconDisabledColor: Theme.of(context).primaryColor,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
