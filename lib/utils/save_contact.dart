import 'package:flutter_contact/contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contact/contact.dart';

saveContact(Map<String, Object> contactMap) async {
  if (await Permission.contacts.request().isGranted) {
    Contact c = Contact.fromMap(contactMap, ContactMode.single);
    print(c.displayName);
    print(c.identifier);
    await Contacts.openContactInsertForm(c);

    /* ContactsService.getContacts().then((value) => value.forEach((e) {
          print(e.displayName+' --- '+ e.identifier+
              ' --- ' +
              e.androidAccountName +
              ' --- ' +
              e.androidAccountTypeRaw);
        })); */
    //ContactsService.openExistingContact(Contact.fromMap(contactMap));
    //ContactsService.openContactForm();
    print('hi');
  }
}
