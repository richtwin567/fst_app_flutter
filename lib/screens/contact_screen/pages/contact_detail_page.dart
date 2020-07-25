import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/local_widgets/contact_widgets.dart';
import 'package:fst_app_flutter/utils/open_url.dart';
import 'package:fst_app_flutter/screens/contact_screen/local_widgets/contact_detail_image.dart';

class ContactDetailPage extends StatelessWidget {
  static const routeName = '/contactDetail';

  @override
  Widget build(BuildContext context) {
    final dynamic contactDetails = ModalRoute.of(context).settings.arguments;
    final ContactCard contactMethods = _contactDetailList(contactDetails);
    final ContactCard contactInfo = _aboutContactList(contactDetails);
    final mq = MediaQuery.of(context);
    print(mq.size.height / 2);
    print(mq.size.width / 2);
    print(mq.size.aspectRatio);
    print(mq.devicePixelRatio);
    print(mq);

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            //TODO: investigate: are these actions feasible?
            actions: <Widget>[
              IconButton(icon: Icon(Icons.share), onPressed: null),
              IconButton(icon: Icon(Icons.save), onPressed: null)
            ],
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: mq.size.height/3.5 ,
            flexibleSpace: FlexibleSpaceBar(
                background: CustomPaint(
                    painter: ContactDetailSvg(
                        offsetX: mq.size.width / mq.devicePixelRatio,
                        offsetY: (mq.size.height/mq.devicePixelRatio)/3.5,
                        scale: (mq.devicePixelRatio/ mq.size.aspectRatio),
                        color: Colors.blue[800])),
                title: Padding(
                  padding: EdgeInsets.only(right: 70.0),
                  child: Text(
                    contactDetails['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))),
        SliverFillRemaining(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.down,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              Expanded(
                  flex: 1,
                  child: ListView(
                      children: <Widget>[contactMethods, contactInfo])),
            ]))
      ],
    ));
  }

  ContactCard _contactDetailList(final dynamic data) {
    List<dynamic> phoneNums =
        List<dynamic>.generate(data['phone_contact_set'].length, (i) {
      Icon icon =
          i == 0 ? Icon(Icons.phone) : Icon(Icons.phone, color: Colors.white);
      return ListTile(
          leading: icon,
          onTap: () => openUrl('tel:' + data['phone_contact_set'][i]['phone']),
          title: Text(data['phone_contact_set'][i]['phone']));
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
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[...iconifiedList],
        ));
  }

  ContactCard _aboutContactList(final dynamic data) {
    List<dynamic> iconifiedList;
    if (data['website'] != '' || data['description'] != '') {
      iconifiedList = [
        ListTile(title: Text('About')),
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
                title: Text('Description'),
                subtitle: Text(data['description']),
                isThreeLine: true,
              )
            : null,
      ];

      iconifiedList.removeWhere((element) => element == null);

      return ContactCard(
          margin: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 25.0),
          child: Column(
            children: <Widget>[...iconifiedList],
          ));
    } else {
      return ContactCard(child: Column());
    }
  }
}
