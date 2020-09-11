import UIKit
import Flutter
import Contacts
import Foundation
import ContactsUI
import GoogleMaps

public class NativeContact: NSObject, CNContactViewControllerDelegate{

    private(set) var displayName: String
    private(set) var note: String
	private(set) var email: String
	private(set) var phones: Array<NativeContactPhone>
	private(set) var website: String
    
    init( map:
    [String : Any]
    ) {
        self.displayName = map["displayName"] as? String ?? ""
        self.note = map["note"] as? String ?? ""
        self.email = map["email"] as? String ?? ""
        self.website = map["website"] as? String ?? ""
        self.phones = [NativeContactPhone]()
        if let phones = map["phones"] as? [[String:String]]{
            for phone in phones{
                self.phones.append(NativeContactPhone(map:phone))
            }
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

        if #available(iOS 9.0, *){
        for phone in phones {
            var cnphone : CNLabeledValue<CNPhoneNumber> = CNLabeledValue(
                label: phone.label,
                value: CNPhoneNumber(stringValue: phone.number)
            )
            phoneNumbers.append(cnphone)            
        }}

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
            vc.present(navigation, animated:true, completion: nil)
        
        
    }
    
    class NativeContactPhone {
        private(set) var label: String
        private(set) var number: String 

		/**
		 * Creates an instance of NativeContactPhone.
		 *
		 * map A map object passed from the NativeContact constructor from the invoke
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
 

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let contactsChannel = FlutterMethodChannel(name: "com.example.fst_app_flutter/native",
                                              binaryMessenger: controller.binaryMessenger)
    contactsChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
  // Note: this method is invoked on the UI thread.
  guard call.method == "saveNatively" else {
    result(FlutterMethodNotImplemented)
    return
  }
    if let args = call.arguments as? [String:Any] {
        var contact = NativeContact(map:args)
        contact.saveNatively()
    }
  }) 
    GMSServices.provideAPIKey("AIzaSyC8crEFAO6MSNJMRK1lmo-WnSL7RLFu87w")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}