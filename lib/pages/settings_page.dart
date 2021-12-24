import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:yet_another_rng/blocs/settings_bloc.dart';
import 'package:yet_another_rng/providers/settings_bloc_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingsPage> {
  SettingsBloc? bloc;

  @override
  Widget build(BuildContext context) {
    bloc ??= SettingsBlocProvider.of(context).bloc;

    TextEditingController minimumValueFieldController = TextEditingController();
    TextEditingController maximumValueFieldController = TextEditingController();

    minimumValueFieldController.addListener(() {
      bloc?.updateMinimum(int.parse(minimumValueFieldController.value.text));
    });

    maximumValueFieldController.addListener(() {
      bloc?.updateMinimum(int.parse(maximumValueFieldController.value.text));
    });

    return Scaffold(
      body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Intervalo"),
          TextFormField(
            controller: minimumValueFieldController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Mínimo"),
          ),
          TextFormField(
            controller: maximumValueFieldController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Máximo"),
          ),
          Expanded(
              child: Align(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK")),
            ),
            alignment: Alignment.bottomRight,
          ))
        ],
      )),
    );
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }
}
