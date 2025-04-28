import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_task/Core/extensions/extensions.dart';
import 'package:store_task/Core/library_widgets/sharp_elevated_button.dart';
import 'package:store_task/Core/utils/app_strings.dart';
import 'package:store_task/Features/settings/presentation/cubit/locale/locale_cubit.dart';

class SwitchLanguageWidget extends StatefulWidget {
  const SwitchLanguageWidget({super.key});

  @override
  State<SwitchLanguageWidget> createState() => _SwitchLanguageWidgetState();
}

class _SwitchLanguageWidgetState extends State<SwitchLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    var textDirection = Directionality.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return Row(
              children: [
                SharpRectangleButton(
                  onPressed: () {
                    // Adjust the position based on the current text direction
                    RelativeRect menuPosition =
                        textDirection == TextDirection.rtl
                            ? const RelativeRect.fromLTRB(
                                100, 100, 0, 0) // LTR position
                            : const RelativeRect.fromLTRB(
                                0, 100, 100, 0); // RTL position

                    showMenu(
                      context: context,
                      position: menuPosition,
                      items: [
                        PopupMenuItem(
                          value: AppStrings.englishCode,
                          child: Text('English'.translate(context)),
                        ),
                        PopupMenuItem(
                          value: AppStrings.arabicCode,
                          child: Text('Arabic'.translate(context)),
                        ),
                      ],
                    ).then((value) {
                      if (value != null) {
                        // Call the LocaleCubit to change the language based on selected value
                        BlocProvider.of<LocaleCubit>(context).changeLang(value);
                      }
                    });
                  },
                  color: Colors.red,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(textDirection == TextDirection.ltr
                          ? 'assets/svgs/United Kingdom (GB).svg'
                          : 'assets/svgs/twemoji_flag-saudi-arabia.svg'),
                      const SizedBox(width: 8),
                      Text('Check_Language'.translate(context)),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
