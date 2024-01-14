import 'package:business_flutter/models/step.dart';
import 'package:flutter/material.dart';


class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  final List<StepModel> _steps = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _renderSteps(),
      ),
    );
  }
  Widget _renderSteps() {
    return ExpansionPanelList(
      materialGapSize: 8.0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((StepModel step) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(step.title),
            );
          },
          body: ListTile(
            title: Text(step.body),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}




