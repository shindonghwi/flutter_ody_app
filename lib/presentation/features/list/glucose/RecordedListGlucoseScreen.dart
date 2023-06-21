import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/BottomSheetGlucoseTable.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:ody_flutter_app/presentation/components/empty/EmptyView.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RecordedListGlucoseScreen extends StatelessWidget {
  const RecordedListGlucoseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        actionIcon: AppBarIcon(
          path: 'assets/imgs/icon_information.svg',
          onPressed: () {
            CommonBottomSheet.showBottomSheet(context, child: const BottomSheetGlucoseTable());
          },
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).list_record_glucose_title,
      ),
      backgroundColor: getColorScheme(context).colorUI03,
      body: Center(
        child: EmptyView(
          screen: RoutingScreen.RecordedListGlucose,
          onPressed: () {
            Navigator.push(
              context,
              nextSlideScreen(RoutingScreen.RecordGlucose.route),
            );
          },
        ),
      ),
    );
  }
}
