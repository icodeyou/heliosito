import 'package:app/feature_q1/presentation/screen_cat_detail.dart';
import 'package:app/ui/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/HomeScreen.dart';

void main() {
  BlocOverrides.runZoned(
    () {},
    blocObserver: CatBlocObserver(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heliosito',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: UI.backgroundColor),
      initialRoute: routeName,
      routes: {
        routeName: (context) => const HomeScreen(),
        CatDetailScreen.routeName: (context) => const CatDetailScreen(),
      },
    );
  }
}

class CatBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase blocbase, Change change) {
    print(change);
    super.onChange(blocbase, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase blocbase, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(blocbase, error, stackTrace);
  }
}
