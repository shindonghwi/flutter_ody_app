import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/model/RecordItemState.dart';
import 'package:odac_flutter_app/presentation/features/main/home/provider/CalendarSelectDateProvider.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class CardRecordItems extends HookConsumerWidget {
  const CardRecordItems({
    super.key,
  });

  void movePage(BuildContext context, String title, bool selectDateIsToday) {
    if (title == getAppLocalizations(context).home_today_record_walk) {
    } else if (title == getAppLocalizations(context).home_today_record_blood_pressure) {
      Navigator.push(
        context,
        nextSlideScreen(
          selectDateIsToday
              ? RoutingScreen.RecordBloodPressure.route
              : RoutingScreen.RecordedListBloodPressure.route,
        ),
      );
    } else if (title == getAppLocalizations(context).home_today_record_glucose) {
      Navigator.push(context, nextSlideScreen(RoutingScreen.RecordGlucose.route));
    } else {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarSelectedDate = ref.watch<DateTime>(CalendarSelectDateProvider);

    final recordItemState = [
      useState<RecordItemState>(
        RecordItemState(
          title: getAppLocalizations(context).home_today_record_walk,
          contents: [
            Pair(
              "3,685",
              getAppLocalizations(context).home_today_record_walk_unit,
            ),
          ],
          imagePath: 'assets/imgs/ody_record_blood_pressure.png',
        ),
      ),
      useState<RecordItemState>(
        RecordItemState(
          title: getAppLocalizations(context).home_today_record_blood_pressure,
          contents: [
            Pair(
              "120 - 80",
              getAppLocalizations(context).home_today_record_blood_pressure_unit1,
            ),
            Pair(
              "75",
              getAppLocalizations(context).home_today_record_blood_pressure_unit2,
            ),
          ],
          imagePath: 'assets/imgs/ody_record_blood_pressure.png',
        ),
      ),
      useState<RecordItemState>(
        RecordItemState(
          title: getAppLocalizations(context).home_today_record_glucose,
          contents: [
            Pair(
              "100",
              getAppLocalizations(context).home_today_record_glucose_unit,
            ),
          ],
          imagePath: 'assets/imgs/ody_record_blood_pressure.png',
        ),
      ),
      useState<RecordItemState>(
        RecordItemState(
          title: getAppLocalizations(context).home_today_record_emotion,
          contents: [
            Pair(
              "0",
              getAppLocalizations(context).home_today_record_emotion,
            ),
          ],
          imagePath: 'assets/imgs/ody_record_blood_pressure.png',
        ),
      ),
    ];

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 17.0,
        crossAxisSpacing: 20.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final title = recordItemState[index].value.title;
          final contents = recordItemState[index].value.contents;
          final imagePath = recordItemState[index].value.imagePath;

          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: index % 2 == 0 ? 20 : 0,
                  right: index % 2 == 1 ? 20 : 0,
                ),
                decoration: BoxDecoration(
                  color: isEmotionType(context, title)
                      ? getColorScheme(context).neutral30
                      : getColorScheme(context).white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8D8D8D).withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => movePage(
                        context, title, DateChecker.isDateToday(calendarSelectedDate)),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.fromLTRB(15, 23, 10, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: getTextTheme(context).l3m.copyWith(
                                  color: isEmotionType(context, title)
                                      ? getColorScheme(context).neutral80
                                      : getColorScheme(context).neutral70,
                                ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          isEmotionType(context, title)
                              ? Text(
                                  getAppLocalizations(context).home_today_record_prepare,
                                  style: getTextTheme(context).c1b.copyWith(
                                        color: getColorScheme(context).neutral70,
                                      ),
                                )
                              : Column(
                                  children: contents.map((e) {
                                    return Row(
                                      children: [
                                        Text(
                                          e.first.toString(),
                                          style: getTextTheme(context).t2b.copyWith(
                                                color: getColorScheme(context).neutral70,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          e.second,
                                          style: getTextTheme(context).c1b.copyWith(
                                                color: getColorScheme(context).neutral60,
                                              ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                          const Expanded(child: SizedBox()),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              imagePath,
                              height: 70,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isEmotionType(context, title))
                IgnorePointer(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: getColorScheme(context).colorUI04.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
            ],
          );
        },
        childCount: recordItemState.length,
      ),
    );
  }

  bool isEmotionType(BuildContext context, String title) {
    return title == getAppLocalizations(context).home_today_record_emotion;
  }
}
