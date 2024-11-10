import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:web_admin/features/bookings/presentation/pages/bookings_page.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:web_admin/features/events/presentation/pages/events_page.dart';
import 'package:web_admin/features/events/presentation/state/events_bloc.dart';
import 'package:web_admin/features/initial_page/presentation/pages/initial_page.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_bloc.dart';
import 'package:web_admin/features/sessions/presentation/pages/sessions_page.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_bloc.dart';

class MainNavigator extends StatelessWidget{
  final GlobalKey<NavigatorState> _navigatorKey;

  const MainNavigator(this._navigatorKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
              key: _navigatorKey,
              initialRoute: '/mainPage',
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder = switch (settings.name) {
                   '/events'=>
                      (BuildContext _) => 
                        BlocProvider<EventsBloc> (
                          create: (context) => GetIt.instance.get<EventsBloc>(),
                          child: EventsPage()
                        ),
                   '/bookings'=>
                      (BuildContext _) => 
                        BlocProvider<BookingsBloc> (
                          create: (context) => GetIt.instance.get<BookingsBloc>(),
                          child: BookingsPage()
                        ),
                  '/sessions'=> 
                      (BuildContext _) => 
                        BlocProvider<SessionsBloc> (
                          create: (context) => GetIt.instance.get<SessionsBloc>(),
                          child: SessionsPage(),
                        ),
                  //default case
                  _=>
                      (BuildContext _) => 
                        BlocProvider<InitialPageBloc>(
                          create: (context) => GetIt.instance.get<InitialPageBloc>(),
                          child: InitialPage(),
                        ),
                };
                return MaterialPageRoute(builder: builder, settings: settings);
              },
            );
  }
}