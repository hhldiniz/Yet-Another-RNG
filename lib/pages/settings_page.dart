import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/settings_bloc.dart';
import 'package:yet_another_rng/models/settings.dart';
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
        body: SafeArea(
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Intervalo",
            style: TextStyle(fontSize: 24),
          ),
          StreamBuilder<Settings>(
            stream: bloc?.settings,
            builder: (context, snapshot) {
              minimumValueFieldController.value = minimumValueFieldController
                  .value
                  .copyWith(text: snapshot.data?.minimum.toString());

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
          StreamBuilder<Settings>(
            stream: bloc?.settings,
            builder: (context, snapshot) {
              maximumValueFieldController.value = maximumValueFieldController
                  .value
                  .copyWith(text: snapshot.data?.maximum.toString());
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
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 120,
                height: 60,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).primaryColor)),
                    onPressed: () async {
                      var navigation = Navigator.of(context);
                      await bloc?.save();
                      navigation.pop();
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ))
        ],
      )),
    ));
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }
}
