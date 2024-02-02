import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/helpers/month_enum.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';

class DateSwitcher extends StatefulWidget {
  const DateSwitcher({
    super.key,
    required this.selectedDate,
    required this.increaseAction,
    required this.decreaseAction,
    required this.isFirstShowType,
  });

  final DateTime selectedDate;
  final VoidCallback increaseAction;
  final VoidCallback decreaseAction;
  final bool isFirstShowType;

  @override
  State<DateSwitcher> createState() => _DateSwitcherState();
}

class _DateSwitcherState extends State<DateSwitcher> {
  @override
  Widget build(BuildContext context) {
    int startMonth = widget.selectedDate.month;
    int endMonth = widget.selectedDate.month != 12 ? widget.selectedDate.month + 1 : 1;
    return Container(
      height: 57,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).extension<CustomColors>()!.lighterBlack),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => widget.decreaseAction.call(),
            child: ImageHelper.svgImage(SvgNames.arrowLeft),
          ),
          const SizedBox(width: 6),
          Row(children: [
            ImageHelper.svgImage(SvgNames.calendar),
            const SizedBox(width: 5),
            widget.isFirstShowType
                ? Text(
                    '${DateHelper.months[widget.selectedDate.month]}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  )
                : Text(
                    '${DateHelper.months[startMonth]!.substring(0, 3)} 01 - ${DateHelper.months[endMonth]!.substring(0, 3)} 01',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
          ]),
          const SizedBox(width: 6),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => widget.increaseAction.call(),
            child: ImageHelper.svgImage(SvgNames.arrowRight),
          ),
        ],
      ),
    );
  }
}
