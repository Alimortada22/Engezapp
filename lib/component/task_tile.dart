import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  TodoTile(
      {super.key,
      required this.taskName,
      required this.ischecked,
      required this.onChanged,
      required this.removetask,
      
      });
  final bool ischecked;
  final String taskName;
  void Function(bool?)? onChanged;
  final Function(BuildContext) removetask;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: removetask,
            backgroundColor: Colors.red.shade300,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.circular(12),
            
          ),
        
        ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color:ischecked?Colors.blue[300]: Colors.blue),
          child: ListTile(
            leading: Checkbox(
              value: ischecked,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),
            title: Text(
              taskName,
              style: TextStyle(
                  decoration: ischecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,fontFamily: 'Handlee-Regular',fontSize: 23),
            ),
          ),
        ),
      ),
    );
  }
}
