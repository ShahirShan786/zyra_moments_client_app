import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zyra_momments_app/app/application/features/discover/discover_screen.dart';
import 'package:zyra_momments_app/app/application/features/events/event_screen.dart';
import 'package:zyra_momments_app/app/application/features/home/home_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/profile_screen.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final pages = [
    HomeScreen(),
    DiscoverScreen(),
    EventScreen(),
    ProfileScreen(),
  ];

  int _getTabIndex(NavigationTab tab) {
    switch (tab) {
      case NavigationTab.home:
        return 0;
      case NavigationTab.discover:
        return 1;
      case NavigationTab.events:
        return 2;
      case NavigationTab.profile:
        return 3;
    }
  }

  NavigationTab _getTabFromIndex(int index) {
    switch (index) {
      case 0:
        return NavigationTab.home;
      case 1:
        return NavigationTab.discover;
      case 2:
        return NavigationTab.events;
      case 3:
      default:
        return NavigationTab.profile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final currentIndex = _getTabIndex(state.selectedTab);
        return Scaffold(
          body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              child: KeyedSubtree(
                  key: ValueKey(currentIndex), child: pages[currentIndex])),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.darkPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.darkSecondaryColor, width: 1)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: GNav(
                    gap: 8,
                    selectedIndex: currentIndex,
                    onTabChange: (index) {
                      final tab = _getTabFromIndex(index);
                      context
                          .read<NavigationBloc>()
                          .add(NavigationTabChanged(tab));
                    },
                    tabBackgroundColor: AppTheme.darkBorderColor,
                    color: AppTheme.darkTextColor,
                    activeColor: AppTheme.darkTextColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    tabs: const [
                      GButton(
                        icon: Icons.home_outlined,
                        text: "Home",
                      ),
                      GButton(
                        icon: Icons.explore_outlined,
                        text: "Works",
                      ),
                      GButton(
                        icon: Icons.bookmarks_outlined,
                        text: "Bookings",
                      ),
                      GButton(
                        icon: Icons.person_2_outlined,
                        text: "Profile",
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
