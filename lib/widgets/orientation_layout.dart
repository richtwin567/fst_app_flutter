import 'package:flutter/material.dart';
import 'package:fst_app_flutter/widgets/responsive_builder.dart';

class OrientationLayout extends StatelessWidget {
  final Widget Function(BuildContext context) landscape;
  final Widget Function(BuildContext context) portrait;

  const OrientationLayout({
    Key key,
    this.landscape,
    @required this.portrait,
  })  : assert(portrait != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.orientation == Orientation.landscape) {
          if (landscape != null) {
            return landscape(context);
          }
        }

        return portrait(context);
      },
    );
  }
}
