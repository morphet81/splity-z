import 'package:flutter/material.dart';
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/shared/widgets/expanded_selectable_icon.dart';

class SpliteeListItemEdit extends StatefulWidget {
  const SpliteeListItemEdit({required this.splitee, super.key});

  final Splitee splitee;

  @override
  State<SpliteeListItemEdit> createState() => _SpliteeListItemEditState();
}

class _SpliteeListItemEditState extends State<SpliteeListItemEdit> {
  void onFoodIconChange(bool isSelected) {
    debugPrint('Food icon is $isSelected');
  }

  void onDrinkIconChange(bool isSelected) {
    debugPrint('Drink icon is $isSelected');
  }

  void onAlcoholIconChange(bool isSelected) {
    debugPrint('Alcohol icon is $isSelected');
  }

  void onTaxiIconChange(bool isSelected) {
    debugPrint('Taxi icon is $isSelected');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  autocorrect: false,
                  initialValue: widget.splitee.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Splitee name',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  debugPrint('Confirm edit');
                },
                icon: Icon(Icons.check),
              )
            ],
          ),
          Row(
            children: [
              ExpandedSelectableIcon(
                icon: Icons.restaurant,
                onChange: onFoodIconChange,
              ),
              ExpandedSelectableIcon(
                icon: Icons.local_drink,
                onChange: onDrinkIconChange,
              ),
              ExpandedSelectableIcon(
                icon: Icons.liquor,
                onChange: onAlcoholIconChange,
              ),
              ExpandedSelectableIcon(
                icon: Icons.local_taxi,
                onChange: onTaxiIconChange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
