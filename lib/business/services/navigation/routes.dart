import 'package:flutter/cupertino.dart';
import 'package:pp_19/business/controllers/course_controller.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';
import 'package:pp_19/presentation/screens/courses_view.dart';
import 'package:pp_19/presentation/screens/home_view.dart';
import 'package:pp_19/presentation/screens/lesson_view.dart';
import 'package:pp_19/presentation/screens/lessons_list_view.dart';
import 'package:pp_19/presentation/screens/main_view.dart';
import 'package:pp_19/presentation/screens/new_transaction_view.dart';
import 'package:pp_19/presentation/screens/onboarding_view.dart';
import 'package:pp_19/presentation/screens/privacy_temrs_view.dart';
import 'package:pp_19/presentation/screens/privacy_view.dart';
import 'package:pp_19/presentation/screens/quiz_view.dart';
import 'package:pp_19/presentation/screens/settings_view.dart';
import 'package:pp_19/presentation/screens/splash_view.dart';
import 'package:pp_19/presentation/screens/statistic_view.dart';
import 'package:pp_19/presentation/screens/support_view.dart';
import 'package:pp_19/presentation/screens/transactions_view.dart';
import 'package:pp_19/presentation/screens/wallet_view.dart';

typedef ScreenBuilding = Widget Function(BuildContext context);

class Routes {
  static Map<String, ScreenBuilding> get(BuildContext context) {
    return {
      RouteNames.splash: (context) => const SplashView(),
      RouteNames.main: (context) => const MainScreen(),
      RouteNames.home: (context) => const HomeView(),
      RouteNames.onboarding: (context) => const OnboardingView(),
      RouteNames.transactions: (context) => TransactionsView(),
      RouteNames.wallet: (context) => WalletView(),
      RouteNames.newTransaction: (context) {
        final transactionType = ModalRoute.of(context)!.settings.arguments as TransactionType;
        return NewTransactionView(transactionType: transactionType);
      },
      RouteNames.statistic: (context) => const StatisticView(),
      RouteNames.settings: (context) => const SettingsView(),
      RouteNames.support: (context) => const SupportView(),
      RouteNames.privacyAndTerms: (context) {
        final isTerms = ModalRoute.of(context)!.settings.arguments as bool;
        return PrivacyTermsView(isTerms: isTerms);
      },
      RouteNames.courses: (context) => const CoursesView(),
      RouteNames.lessonsList: (context) {
        final args = ModalRoute.of(context)!.settings.arguments as LessonListViewArgs;
        return LessonListView(card: args.card, courseController: args.courseController);
      },
      RouteNames.lesson: (context) {
        final controller = ModalRoute.of(context)!.settings.arguments as CourseController;
        return LessonView(courseController: controller);
      },
      RouteNames.quiz: (context) {
        final controller = ModalRoute.of(context)!.settings.arguments as CourseController;
        return QuizzesView(controller: controller);
      }, 
      RouteNames.privacy:(context) => const  PrivacyView(), 
    };
  }
}
