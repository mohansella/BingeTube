import 'package:bingetube/core/analytics/analytics.dart';
import 'package:bingetube/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

enum PageTransistionType { predefined, none, fade }

class PageGoRoute extends GoRoute {
  PageGoRoute({
    required this.page,
    required this.customBuilder,
    this.transistionType = .predefined,
  }) : super(
         name: page.name,
         path: page.path,
         builder: (c, s) {
           final path = s.name ?? s.uri.path;
           //Analytics.logPageView(path);
           return customBuilder(c, s);
         },
         pageBuilder: transistionType == .predefined
             ? null
             : (c, s) => buildTransistion(transistionType, customBuilder, c, s),
       );

  final Pages page;
  final GoRouterWidgetBuilder customBuilder;
  final PageTransistionType transistionType;

  static Page<dynamic> buildTransistion(
    PageTransistionType type,
    GoRouterWidgetBuilder customBuilder,
    BuildContext context,
    GoRouterState state,
  ) {
    if (type == .fade) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: customBuilder(context, state),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
    }
    return NoTransitionPage(child: customBuilder(context, state));
  }
}
