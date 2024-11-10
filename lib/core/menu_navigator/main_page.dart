import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:tuple/tuple.dart';
import 'package:web_admin/core/menu_navigator/widgets/main_navigator.dart';
import 'package:web_admin/core/app_strings.dart';

class MainPage extends StatefulWidget {
  final List<Tuple4<int, String, String, IconData>> pages = const [
    Tuple4(1, AppStrings.manPage, "/mainPage", Icons.home),
    Tuple4(2, AppStrings.events, "/events", Icons.event),
    Tuple4(3, AppStrings.bookings, '/bookings', Icons.home_repair_service_sharp),
    Tuple4(4, AppStrings.sessions, '/sessions', Icons.login),
  ];

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _isNavigating = false;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            backgroundColor: colorScheme.secondary,
            builder: (data) => SideMenuData(
              header: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 80,
                    ),
                  ),
                  Text(
                    AppStrings.menuHeader,
                    style: TextStyle(
                      color: colorScheme.onSecondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              items: widget.pages.map((e) {
                final isSelected = selected == e.item1;
                return SideMenuItemDataTile(
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selected = e.item1;
                    });
                    _navigateTo(e.item3);
                  },
                  title: e.item2,
                  titleStyle: TextStyle(
                    color: isSelected
                        ? colorScheme.onSecondary
                        : colorScheme.onSecondary.withOpacity(0.7),
                  ),
                  selectedTitleStyle: TextStyle(
                    color: colorScheme.onSecondary,
                  ),
                  icon: Icon(
                    e.item4,
                    color: isSelected
                        ? colorScheme.onSecondary
                        : colorScheme.onSecondary.withOpacity(0.7),
                  ),
                  highlightSelectedColor: colorScheme.secondaryContainer,
                );
              }).toList(),
              footer: Column(
                children: [
                  Divider(color: colorScheme.onSecondary.withOpacity(0.5)),
                  Text(
                    AppStrings.menuFooter,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: MainNavigator(_navigatorKey),
          ),
        ],
      ),
    );
  }

  void _navigateTo(String routeName) async {
    if (!_isNavigating && _navigatorKey.currentState != null) {
      _isNavigating = true;
      while (_navigatorKey.currentState?.canPop() ?? false) {
        _navigatorKey.currentState!.pop();
      }
      _navigatorKey.currentState!.pushNamed(routeName);
      _isNavigating = false;
    }
  }
}
