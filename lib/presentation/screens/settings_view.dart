import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final InAppReview inAppReview = InAppReview.instance;

  Future<void> _requestReview() async {
    final bool isAvailable = await inAppReview.isAvailable();

    if (isAvailable) {
      inAppReview.requestReview();
    } else {
      print('error rate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 64),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Settings',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              minSize: 180,
                              onPressed: () => Navigator.of(context).pushNamed(RouteNames.privacyAndTerms, arguments: false),
                              color: Theme.of(context).extension<CustomColors>()!.outcomeBg,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      child: ImageHelper.svgImage(SvgNames.privacy,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.5))),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Privacy policy',
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              minSize: 180,
                              onPressed: () => Navigator.of(context).pushNamed(RouteNames.privacyAndTerms, arguments: true),
                              color: Theme.of(context).extension<CustomColors>()!.incomeBg,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      child: ImageHelper.svgImage(SvgNames.terms,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.5))),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Terms of use',
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              minSize: 180,
                              onPressed: () => Navigator.of(context).pushNamed(RouteNames.support),
                              color: Theme.of(context).extension<CustomColors>()!.incomeBg,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      child: ImageHelper.svgImage(SvgNames.headphones,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.5))),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Support',
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              minSize: 180,
                              onPressed: _requestReview,
                              color: Theme.of(context).extension<CustomColors>()!.outcomeBg,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      child: ImageHelper.svgImage(SvgNames.heart,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.5))),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Rate app',
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ]),
      ),
    );
  }
}
