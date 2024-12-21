import 'package:flutter/material.dart';
import 'package:get/get.dart';
enum Theme { light, dark,}
class MultipleChoice extends StatefulWidget {
   const MultipleChoice({super.key,required this.onChange});

   final Function(bool) onChange;

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  Set<Theme> selection = <Theme>{Theme.light};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Theme>(
      showSelectedIcon: false,

      segments: const <ButtonSegment<Theme>>[
        ButtonSegment<Theme>(
            value: Theme.light, icon: Icon(Icons.light_mode)),
        ButtonSegment<Theme>(
            value: Theme.dark, icon: Icon(Icons.dark_mode)),
      ],
      selected: selection,
      onSelectionChanged: (Set<Theme> newSelection) {
        setState(() {
          selection = newSelection;
          print(newSelection.toString());
          if(newSelection.first==Theme.light){
            widget.onChange(true);
          }
          else{
            widget.onChange(false);
          }
        });
      },
      multiSelectionEnabled: false,
    );
  }
}
