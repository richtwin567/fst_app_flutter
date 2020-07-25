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
            elevation: 2,
            margin: margin);
} // ContactCard defintion

/// A [ListTile] wrapped in a [ContactCard] that
/// allows navigation to the [ContactDetailPage] for this [ContactTile] when tapped.
class ContactTile extends StatelessWidget {
  /// The title of this ContactTile.
  final String title;

  /// The subtitle for this ContactTile.
  final String subtitle;

  /// The route to the page that the Navigator should push when this tile is tapped.
  /// Must be a named route.
  final String namedRoute;

  /// The data to be passed to the next page when this tile is tapped
  final dynamic arguments;

  /// Creates a contact tile.
  ///
  /// A contact tile has a [title] and [subtitle].
  /// When tapped, this tile will navigate to the page defined by the [namedRoute]
  /// and pass its [arguments], if given, to that page.
  /// The [arguments] would be the information for this contact.
  ContactTile(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.namedRoute,
      this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContactCard(
        child: ListTile(
      contentPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
      onTap: () {
        arguments != null
            ? Navigator.pushNamed(context, namedRoute, arguments: arguments)
            : Navigator.pushNamed(context, namedRoute);
      },
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
    ));
  }
} // ContactTile definition