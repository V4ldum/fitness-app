import 'package:fitness_app/constants.dart';
import 'package:flutter/material.dart';

class LoginField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final Function(String) onChanged;

  const LoginField({
    Key? key,
    this.hint = "",
    this.icon = Icons.device_unknown,
    this.obscure = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  bool isHidden = false;

  @override
  void initState() {
    super.initState();
    isHidden = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscureText: widget.obscure,
      autocorrect: false,
      decoration: kLoginTextFieldStyle.copyWith(
        hintText: widget.hint,
        prefixIcon: Icon(widget.icon, size: 20.0),
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
