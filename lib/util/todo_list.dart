import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {

  final String title;
  final bool checked;
  final void Function(bool?)? onCheck;
  final void Function(BuildContext)? onDelete;
  final void Function(BuildContext)? onUpdate;

  const TodoList({
    super.key,
    this.checked = false,
    required this.title,
    this.onCheck,
    this.onDelete,
    this.onUpdate
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onUpdate,
              backgroundColor: Colors.green,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.yellow,
          ),
          child: Row(
            children: [

              //Checkbox
              Flexible(
                  flex: 1,
                  child: Checkbox(
                      value: checked,
                      onChanged: onCheck
                  )
              ),

              //Title
              Flexible(
                flex: 3,
                child: Center(
                    child: Text(title, style: TextStyle(
                      decoration: checked ? TextDecoration.lineThrough : null,
                    ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
