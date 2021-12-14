import 'package:flutter/material.dart';
import 'package:yet_another_rng/providers/number_bloc_provider.dart';
import 'package:yet_another_rng/widgets/number.dart';

class Rng extends StatefulWidget {
  const Rng({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RngState();
  }
}

class RngState extends State<Rng> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [NumberBlocProvider(const Number())],
          )),
        ],
      ),
    );
  }
}
