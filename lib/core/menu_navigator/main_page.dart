import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:tuple/tuple.dart';
import 'package:web_admin/core/menu_navigator/widgets/main_navigator.dart';
import 'package:web_admin/core/app_strings.dart';

class MainPage extends StatefulWidget {
  final List<Tuple4<int, String, String, Icon>> pages = const [
    Tuple4(1, AppStrings.manPage, "/mainPage", Icon(Icons.home)),
    Tuple4(2, AppStrings.events, "/events", Icon(Icons.event)),
    Tuple4(3, AppStrings.bookings, '/bookings', Icon(Icons.home_repair_service_sharp)),
    Tuple4(3, AppStrings.sessions, '/sessions', Icon(Icons.login)),
  ];

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _isNavigating = false; // To track navigation status
  int selected = 0; // Tracks the selected menu option

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            backgroundColor: colorScheme.secondary, // Background color of the side menu
            builder: (data) => SideMenuData(
              header: Text(
                AppStrings.menuHeader,
                style: TextStyle(
                  color: colorScheme.onSecondary, // Text color for the header
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              items: widget.pages.map((e) => SideMenuItemDataTile(
                isSelected: selected == e.item1,
                onTap: () => _navigateTo(e.item3),
                title: e.item2,
                titleStyle: TextStyle(color: colorScheme.onSecondaryFixed), // Normal state text color
                selectedTitleStyle: TextStyle(color: colorScheme.onSecondaryFixed), // Selected state text color
                icon: Icon(e.item4.icon, color: colorScheme.onSecondaryFixedVariant), // Icon color
                highlightSelectedColor: colorScheme.secondaryContainer, // Background color when selected
              )).toList(),
              footer: Text(
                AppStrings.menuFooter,
                style: TextStyle(
                  color: colorScheme.onSurface, // Text color for the footer
                ),
              ),
            ),
          ),
          Expanded(
            child: MainNavigator(_navigatorKey),
          )
        ],
      ),
    );
  }

  void _navigateTo(String routeName) async {
    if (!_isNavigating && _navigatorKey.currentState != null) {
      _isNavigating = true;
      while(_navigatorKey.currentState?.canPop() ?? false) {
        _navigatorKey.currentState!.pop();
      }
      _navigatorKey.currentState!.pushNamed(routeName);
      _isNavigating = false;
    }
  }
}
