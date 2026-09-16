import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/localization/locale_cubit.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';
import 'package:gbv/features/pathway/view/pathway_page.dart';
import 'package:gbv/features/pathway/widgets/assessment_gauge.dart';
import 'package:gbv/features/pathway/widgets/pathway_action_card.dart';
import 'package:gbv/features/screening/bloc/screening_cubit.dart';
import 'package:gbv/injection_container.dart';
import 'package:gbv/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late LocaleCubit localeCubit;
  late AccessibilityBloc accessibilityBloc;
  late ScreeningCubit screeningCubit;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.getString(any())).thenReturn(null);
    when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);
    when(() => mockPrefs.setBool(any(), any())).thenAnswer((_) async => true);

    localeCubit = LocaleCubit(mockPrefs);
    accessibilityBloc = AccessibilityBloc(mockPrefs);
    screeningCubit = ScreeningCubit();

    if (!sl.isRegistered<AccessibilityBloc>()) {
      sl.registerLazySingleton<AccessibilityBloc>(() => accessibilityBloc);
    }
  });

  tearDown(() {
    localeCubit.close();
    accessibilityBloc.close();
    screeningCubit.close();
    if (sl.isRegistered<AccessibilityBloc>()) {
      sl.reset();
    }
  });

  Widget buildTestWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>.value(value: localeCubit),
        BlocProvider<AccessibilityBloc>.value(value: accessibilityBloc),
        BlocProvider<ScreeningCubit>.value(value: screeningCubit),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, child) => const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PathwayPage(),
        ),
      ),
    );
  }

  group('PathwayPage Widget Tests', () {
    testWidgets('Renders Assessment Summary card and all 3 action cards',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // Set up screening answers for high concern (e.g. 80%)
      screeningCubit.setSelectedCategories([
        IncidentCategory.stalking,
        IncidentCategory.threats,
      ]);
      final q0 = screeningCubit.state.activeQuestions[0];
      final highOpt = q0.options.firstWhere((o) => o.points == 3);
      screeningCubit.answerQuestion(q0, highOpt);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Check Assessment Summary Card elements
      expect(find.text('Assessment Summary'), findsOneWidget);
      expect(find.byType(AssessmentGauge), findsOneWidget);

      // Check Action Cards
      expect(find.byType(PathwayActionCard), findsNWidgets(3));
      expect(find.text('Talk to a Counselor'), findsOneWidget);
      expect(find.text('Call Helpline 1145'), findsOneWidget);
      expect(find.text('Know Your Digital Rights'), findsOneWidget);
      expect(find.text('Learn More'), findsOneWidget);
      expect(find.text('Safety Planning Tips'), findsOneWidget);
      expect(find.text('View Tips'), findsOneWidget);
    });

    testWidgets('Tapping Learn More opens Digital Rights Modal',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final learnMoreButton = find.text('Learn More');
      expect(learnMoreButton, findsOneWidget);

      await tester.tap(learnMoreButton);
      await tester.pumpAndSettle();

      expect(find.text('Digital Rights in Nepal'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);

      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      expect(find.text('Digital Rights in Nepal'), findsNothing);
    });

    testWidgets('Tapping View Tips opens Safety Planning Tips Modal',
        (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final viewTipsButton = find.text('View Tips');
      expect(viewTipsButton, findsOneWidget);

      await tester.tap(viewTipsButton);
      await tester.pumpAndSettle();

      // Title exists on both card and in modal sheet
      expect(find.text('Safety Planning Tips'), findsNWidgets(2));
      expect(find.text('Close'), findsOneWidget);

      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
    });
  });
}
