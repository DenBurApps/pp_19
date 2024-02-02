import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/data/database/database_keys.dart';
import 'package:pp_19/data/database/database_service.dart';
import 'package:pp_19/presentation/widgets/app_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _databaseService = GetIt.instance<DatabaseService>();

  int currentStep = 0;

  final images = [
    ImageHelper.getImage(ImageNames.onb1),
    ImageHelper.getImage(ImageNames.onb2),
    ImageHelper.getImage(ImageNames.onb3),
    ImageHelper.getImage(ImageNames.onb4),
  ];

  final Map<int, Map<String, String>> _stepsInfo = {
    0: {
      'title': 'Easy money,\neasy life!',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. ut risus ut iaculis neque vitae arcu.'
    },
    1: {
      'title': 'Keep track of\nyour income\nand expenses!',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur.ut risus ut iaculis neque vitae arcu.'
    },
    2: {
      'title': 'Analysis of\nfinances',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur.ut risus ut iaculis neque vitae arcu.'
    },
    3: {
      'title': 'Join millions of\nusers',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur.ut risus ut iaculis neque vitae arcu.'
    },
    4: {
      'title': 'Enjoy to the\ncourses!',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur.ut risus ut iaculis neque vitae arcu.'
    },
  };

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _databaseService.put(DatabaseKeys.seenOnboarding, true);
  }

  Map<String, String> getStepInfo(int step) {
    return _stepsInfo[step] ?? {'title': 'Default Title', 'subtitle': 'Default Subtitle'};
  }

  void increaseStep() {
    if (currentStep == 3) {
      Navigator.of(context).pushReplacementNamed(RouteNames.main);
      return;
    }
    setState(() {
      currentStep += 1;
    });
  }

  void skip() {
    Navigator.of(context).pushReplacementNamed(RouteNames.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: images[currentStep].image,
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getStepInfo(currentStep)['title'] ?? 'Default title',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        getStepInfo(currentStep)['subtitle'] ?? 'Default Subtitle',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                AppButton(
                  name: 'Get started',
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  callback: increaseStep,
                  width: double.infinity,
                ),
                currentStep == 0
                    ? Center(
                        child: CupertinoButton(
                        onPressed: skip,
                        child: Text(
                          'Skip',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ))
                    : const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
