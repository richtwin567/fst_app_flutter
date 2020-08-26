package com.example.fst_app_flutter;


import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.provider.ContactsContract;

import java.util.ArrayList;
import java.util.HashMap;


/**
 * Contacts class for saving using the native Contacts UI
 */
@SuppressWarnings("unchecked")
public class NativeContact {

	private String displayName;
	private String note;
	private String email;
	private ArrayList<NativeContactPhone> phones;
	private String website;

	/**
	 * Creates an instance of NativeContact
	 *
	 * @param map a Map object passed in from dart saveNatively method in
	 *            *                  contact_model.dart
	 */
	NativeContact(HashMap<String, Object> map) {
		this.displayName = (String) map.get("displayName");
		this.email = (String) map.get("email");
		this.note = (String) map.get("note");
		this.website = (String) map.get("website");
		this.phones = new ArrayList<>();

		try {
			ArrayList<HashMap<String, String>> tempPhoneList = (ArrayList<HashMap<String, String>>) map.get(
					"phones");
			if (tempPhoneList != null) {
				for (HashMap<String, String> phone : tempPhoneList) {
					this.phones.add(new NativeContactPhone(phone));

				}
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		}


	}

	/**
	 * Opens the native contact form with this contact's data pre-loaded in their respective fields.
	 * @param context The context from which to start the activity
	 */
	public void saveNatively(Context context) {
		Intent intent = new Intent(ContactsContract.Intents.Insert.ACTION);

		//Log.d("flutter-plugin", displayName);
		ArrayList<ContentValues> dataList = new ArrayList<>();

		//Log.d("email", getEmail());
		ContentValues row = new ContentValues();
		row.put(ContactsContract.Data.MIMETYPE,
		        ContactsContract.CommonDataKinds.Email.CONTENT_ITEM_TYPE);
		row.put(ContactsContract.CommonDataKinds.Email.ADDRESS, getEmail());
		row.put(ContactsContract.CommonDataKinds.Email.TYPE,
		        ContactsContract.CommonDataKinds.Email.TYPE_WORK);
		dataList.add(row);


		for (NativeContactPhone phone : getPhones()) {
			//Log.d("phone", phone.getNumber());
			row = new ContentValues();
			row.put(ContactsContract.Data.MIMETYPE,
			        ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE);
			row.put(ContactsContract.CommonDataKinds.Phone.NUMBER, phone.getNumber());
			row.put(ContactsContract.CommonDataKinds.Phone.TYPE, phone.getLabel());
			dataList.add(row);
		}

		//Log.d("website", getWebsite());
		row = new ContentValues();
		row.put(ContactsContract.Data.MIMETYPE,
		        ContactsContract.CommonDataKinds.Website.CONTENT_ITEM_TYPE);
		row.put(ContactsContract.CommonDataKinds.Website.URL, getWebsite());
		row.put(ContactsContract.CommonDataKinds.Website.TYPE,
		        ContactsContract.CommonDataKinds.Website.TYPE_WORK);
		dataList.add(row);

		intent.setType(ContactsContract.RawContacts.CONTENT_TYPE);

		intent.putExtra(ContactsContract.Intents.Insert.NAME, getDisplayName());
		intent.putParcelableArrayListExtra(ContactsContract.Intents.Insert.DATA,
		                                   dataList);
		intent.putExtra(ContactsContract.Intents.Insert.NOTES, getNote());


		intent.putExtra("finishActivityOnSaveCompleted", true);
		context.startActivity(intent);

	}


	/**
	 * Gets this contact's display name / full name
	 *
	 * @return The display name for this contact
	 */
	public String getDisplayName() {
		return displayName;
	}

	/**
	 * Gets the notes for this contact.
	 *
	 * @return the note for this contact
	 */
	public String getNote() {
		return note;
	}

	/**
	 * Gets the email address for this contact
	 *
	 * @return the email for this contact
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Gets the website for this contact.
	 *
	 * @return the website for this contact.
	 */
	public String getWebsite() {
		return website;
	}

	/**
	 * Gets the list of phone numbers for this contact.
	 *
	 * @return The list of phone numbers for this contact.
	 */
	public ArrayList<NativeContactPhone> getPhones() {
		return phones;
	}

	/**
	 * The class to manage phone numbers for NativeContact.
	 */
	private static class NativeContactPhone {

		private int label;
		private String number;

		/**
		 * Creates an instance of NativeContactPhone.
		 *
		 * @param map A map object passed from the NativeContact constructor from the invoke
		 *            method call arguments passed in dart saveNatively method in
		 *            contact_model.dart.
		 */
		NativeContactPhone(HashMap<String, String> map) {
			this.number = map.get("value");
			String strLabel = map.get("label");
			if (strLabel != null) {
				if ("fax work".equals(strLabel)) {
					this.label = ContactsContract.CommonDataKinds.Phone.TYPE_FAX_WORK;
				} else {
					this.label = ContactsContract.CommonDataKinds.Phone.TYPE_WORK;
				}
			}
		}

		/**
		 * GGets the phone label.
		 *
		 * @return The label / type of phone number for this phone number. This integer represents
		 * an enum value from ContactsContract.CommonDataKinds.Phone.
		 */
		public int getLabel() {
			return label;
		}

		/**
		 * Gets the phone number.
		 *
		 * @return The phone number for this contact.
		 */
		public String getNumber() {
			return number;
		}


	}


}