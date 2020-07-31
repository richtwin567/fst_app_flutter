import 'package:flutter/material.dart';

/// A [ListTile] that
/// allows navigation to the [ContactDetailPage] for this [ContactTile] when tapped.
class ContactTile extends StatelessWidget {
  /// The title of this ContactTile.
  final String title;

  /// The subtitle for this ContactTile.
  final String subtitle;

  /// The route to the page that the Navigator should push when this tile is
  /// tapped instead of calling a [tapFunc].
  /// Must be a named route.
  final String namedRoute;

  /// The data to be passed to the next page when this tile is tapped.
  final dynamic arguments;

  /// The function to call when this tile is tapped instead of navigating to a
  /// [namedRoute].
  final GestureTapCallback tapFunc;

  /// Creates a contact tile.
  ///
  /// A contact tile has a [title] and [subtitle].
  /// If a [namedRoute] is provided, when tapped, this tile will navigate to
  /// the page defined by the [namedRoute]
  /// and pass its [arguments], if given, to that page.
  /// The [arguments] would be the information for this contact.
  /// If a [tapFunc] is provided, the tile will execute that function when tapped.
  /// **Either one [tapFunc] or one [namedRoute] must be passed, not both.**
  ContactTile(
      {Key key,
      @required this.title,
      @required this.subtitle,
      this.namedRoute,
      this.tapFunc,
      this.arguments})
      : assert((namedRoute == null && tapFunc != null) ||
            (namedRoute != null && tapFunc == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var tileH = mq.size.height * 0.15;

    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).accentColor, style: BorderStyle.solid))),
        height: tileH,
        alignment: Alignment.center,
        child: ListTile(
          onTap: namedRoute != null
              ? () {
                  arguments != null
                      ? Navigator.pushNamed(context, namedRoute,
                          arguments: arguments)
                      : Navigator.pushNamed(context, namedRoute);
                }
              : tapFunc,
          title: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle:
              Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing:
              Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
        ));
  }
} // ContactTile definition
