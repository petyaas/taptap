import 'package:flutter/material.dart';
enum Theme { light, dark,}
class MultipleChoice extends StatefulWidget {
   const MultipleChoice({super.key,required this.onChange,required this.currentTheme});
   final bool currentTheme;

   final Function(bool) onChange;

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  Set<Theme> selection = <Theme>{Theme.light};
@override
  void initState() {
  if(widget.currentTheme){selection=<Theme>{Theme.light};}
  else{selection=<Theme>{Theme.dark};}
    // TODO: implement initState
    super.initState();
  }
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
