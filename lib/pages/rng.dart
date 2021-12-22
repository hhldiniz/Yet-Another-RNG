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
  final numberListItemSize = const Size(50, 50);

  @override
  Widget build(BuildContext context) {
    ScrollController numberListScrollController = ScrollController();

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
                        if (bloc != null) {
                          numberListScrollController.animateTo(
                              numberListItemSize.width *
                                      bloc!.rolledNumberList.length -
                                  1,
                              duration: const Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn);
                        }
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
                  final screenSize = MediaQuery.of(context).size;
                  return SizedBox(
                    width: screenSize.width,
                    height: screenSize.height/2,
                    child: GridView.count(
                      crossAxisCount: 6,
                      controller: numberListScrollController,
                      children:
                          bloc?.rolledNumberList.map((numberPresentation) {
                                return SizedBox(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Number(
                                      numberPresentation.numberText,
                                      fontSize: 16,
                                    ),
                                  ),
                                  width: numberListItemSize.width,
                                  height: numberListItemSize.height,
                                );
                              }).toList() ??
                              [],
                    ),
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
