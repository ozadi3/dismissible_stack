library dismmisible_stack;

import 'package:flutter/material.dart';

class DismissibleStack extends StatefulWidget {

  const
  DismissibleStack({
    this.children,
    this.swipeRight,
    this.swipeLeft,
    this.onDismissed,
    this.dismissThresholds,
    this.direction = DismissDirection.vertical,
  });

  final List<Widget> children;

  final Widget swipeRight;

  final Widget swipeLeft;

  final Function onDismissed;

  final Map<DismissDirection, double> dismissThresholds;

  final DismissDirection direction;

  @override
  State<StatefulWidget> createState() => _DismissibleStackState();
}

class _DismissibleStackState
    extends State<DismissibleStack> {

  @override
  Widget build(BuildContext context) {
    Stack _stack = new Stack(
      children: _createDismissibleChildren(widget.children),
    );

    return _stack;
  }

  _createDismissibleChildren(List<Widget> children) {
    List<Widget> _dismissibleList = new List();

    for (var child in children) {
      _dismissibleList.add(createDismissibleChild(child));
    }
  }

  Widget createDismissibleChild(Widget child) {
    return Dismissible (
      background: widget.swipeRight,
      secondaryBackground: widget.swipeLeft,
      onDismissed: widget.onDismissed,
      dismissThresholds: widget.dismissThresholds,
      direction: widget.direction,
      key: UniqueKey(),
      child: child,
    );
  }
}