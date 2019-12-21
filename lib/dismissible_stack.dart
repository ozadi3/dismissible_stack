library dismmisible_stack;

import 'package:flutter/material.dart';

const Map<DismissDirection, double> defaultDismissThresholds = {
  DismissDirection.startToEnd: 0.5,
  DismissDirection.endToStart: 0.5
};

const double defaultCrossAxisEndOffset = 0;

const double defaultAlignmentOffsetX = 0.1;
const double defaultAlignmentOffsetY = 0.0;

class DismissibleStack extends StatefulWidget {

  DismissibleStack({
    this.children,
    this.swipeRight, //TODO - better naming (depends on direction)
    this.swipeLeft, //TODO - better naming (depends on direction)
    this.onDismissed,
    this.dismissThresholds = defaultDismissThresholds,
    this.crossAxisEndOffset = defaultCrossAxisEndOffset,
    this.direction = DismissDirection.horizontal,
    this.stackAlignmentOffsetX = defaultAlignmentOffsetX,
    this.stackAlignmentOffsetY = defaultAlignmentOffsetY
  });

  final List<Widget> children;

  final Widget swipeRight;

  final Widget swipeLeft;

  final Function onDismissed;

  final Map<DismissDirection, double> dismissThresholds;

  final DismissDirection direction;

  final double crossAxisEndOffset;

  final double stackAlignmentOffsetX;

  final double stackAlignmentOffsetY;

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

  List<Widget> _createDismissibleChildren(List<Widget> children) {
    List<Widget> _dismissibleList = new List();

    for (var child in children) {
      _dismissibleList.add(
          createDismissibleChild(
              child,
              children.indexOf(child).toDouble()
          )
      );
    }

    return _dismissibleList;
  }

  Widget createDismissibleChild(Widget child, double index) {
    return Dismissible (
      background: widget.swipeRight,
      secondaryBackground: widget.swipeLeft,
      onDismissed: widget.onDismissed,
      dismissThresholds: widget.dismissThresholds,
      direction: widget.direction,
      crossAxisEndOffset: widget.crossAxisEndOffset,
      key: UniqueKey(),
      child: Container(
        alignment: Alignment(
            index * widget.stackAlignmentOffsetY,
            index * widget.stackAlignmentOffsetX
        ),
        child: child,
      )
    );
  }
}