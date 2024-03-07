import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_19/business/helpers/dialog_helper.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/data/database/database_keys.dart';
import 'package:pp_19/data/database/database_service.dart';
import 'package:pp_19/models/arguments.dart';
import 'package:pp_19/presentation/screens/privacy_temrs_view.dart';
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
      'subtitle': 'Track your purchases in our app!'
    },
    1: {
      'title': 'Keep track of\nyour income\nand expenses!',
      'subtitle':
          'By monitoring your income and expenses, you can gain insight into your spending habits, identify potential areas for improvement, and make informed decisions about your financial priorities.'
    },
    2: {
      'title': 'Analysis of\nfinances',
      'subtitle':
          'Use your income and expense tracking data to set realistic financial goals. Whether it\'s saving for a big purchase, paying off debt, or building an emergency fund, having clear goals helps you stay focused and motivated.'
    },
    3: {
      'title': 'Join millions of\nusers',
      'subtitle':
          'Join millions of users in our app to take control of your finances and achieve your financial goals! Our app provides a comprehensive set of tools and features to help you track income and expenses, create budgets, and make informed financial decisions.'
    },
    4: {
      'title': 'Enjoy to the\ncourses!',
      'subtitle':
          'Our courses are carefully crafted by industry experts to ensure that the content is engaging, relevant, and up-to-date.'
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
    return _stepsInfo[step] ??
        {'title': 'Default Title', 'subtitle': 'Default Subtitle'};
  }

  void increaseStep() {
    if (currentStep == 3) {
      _databaseService.put(DatabaseKeys.seenPrivacyAgreement, true);
      DialogHelper.showPrivacyAgreementDialog(
        context,
        yes: () => Navigator.of(context).pushReplacementNamed(
          RouteNames.agreement,
          arguments: const AgreementViewArguments(
            agreementType: AgreementType.privacy,
            usePrivacyAgreement: true,
          ),
        ),
        no: () => Navigator.of(context).pushReplacementNamed(
          RouteNames.main,
        ),
      );
    } else {
      setState(() {
        currentStep += 1;
      });
    }
  }

  void skip() {
    _databaseService.put(DatabaseKeys.seenPrivacyAgreement, true);
    DialogHelper.showPrivacyAgreementDialog(
      context,
      yes: () => Navigator.of(context).pushReplacementNamed(
        RouteNames.agreement,
        arguments: const AgreementViewArguments(
          agreementType: AgreementType.privacy,
          usePrivacyAgreement: true,
        ),
      ),
      no: () => Navigator.of(context).pushReplacementNamed(
        RouteNames.main,
      ),
    );
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
        child: SafeArea(
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
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          getStepInfo(currentStep)['subtitle'] ??
                              'Default Subtitle',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  AppButton(
                    name: 'Get started',
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
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
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                          ),
                        ))
                      : const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
