import "package:flutter/material.dart";

    class InputText extends StatefulWidget {

      final String label;
      const InputText({Key? key,required this.label, required TextEditingController controller}) : super(key: key);

      @override
      _InputTextState createState() => _InputTextState();
    }

    class _InputTextState extends State<InputText> {
      @override
      Widget build(BuildContext context) {
        return TextFormField(
        decoration: InputDecoration(
          labelText: widget.label
        ),
        );
      }
    }
