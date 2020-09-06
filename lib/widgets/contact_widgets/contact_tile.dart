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

  /// The style of the title text. If null the default style is used.
  final TextStyle titleStyle;

  /// The style of the subtitle text. If null the default style is used.
  final TextStyle subtitleStyle;

  /// Creates a contact tile.
  ///
  /// A contact tile has a [title] that has a [titleStyle] and [subtitle] that
  /// has a [subtitleStyle]. If the tile [hasDecoration] it is painted with [thickness]
  /// width.
  /// If a [namedRoute] is provided, when tapped, this tile will navigate to
  /// the page defined by the [namedRoute]
  /// and pass its [arguments], if given, to that page.
  /// The [arguments] would be the information for this contact.
  /// If a [tapFunc] is provided, the tile will execute that function when tapped.
  /// **Either one [tapFunc] or one [namedRoute] must be passed, not both.**
  ContactTile({
    Key key,
    @required this.title,
    @required this.subtitle,
    this.namedRoute,
    this.tapFunc,
    this.arguments,
    this.titleStyle,
    this.subtitleStyle,
  })  : assert((namedRoute == null && tapFunc != null) ||
            (namedRoute != null && tapFunc == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var tStyle = titleStyle ?? Theme.of(context).textTheme.subtitle1;
    var sStyle = subtitleStyle ?? Theme.of(context).textTheme.caption;

    return Card(
      elevation: 2.0,
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
          style: tStyle,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: sStyle,
        ),
        trailing: Icon(Icons.chevron_right, color: Theme.of(context).accentColor),
      ),
    );
  }
} // ContactTile definition
