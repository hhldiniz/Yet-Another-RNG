import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/rng_bloc.dart';
import 'package:yet_another_rng/presentations/number_presentation.dart';
import 'package:yet_another_rng/providers/rng_bloc_provider.dart';
import 'package:yet_another_rng/widgets/number.dart';

class Rng extends StatefulWidget {
  const Rng({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RngState();
  }
}

class RngState extends State<Rng> {
  RngBloc? bloc;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      bloc ??= RngBlocProvider.of(context).bloc;
    });

    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<NumberPresentation>(
                  stream: bloc?.numberStream,
                  builder: (BuildContext context, snapshot) {
                    return InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(200)),
                      child: Number(snapshot.data?.numberText ?? "--"),
                      onTap: () {
                        bloc?.generateRandomNumber();
                      },
                    );
                  })
            ],
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }
}
