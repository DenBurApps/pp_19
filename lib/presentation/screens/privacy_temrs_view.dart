import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/helpers/text_helper.dart';

class PrivacyTermsView extends StatelessWidget {
  const PrivacyTermsView({super.key, required this.isTerms});

  final bool isTerms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 44),
        color: Theme.of(context).colorScheme.surface,
        child: ListView(padding: EdgeInsets.zero, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(children: [
                  Transform.translate(
                    offset: const Offset(-10, 0),
                    child: CupertinoButton(
                      child: ImageHelper.svgImage(SvgNames.chevronLeft),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 54),
                    child: Text(
                      isTerms ? 'Terms of use' : 'Privacy police',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  const Spacer(),
                ]),
              ),
              const SizedBox(height: 10),
              Text(
                isTerms ? TextHelper.terms : TextHelper.privacy,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
