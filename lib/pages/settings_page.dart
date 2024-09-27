import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/settings_bloc.dart';
import 'package:yet_another_rng/providers/settings_bloc_provider.dart';
import 'package:yet_another_rng/widgets/text_input.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        bloc?.loadSettings();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc ??= SettingsBlocProvider.of(context).bloc;

    TextEditingController minimumValueFieldController = TextEditingController();
    TextEditingController maximumValueFieldController = TextEditingController();

    return Scaffold(
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Intervalo"),
          StreamBuilder<int>(
            stream: bloc?.minimum,
            builder: (context, snapshot) {
              minimumValueFieldController.value = minimumValueFieldController
                  .value
                  .copyWith(text: bloc?.minimumValue.toString());

              return Padding(
                padding: const EdgeInsets.all(8),
                child: CustomTextInput(
                  controller: minimumValueFieldController,
                  inputType: TextInputType.number,
                  labelText: "Mínimo",
                  onChanged: (value) =>
                      bloc?.updateMinimum(int.tryParse(value) ?? 0),
                ),
              );
            },
          ),
          StreamBuilder<int>(
            stream: bloc?.maximum,
            builder: (context, snapshot) {
              maximumValueFieldController.value = maximumValueFieldController
                  .value
                  .copyWith(text: bloc?.maximumValue.toString());
              return Padding(
                padding: const EdgeInsets.all(8),
                child: CustomTextInput(
                  controller: maximumValueFieldController,
                  inputType: TextInputType.number,
                  labelText: "Máximo",
                  onChanged: (value) =>
                      bloc?.updateMaximum(int.tryParse(value) ?? 100),
                ),
              );
            },
          ),
          Expanded(
              child: Align(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 120,
                height: 60,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            alignment: Alignment.bottomCenter,
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
