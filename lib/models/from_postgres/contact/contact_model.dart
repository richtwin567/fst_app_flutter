import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_contact/contact.dart';
import 'package:fst_app_flutter/models/from_postgres/contact/contact_type.dart';
import 'package:fst_app_flutter/models/from_postgres/contact/department.dart';
import 'package:fst_app_flutter/models/from_postgres/contact/platform.dart';

class Contact {
  int _id;
  String _name;
  String _website;
  String _email;
  String _fax;
  String _description;
  Department _department;
  ContactType _contactType;
  List<_PhoneNumber> _phones;

  int get id => _id;

  String get name => _name;

  String get website => _website;

  String get email => _email;

  String get fax => _fax;

  String get description => _description;

  Department get department => _department;

  ContactType get contactType => _contactType;

  List<_PhoneNumber> get phones => _phones;

  Contact(dynamic contact) {
    List<_PhoneNumber> phones =
        List.generate(contact['phone_contact_set'].length, (i) {
      return _PhoneNumber(contact['phone_contact_set'][i]);
    });
    Department department;
    switch (contact['department']) {
      case 'CHEM':
        department = Department.CHEM;
        break;
      case 'COMP':
        department = Department.COMP;
        break;
      case 'GEO':
        department = Department.GEO;
        break;
      case 'LIFE':
        department = Department.LIFE;
        break;
      case 'MATH':
        department = Department.MATH;
        break;
      case 'PHYS':
        department = Department.PHYS;
        break;
      default:
        department = Department.OTHER;
        break;
    }
    ContactType contactType;
    switch (contact['contact_type']) {
      case 'EMERGENCY':
        contactType = ContactType.EMERGENCY;
        break;
      case 'OFFICE':
        contactType = ContactType.OFFICE;
        break;
      case 'FACULTY_STAFF':
        contactType = ContactType.FACULTY_STAFF;
        break;
      default:
        contactType = ContactType.OTHER;
        break;
    }
    _id = contact['id'];
    _name = contact['name'];
    _website = contact['website'];
    _email = contact['email'];
    _fax = contact['fax'];
    _description = contact['description'];
    _department = department;
    _contactType = contactType;
    _phones = phones;
  }

  Map<String, Object> toNativeMap() {
    int id = Random().nextInt(9999);
    return {
      //'identifier': id.toString(),
      "displayName": name,
      'givenName': name.split(' ')[1],
      'middleName': name.split(' ').length == 4 ? _name.split(' ')[2] : '',
      'familyName': name.split(' ').length == 4
          ? name.split(' ')[3]
          : name.split(' ')[2],
      'prefix': name.split(' ')[0],
      'suffix': '',
      'company': '',
      'jobTitle': '',
      'avatar': Uint8List(0),
      'note': description,
      "linkedContactIds": <String>[],
      'dates': <ContactDate>[],
      'emails': email != ''
          ? <Map>[
              {'label': 'work', 'value': email}
            ]
          : <Map>[],
      'phones': List<Map>.generate(phones.length,
          (i) => {'label': 'work', 'value': phones[i].phone})..addAll(List<Map>.generate(fax!= ''?1:0, (i) => {'label':'fax work', 'value':fax})),
      "socialProfiles": <Map>[],
      'postalAddresses': <PostalAddress>[],
      "urls": website != ''
          ? <Map>[
              {'label': 'website', 'value': website}
            ]
          : <Map>[],
      //"unifiedContactId": id.toString(),
      //"singleContactId": id.toString(),
      "otherKeys": {},
      "label": '',
      "date": DateTime.now().toIso8601String(),
      "lastModified": DateTime.now().toIso8601String(),
      "street": '',
      "city": '',
      "postcode": '',
      "region": '',
      "country": '',
      'keys': ContactKeys.empty(ContactMode.single)
    };
  }
}

class _PhoneNumber {
  int _id;
  int _contactID;
  String _phone;
  Platform _platforms;

  int get id => _id;
  int get contactID => _contactID;
  String get phone => _phone;
  Platform get platforms => _platforms;

  _PhoneNumber(dynamic phoneSet) {
    Platform platform;
    switch (phoneSet['platforms']) {
      case 'WHATSAPP':
        platform = Platform.WHATSAPP;
        break;
      default:
        platform = Platform.TEXT_CALL;
        break;
    }
    _id = phoneSet['id'];
    _contactID = phoneSet['contact'];
    _phone = phoneSet['phone'];
    _platforms = platform;
  }
}
