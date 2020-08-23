enum ContactType { EMERGENCY, OFFICE, FACULTY_STAFF, OTHER }

extension ContactTypeShortString on ContactType {
  String asString() {
    return this.toString().split('.').last;
  }
}