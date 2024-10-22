import 'package:engez/component/my_icon_utton.dart';
import 'package:flutter/material.dart';

class AddNewTask extends StatelessWidget {
  const AddNewTask(
      {super.key,
      required this.newtaskcontroller,
      required this.onsave,
      required this.oncancel});
  final TextEditingController newtaskcontroller;
  final VoidCallback onsave;
  final VoidCallback oncancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[200],
      content: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newtaskcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue)),
                  hintText: "New Task"),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyIconButton(
                  onPressed: () {
                    if (newtaskcontroller.text.isNotEmpty) {
                      onsave();
                    }
                  },
                  iconcolor: Colors.green,
                  icon: Icons.done,
                ),
                const SizedBox(
                  width: 10,
                ),
                MyIconButton(
                    onPressed: () {
                      oncancel();
                      FocusScope.of(context).unfocus(); // Dismiss keyboard
                    },
                    iconcolor: Colors.red,
                    icon: Icons.cancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
