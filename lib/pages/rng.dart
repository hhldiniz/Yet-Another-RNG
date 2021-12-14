import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/rng_bloc.dart';
import 'package:yet_another_rng/presentations/number_list_presentation.dart';
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(200)),
                      child: Number(snapshot.data?.numberText ?? "--"),
                      onTap: () {
                        bloc?.generateRandomNumber();
                      },
                    );
                  })
            ],
          )),
          Expanded(
              child: Row(
            children: [
              StreamBuilder<NumberListPresentation>(
                stream: bloc?.numberListStream,
                builder: (context, snapshot) {
                  return Container(
                    width: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bloc?.rolledNumberList.length ?? 0,
                        itemBuilder: (context, index) {
                          var currentItem = snapshot.data?.numberList[index];
                          return ListTile(
                            title: Text(currentItem?.numberText ?? "--"),
                          );
                        }),
                  );
                },
              )
            ],
          ))
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
