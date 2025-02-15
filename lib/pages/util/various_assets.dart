import 'package:flutter/material.dart';
import 'package:my_flutter_app/MongoDb/mongo_work.dart';

Future displayError(BuildContext context, Object e, [Object? details]){
  ThemeData theme = Theme.of(context);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(e.toString(),style: theme.primaryTextTheme.titleMedium),
        actions:[
          TextButton(
            onPressed: () {Navigator.of(context).pop() ;},
            child: const Text("OK")
          )
        ],
        content: (details != null) ? Text(details.toString(),style: theme.textTheme.bodyMedium) :  null,
      );
    }
  );
}

Widget designedButton(BuildContext context, String text, VoidCallback onPressed){
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top:20),
    child: SizedBox(
      height: 45,
      width: 130,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states){
            if(states.contains(WidgetState.pressed)){
              return const Color(0x88B4d3b2);
            }
            return const Color(0xFFB4d3b2);
          }),
          foregroundColor:const WidgetStatePropertyAll(Color(0xff000000)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        ),
    ),
  );
}

Widget designedTextController(BuildContext context, String labelText, String hintText, TextEditingController controller, [bool isPassword = false]){
  ThemeData theme = Theme.of(context);
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 100),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        style: theme.primaryTextTheme.bodyLarge,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelStyle: theme.primaryTextTheme.bodyLarge,
          labelText: labelText,
          hintStyle:  theme.primaryTextTheme.bodySmall,
          hintText: hintText,
          suffixIcon: isPassword ? const Icon(Icons.visibility_off) : null,
        )
      )
    ),
  );
}

Widget widgetNamePic(BuildContext context, Account a) {
  TextStyle style = Theme.of(context).primaryTextTheme.bodyLarge!;
  return Row(
    children: [
      ClipOval(child: a.profileImage),

      const SizedBox(width: 15),

      Text(a.userName, style: style),
    ],
  );
}
