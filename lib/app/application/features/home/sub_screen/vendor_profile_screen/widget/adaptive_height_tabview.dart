import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/bloc/tab_height_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

class AdaptiveHeightTabView extends StatefulWidget {
  final double height;
  final double width;
  final List<Widget> tabs;
  final List<Widget> children;

  const AdaptiveHeightTabView(
      {super.key,
      required this.tabs,
      required this.children,
      required this.height,
      required this.width});

  @override
  State<AdaptiveHeightTabView> createState() => _AdaptiveHeightTabViewState();
}

class _AdaptiveHeightTabViewState extends State<AdaptiveHeightTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TabHeightBloc _tabHeightBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.children.length, vsync: this);
    _tabHeightBloc = TabHeightBloc(widget.children.length);

    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      _tabHeightBloc.add(ChangeTabEvent(tabIndex: _tabController.index));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabHeightBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _tabHeightBloc,
      child: BlocBuilder<TabHeightBloc, TabHeightState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  height: widget.height * 0.15,
                  decoration: BoxDecoration(
                      color: AppTheme.darkSecondaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: AppTheme.darkTextColorSecondary,
                    indicatorAnimation: TabIndicatorAnimation.elastic,
                    indicatorPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    indicator: BoxDecoration(
                        color: AppTheme.darkPrimaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    labelColor: AppTheme.darkTextColorSecondary,
                    controller: _tabController,
                    tabs: widget.tabs,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  height: state.currentHeight,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: AppTheme.darkBorderColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: List.generate(widget.children.length, (index) {
                      return ContentSizeNotifier(
                        index: index,
                        child: widget.children[index],
                      );
                    }),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ContentSizeNotifier extends StatefulWidget {
  final int index;
  final Widget child;

  const ContentSizeNotifier({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  State<ContentSizeNotifier> createState() => _ContentSizeNotifierState();
}

class _ContentSizeNotifierState extends State<ContentSizeNotifier> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
  }

 void _notifySize() {
  final context = _key.currentContext;
  if (context != null) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    
    // Add a small buffer to ensure all content is visible
    final adjustedHeight = size.height + 20; // Add padding
    
    context.read<TabHeightBloc>().add(
      UpdateTabHeightEvent(
        tabIndex: widget.index,
        height: adjustedHeight,
      ),
    );
    }
}

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        _notifySize();
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _key,
          child: widget.child,
        ),
      ),
    );
  }
}
