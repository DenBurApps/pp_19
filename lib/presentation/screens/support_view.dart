import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/helpers/email_helper.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/app_button.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isChecked = false;
  bool isButtonEnabled = false;

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          _messageController.text.isNotEmpty && _emailController.text.isNotEmpty && isChecked;
    });
  }

  void _sendMessage() {
    EmailHelper.launchEmailSubmission(
      toEmail: 'amanmansab1122@gmail.com',
      subject: 'Connect with support',
      body: _messageController.text,
      errorCallback: () => _showDialog(text: 'Error', isDone: false),
      doneCallback: () => _showDialog(text: 'Thank you for feedback!', isDone: true),
    );
  }

  void _showDialog({required String text, required bool isDone}) {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.secondary,
              ),
              height: 200,
              width: 200,
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: isDone
                            ? Theme.of(context).extension<CustomColors>()!.green
                            : Theme.of(context).extension<CustomColors>()!.red,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 44),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
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
                    'Support',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                const Spacer(),
              ]),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4))),
              child: TextField(
                onChanged: (text) => updateButtonState(),
                controller: _messageController,
                style: Theme.of(context).textTheme.labelSmall,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Message text...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4))),
              child: TextField(
                onChanged: (text) => updateButtonState(),
                controller: _emailController,
                style: Theme.of(context).textTheme.labelSmall,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Your email...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Checkbox(
                    activeColor: Colors.black,
                    checkColor: Colors.white,
                    splashRadius: 0,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                      updateButtonState();
                    },
                  ),
                ),
                const SizedBox(width: 13),
                Text(
                  'I agree to the terms of use of\nthe "Support" services',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: AppButton(
                  name: 'Send',
                  width: double.infinity,
                  backgroundColor: Theme.of(context).extension<CustomColors>()!.lighterBlack!,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  callback: isButtonEnabled ? () => _sendMessage() : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
