import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_task/Core/utils/app_strings.dart';
import 'package:store_task/Features/settings/presentation/cubit/locale/locale_cubit.dart';

class SwitchLanguage extends StatelessWidget {
  const SwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        if (state is ChangeLocaleState) {
          bool isEnglish = state.locale.languageCode == AppStrings.englishCode;
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEnglish ? 'To Arabic' : 'To English',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
                SizedBox(width: 10.w),
                Transform.scale(
                  scale: 1.2,
                  child: Switch(
                    activeColor: Colors.blueAccent,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.shade300,
                    value: isEnglish,
                    onChanged: (_) async {
                      if (isEnglish) {
                        await context.read<LocaleCubit>().toArabic();
                      } else {
                        await context.read<LocaleCubit>().toEnglish();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
