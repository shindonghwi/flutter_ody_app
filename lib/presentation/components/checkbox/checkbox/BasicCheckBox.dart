import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/checkbox/model/CheckBoxSize.dart';
import 'package:odac_flutter_app/presentation/components/checkbox/model/CheckBoxType.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class BasicCheckBox extends HookWidget {
  final bool isChecked;
  final CheckBoxSize size;
  final CheckBoxType type;
  final Function(bool) onChange;

  const BasicCheckBox({
    Key? key,
    required this.isChecked,
    required this.size,
    required this.type,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: size == CheckBoxSize.Normal ? 1 : 0.78,
      child: Checkbox(
        value: isChecked,
        activeColor: getColorScheme(context).primary100,
        fillColor: MaterialStateProperty.all(isChecked
            ? getColorScheme(context).primary100
            : getColorScheme(context).neutral40),
        checkColor: getColorScheme(context).white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            type == CheckBoxType.Circle ? 100 : 2,
          ),
        ),
        onChanged: (bool? value) => onChange(isChecked),
      ),
    );
  }
}
