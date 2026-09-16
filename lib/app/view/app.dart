import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';
import 'package:gbv/features/screening/bloc/screening_cubit.dart';
import 'package:gbv/injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<LocaleCubit>()),
        BlocProvider.value(value: sl<AccessibilityBloc>()),
        BlocProvider.value(value: sl<ScreeningCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<AccessibilityBloc, AccessibilityState>(
            builder: (context, accessibilityState) {
              final settings = accessibilityState.settings;
              final textScale = AppFontSizes.getScale(settings.textSize);

              return ScreenUtilInit(
                designSize: const Size(390, 844),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (_, child) {
                  return MaterialApp.router(
                    title: 'GBV Screening Tool',
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.buildTheme(settings),
                    routerConfig: appRouter,
                    locale: locale,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    builder: (context, child) {
                      if (child == null) return const SizedBox.shrink();
                      return MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(textScaler: TextScaler.linear(textScale)),
                        child: child,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
