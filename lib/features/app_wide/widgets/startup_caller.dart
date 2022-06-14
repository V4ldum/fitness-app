import 'package:flutter/material.dart';

class StartupCaller extends StatefulWidget {
  final Widget? child;
  final Function()? onInit;

  const StartupCaller({
    Key? key,
    this.child,
    this.onInit,
  }) : super(key: key);

  @override
  State<StartupCaller> createState() => _StartupCallerState();
}

class _StartupCallerState extends State<StartupCaller> {
  @override
  void initState() {
    super.initState();

    if (widget.onInit != null) {
      widget.onInit!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}
