import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:web_admin/features/events/presentation/pages/events_page.dart';
import 'package:web_admin/features/events/presentation/state/events_bloc.dart';
import 'package:web_admin/features/initial_page/presentation/pages/initial_page.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_bloc.dart';

class MainNavigator extends StatelessWidget{
  final GlobalKey<NavigatorState> _navigatorKey;

  const MainNavigator(this._navigatorKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
              key: _navigatorKey,
              initialRoute: '/mainPage',
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;
                switch (settings.name) {
                  case '/events':
                    builder = (BuildContext _) => 
                        BlocProvider<EventsBloc> (
                          create: (context) => GetIt.instance.get<EventsBloc>(),
                          child: EventsPage()
                    );
                    break;
                  default:
                    builder = (BuildContext _) => 
                    BlocProvider<InitialPageBloc>(
                      create: (context) => GetIt.instance.get<InitialPageBloc>(),
                      child: InitialPage(),
                    );
                }
                return MaterialPageRoute(builder: builder, settings: settings);
              },
            );
  }
}