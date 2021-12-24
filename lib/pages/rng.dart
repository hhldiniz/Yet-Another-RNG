import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/rng_bloc.dart';
import 'package:yet_another_rng/pages/settings_page.dart';
import 'package:yet_another_rng/presentations/number_list_presentation.dart';
import 'package:yet_another_rng/providers/rng_bloc_provider.dart';
import 'package:yet_another_rng/providers/settings_bloc_provider.dart';
import 'package:yet_another_rng/states/rolled_number_state.dart';
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

  Number _getRolledNumberWidget(RolledNumberState state) {
    if (state is SuccessState) {
      return Number(state.numberPresentation.numberText);
    } else if (state is ErrorState) {
      return Number(state.message);
    } else if (state is InitState) {
      return Number(state.message);
    } else {
      return Number((state as ErrorState).message);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController numberListScrollController = ScrollController();
    bloc ??= RngBlocProvider.of(context).bloc;

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      SettingsBlocProvider(const SettingsPage()),
                ));
              },
              icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                bloc?.reset();
              },
              icon: const Icon(Icons.refresh))
        ],
        backgroundColor: const Color(0x0000000f),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<RolledNumberState>(
                  stream: bloc?.numberStream,
                  builder: (BuildContext context, snapshot) {
                    return InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(200)),
                      child: snapshot.data != null
                          ? _getRolledNumberWidget(snapshot.data!)
                          : null,
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
                  })),
          Expanded(
              child: StreamBuilder<NumberListPresentation>(
            stream: bloc?.numberListStream,
            builder: (context, snapshot) {
              return GridView.count(
                crossAxisCount: 6,
                controller: numberListScrollController,
                children: bloc?.rolledNumberList.map((numberPresentation) {
                      return SizedBox(
                        child: Align(
                          alignment: Alignment.center,
                          child: Number(
                            numberPresentation.numberText,
                          ),
                        ),
                        width: numberListItemSize.width,
                        height: numberListItemSize.height,
                      );
                    }).toList() ??
                    [],
              );
            },
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
