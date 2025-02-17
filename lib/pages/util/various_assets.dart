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

class DesignedTextController extends StatefulWidget{
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const DesignedTextController({super.key, required this.hintText, required this.controller, this.isPassword = false});

  @override
  State<DesignedTextController> createState() => _DesignedTextControllerState();
}

class _DesignedTextControllerState extends State<DesignedTextController>{
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextField(
        controller: widget.controller,
        style: theme.primaryTextTheme.bodyLarge,
        obscureText: obscure,
        decoration: InputDecoration(
          hintStyle:  theme.primaryTextTheme.titleMedium,
          hintText: widget.hintText,
          suffixIcon: widget.isPassword ?  GestureDetector(onTap:() => setState(() => obscure = !obscure),
              child: const Icon(Icons.visibility_off, color: Colors.white)
          ):  null,
        )
      ),
    );
  }
}

void foo(){}

Widget homeWidgets({required BuildContext context, required String name, required Widget pic, String? data, Widget? extra}){
  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xff3f9b68),
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(height: 40,child: ClipOval(child: pic)),

            const SizedBox(width: 15),

            Text(name, style: textTheme.titleLarge),
          ],
        ),

        const SizedBox(height: 10,),

        Row(
          children: [
            if(extra != null) extra,

            const SizedBox(width: 15),

            if(data!= null) Text(data, style: textTheme.bodyLarge),
          ],
        ),

      ],
    ),
  );

}
