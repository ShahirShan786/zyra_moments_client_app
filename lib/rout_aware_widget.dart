
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';


final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

abstract class RouteAwareWidget extends StatefulWidget {
  const RouteAwareWidget({super.key});
}

abstract class RouteAwareState<T extends RouteAwareWidget> extends State<T> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when user comes back to this screen.
    onReturnFromNextScreen();
  }

  // You override this in your screen to do something when coming back
  void onReturnFromNextScreen() {}
}
