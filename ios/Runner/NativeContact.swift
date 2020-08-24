import UIKit
import Contacts
import Foundation
import ContactsUI
import Flutter

public class NativeContact: NSObject {

    private(set) var displayName: String
    private(set) var note: String
	private(set) var email: String
	private(set) var phones: Array<NativeContactPhone>
	private(set) var website: String
    
    init( map:
    [String : Any]
    ) {
        self.displayName = map["displayName"] as! String
        self.note = map["note"] as! String
        self.email = map["email"] as! String
        self.website = map["website"] as! String
        self.phones = [NativeContactPhone]()
        for phone in map["phones"] as! [[String:String]]{
            self.phones.append(NativeContactPhone(map:phone))
        }
    }

    func saveNatively() {
        let contact = CNMutableContact.init()

        let nameParts: [String] = displayName.components(separatedBy: " ")

        if nameParts.count == 2 {
            contact.givenName = nameParts[0]
            contact.familyName = nameParts[1]
        }
        if nameParts.count == 3 {
            contact.namePrefix = nameParts[0]
            contact.givenName = nameParts[1]
            contact.familyName = nameParts[2]
        }
        if nameParts.count == 4 {
            contact.namePrefix = nameParts[0]
            contact.givenName = nameParts[1]
            contact.middleName = nameParts[2]
            contact.familyName = nameParts[3]
        }

        contact.note = note

        var phoneNumbers : [CNLabeledValue<CNPhoneNumber>] = []

        for phone in phones {
            var cnphone : CNLabeledValue<CNPhoneNumber> = CNLabeledValue(
                label: phone.label,
                value: CNPhoneNumber(stringValue: phone.number)
            )
            phoneNumbers.append(cnphone)            
        }

        contact.phoneNumbers = phoneNumbers 

        var emails: [CNLabeledValue<NSString>] = [] 

        emails.append(CNLabeledValue(
            label: CNLabelWork,
            value: email as NSString
        ))

        contact.emailAddresses = emails

        var websites: [CNLabeledValue<NSString>] = []
        websites.append(CNLabeledValue(
            label: CNLabelOther,
            value: website as NSString
        ))

        contact.urlAddresses = websites

            let vc = CNContactViewController(forNewContact: contact)
            vc.delegate = self
            //vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain,target: self, action: #selector(self.cancelContactForm))            
            //vc.view.layoutIfNeeded()
            let navigation = UINavigationController(rootViewController: vc)
            /* var rvc = UIApplication.shared.keyWindow?.rootViewController
            while let nextView = rvc?.presentedViewController {
                rvc = nextView
            } */
            self.present(navigation, animated:true, completion: nil)
        
        
    }
    
    class NativeContactPhone {
        private(set) var label: String
        private(set) var number: String 

		/**
		 * Creates an instance of NativeContactPhone.
		 *
		 * @param map A map object passed from the NativeContact constructor from the invoke
		 *            method call arguments passed in dart saveNatively method in
		 *            contact_model.dart.
		 */
		init(map:[String: String]) {
			self.number = map["number"]!
			let strLabel:String = map["label"]! 
			if "fax work" == strLabel {
				self.label = CNLabelPhoneNumberWorkFax
			} else {
				self.label = CNLabelPhoneNumberMain
			}
		}
        
    }

}