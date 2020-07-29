import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/local_widgets/contact_widgets.dart';
import 'package:fst_app_flutter/utils/open_url.dart';
import 'package:fst_app_flutter/screens/contact_screen/local_widgets/contact_detail_image.dart';

class ContactDetailPage extends StatelessWidget {
  static const routeName = '/contactDetail';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final dynamic contactDetails = ModalRoute.of(context).settings.arguments;
    final ContactCard contactMethods =
        _contactDetailList(contactDetails, mq, context);
    final ContactCard contactInfo = _aboutContactList(contactDetails, mq);

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            //TODO: investigate: are these actions feasible?
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.share,
                      color: Theme.of(context).iconTheme.color),
                  onPressed: null),
              IconButton(
                  icon: Icon(Icons.save,
                      color: Theme.of(context).iconTheme.color),
                  onPressed: null)
            ],
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
    ));
  }

  ContactCard _contactDetailList(
      final dynamic data, final MediaQueryData mq, BuildContext context) {
    List<dynamic> phoneNums =
        List<dynamic>.generate(data['phone_contact_set'].length, (i) {
      var icon;
      if (data['phone_contact_set'][i]['platforms'] == 'WHATSAPP') {
        icon = Image.asset(
          'assets/images/contact/WhatsApp_flat.png',
          width: IconTheme.of(context).size,
        );
        return ListTile(
            leading: icon,
            onTap: () =>
                openUrl('tel:' + data['phone_contact_set'][i]['phone']),
            title: Text(data['phone_contact_set'][i]['phone']));
      } else {
        icon = Icon(Icons.phone);
        return ListTile(
            leading: icon,
            onTap: () =>
                openUrl('tel:' + data['phone_contact_set'][i]['phone']),
            title: Text(data['phone_contact_set'][i]['phone']));
      }
    });

    List<dynamic> iconifiedList = [
      ...phoneNums,
      phoneNums.length > 0 ? Divider() : null,
      data['email'] != ''
          ? ListTile(
              leading: Icon(Icons.email),
              title: Text(data['email']),
              onTap: () => openUrl('mailto:' + data['email']),
            )
          : null,
      data['fax'] != '' ? Divider() : null,
      data['fax'] != ''
          ? ListTile(
              leading: Icon(Icons.print),
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

  ContactCard _aboutContactList(final dynamic data, final MediaQueryData mq) {
    List<dynamic> iconifiedList;
    if (data['website'] != '' || data['description'] != '') {
      iconifiedList = [
        ListTile(title: Text("About ${data['name']}")),
        data['website'] != '' ? Divider() : null,
        data['website'] != ''
            ? ListTile(
                onTap: () => openUrl(data['website']),
                title: Text('Website'),
                subtitle: Text(data['website']),
                trailing: Icon(Icons.chevron_right),
              )
            : null,
        data['description'] != '' ? Divider() : null,
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
