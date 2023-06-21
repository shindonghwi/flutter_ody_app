import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ody_flutter_app/presentation/features/main/home/HomeScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/my/MyScreen.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';

class MainScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _currentIndex = useState(0); // Current index of the active tab

    List<Pair> _iconList = [
      Pair('assets/imgs/icon_record_1.svg', getAppLocalizations(context).main_tab_record),
      Pair('assets/imgs/icon_analyzing.svg', getAppLocalizations(context).main_tab_analysis),
      Pair('assets/imgs/icon_mypage.svg', getAppLocalizations(context).main_tab_my),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex.value,
        children: const [
          HomeScreen(),
          Center(child: Text("news"),),
          MyScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: getColorScheme(context).neutral50,
              width: 1,
            ),
          )
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: getColorScheme(context).colorPrimaryFocus,
          unselectedItemColor: getColorScheme(context).neutral50,
          currentIndex: _currentIndex.value,
          onTap: (index) {
            _currentIndex.value = index; // Update the current index when a tab is tapped
          },
          items: _iconList.map((data) {
            return BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    data.first,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).neutral50,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 4,)
                ],
              ),
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    data.first,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).colorPrimaryFocus,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 4,)
                ],
              ),
              label: data.second,
            );
          }).toList(),
          selectedLabelStyle: getTextTheme(context).c3b,
          unselectedLabelStyle: getTextTheme(context).c3b,
        ),
      ),
    );
  }
}
