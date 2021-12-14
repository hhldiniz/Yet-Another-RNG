import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/number_bloc.dart';
import 'package:yet_another_rng/presentations/number_presentation.dart';
import 'package:yet_another_rng/providers/number_bloc_provider.dart';

class Number extends StatefulWidget {
  const Number({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NumberState();
  }
}

class NumberState extends State<Number> {
  NumberBloc? bloc;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      bloc ??= NumberBlocProvider.of(context).bloc;
    });
    return StreamBuilder<NumberPresentation>(
        stream: bloc?.numberStream,
        builder: (buildContext, snapshot) {
          return InkWell(
            borderRadius: BorderRadius.circular(140),
            child: Text(
              snapshot.data?.numberText ?? "--",
              style: const TextStyle(fontSize: 260, color: Colors.white),
            ),
            onTap: () {
              bloc?.generateRandomNumber();
            },
          );
        });
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }
}
