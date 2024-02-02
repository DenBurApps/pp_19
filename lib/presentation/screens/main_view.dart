import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/presentation/screens/courses_view.dart';
import 'package:pp_19/presentation/screens/home_view.dart';
import 'package:pp_19/presentation/screens/settings_view.dart';
import 'package:pp_19/presentation/screens/statistic_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> pages = [
    const HomeView(),
    const StatisticView(),
    const CoursesView(),
    const SettingsView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: SizedBox(
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: ImageHelper.svgImage(SvgNames.home),
                icon: ImageHelper.svgImage(SvgNames.home,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: ImageHelper.svgImage(SvgNames.statistic),
                icon: ImageHelper.svgImage(SvgNames.statistic,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: ImageHelper.svgImage(SvgNames.courses),
                icon: ImageHelper.svgImage(SvgNames.courses,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: ImageHelper.svgImage(SvgNames.settings),
                icon: ImageHelper.svgImage(SvgNames.settings,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
