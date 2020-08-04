import 'package:flutter/material.dart';
import 'package:fst_app_flutter/widgets/navigation_card.dart';

class CardContainerMobilePortrait extends StatelessWidget {
  final double height;
  final int columns;
  final List<NavigationCard> cards;
  final int itemPerColumn;

  const CardContainerMobilePortrait(
      {Key key,
      @required this.cards,
      this.height,
      @required this.columns,
      @required this.itemPerColumn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: containerContents,
    ));
  }

  List<Widget> get containerContents {
    List<Widget> content = List<Widget>();
    int counter = 0;
    for (int i = 0; i < columns; i++) {
      List<Widget> items = List<Widget>();
      for (int j = 0; j < itemPerColumn; j++) {
        if (counter >= cards.length) {
          break;
        }
        items.add(cards[counter]);

        counter++;
      }
      Widget col = Column(
        children: items,
      );
      content.add(col);
    }
    return content;
  }
}
