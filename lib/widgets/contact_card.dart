import 'package:flutter/material.dart';

/// A [Card] that is standardized for the contact pages
class ContactCard extends Card {
  /// Required widget that should go inside the card
  final Widget child;

  /// The space around the contact card
  ///
  /// default if no margin is specified:
  ///
  /// ```
  /// this.margin = const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0)
  /// ```
  final EdgeInsetsGeometry margin;

  /// Creates a Contact card with a [margin] around it and has
  /// the specified [child] inside the card.
  ContactCard(
      {Key key,
      @required this.child,
      this.margin = const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0)})
      : super(
            shape: Border(),
            key: key,
            child: child,
            margin: margin);
} // ContactCard defintion