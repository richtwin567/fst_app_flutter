import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/widgets/contact_card.dart';
import 'package:fst_app_flutter/utils/open_url.dart';
import 'package:fst_app_flutter/widgets/contact_detail_image.dart';

/// A page that shows all the details for the selected contact.
/// It allows the user to open websites, call the contact and send an email to
/// the contact directly from the app.
class ContactDetailPage extends StatelessWidget {
  /// The information [Map] for this contact
  final dynamic contactDetails;

  /// [contactDetails] is passed from [RouterSettings] in [Router.generateRoute]
  ContactDetailPage(this.contactDetails, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final ContactCard contactMethods =
        _contactDetailList(contactDetails, mq, context);
    final ContactCard contactInfo =
        _aboutContactList(contactDetails, mq, context);

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              floating: false,
              pinned: true,
              snap: false,
              expandedHeight: mq.size.height / 2.5,
              flexibleSpace: FlexibleSpaceBar(
                  background: CustomPaint(
                      painter: ContactDetailSvg(
                          start: Point(
                              mq.size.width / 2, (mq.size.height / 2.5) / 2),
                          scale:
                              (mq.devicePixelRatio / mq.size.aspectRatio) * 1.5,
                          color: Colors.blue[800])),
                  title: Padding(
                    padding: EdgeInsets.only(right: mq.size.width / 4),
                    child: Text(
                      contactDetails['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))),
          SliverList(
            delegate:
                SliverChildListDelegate.fixed([contactMethods, contactInfo]),
          )
        ],
      ),
    ));
  } // build

  /// Creates a [ContactCard] for the phone numbers, email address and
  /// fax number if applicable.
  ContactCard _contactDetailList(
      final dynamic data, final MediaQueryData mq, BuildContext context) {
    List<dynamic> phoneNums =
        List<dynamic>.generate(data['phone_contact_set'].length, (i) {
      var icon;
      if (data['phone_contact_set'][i]['platforms'] == 'WHATSAPP') {
        icon = Image.asset(
          'assets/WhatsApp_flat.png',
          width: IconTheme.of(context).size,
        );
        return ListTile(
            leading: icon,
            onTap: () =>
                openUrl('tel:' + data['phone_contact_set'][i]['phone']),
            title: Text(data['phone_contact_set'][i]['phone']));
      } else {
        icon = Icon(
          Icons.phone,
          color: Theme.of(context).accentColor,
        );
        return ListTile(
            leading: icon,
            onTap: () =>
                openUrl('tel:' + data['phone_contact_set'][i]['phone']),
            title: Text(data['phone_contact_set'][i]['phone']));
      }
    });

    List<dynamic> phoneNumsWithDivider = [];
    if (phoneNums.length > 1) {
      phoneNums.forEach((e) {
        phoneNumsWithDivider
            .addAll([e, Divider(indent: kMinInteractiveDimension + 24.0)]);
      });
      phoneNumsWithDivider.removeLast();
    } else {
      phoneNumsWithDivider.addAll(phoneNums);
    }

    List<dynamic> iconifiedList = [
      ...phoneNumsWithDivider,
      phoneNums.length > 0 ? Divider() : null,
      data['email'] != ''
          ? ListTile(
              leading: Icon(
                Icons.email,
                color: Theme.of(context).accentColor,
              ),
              title: Text(data['email']),
              onTap: () => openUrl('mailto:' + data['email']),
            )
          : null,
      data['fax'] != '' ? Divider() : null,
      data['fax'] != ''
          ? ListTile(
              leading: Icon(Icons.print, color: Theme.of(context).accentColor),
              title: Text(data['fax']),
              subtitle: Text('Fax'),
            )
          : null
    ];

    iconifiedList.removeWhere((element) => element == null);
    if (iconifiedList.length > 0) {
      if (iconifiedList.elementAt(iconifiedList.length - 1) is Divider)
        iconifiedList.removeAt(iconifiedList.length - 1);
    }

    return ContactCard(
        margin: EdgeInsets.fromLTRB(
            mq.size.width / 18, mq.size.height / 22, mq.size.width / 18, 0.0),
        child: Column(
          children: <Widget>[...iconifiedList],
        ));
  }

  /// Creates a [ContactCard] for the website and description if applicable.
  ContactCard _aboutContactList(
      final dynamic data, final MediaQueryData mq, BuildContext context) {
    List<dynamic> iconifiedList;
    if (data['website'] != '' || data['description'] != '') {
      iconifiedList = [
        ListTile(
            title: Text("About ${data['name']}",
                style: TextStyle(color: Theme.of(context).accentColor))),
        data['website'] != '' || data['description'] != '' ? Divider() : null,
        data['website'] != ''
            ? ListTile(
                onTap: () => openUrl(data['website']),
                title: Text('Website'),
                subtitle: Text(data['website']),
                trailing: Icon(Icons.chevron_right),
              )
            : null,
        data['website'] != ''
            ? Divider(
                indent: 16.0,
              )
            : null,
        data['description'] != ''
            ? ListTile(
                title: Text('Additional Info'),
                subtitle: Text(data['description']),
                isThreeLine: true,
              )
            : null,
      ];

      iconifiedList.removeWhere((element) => element == null);

      return ContactCard(
          margin: EdgeInsets.fromLTRB(mq.size.width / 18, mq.size.height / 22,
              mq.size.width / 18, mq.size.height / 22),
          child: Column(
            children: <Widget>[...iconifiedList],
          ));
    } else {
      return ContactCard(child: Column());
    }
  }
}
