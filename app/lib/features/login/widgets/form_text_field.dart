import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final Function(String) onChanged;

  const FormTextField({
    Key? key,
    required this.hint,
    required this.onChanged,
    required this.icon,
    this.obscure = false,
  }) : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool isHidden = false;

  @override
  void initState() {
    super.initState();
    isHidden = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: isHidden,
      autocorrect: false,
      textInputAction:
          widget.obscure ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Palette.shade3,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 15.0,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.shade3,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        hintText: widget.hint,
        prefixIcon: Icon(
          widget.icon,
          size: 20.0,
        ),
        suffixIcon: widget.obscure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                icon: Icon(
                  isHidden ? Icons.visibility_off : Icons.visibility,
                  size: 20.0,
                ),
              )
            : null,
      ),
    );
  }
}
