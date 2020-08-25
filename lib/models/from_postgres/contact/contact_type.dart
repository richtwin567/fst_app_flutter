enum ContactType { EMERGENCY, OFFICE, FACULTY_STAFF, OTHER }

extension ContactTypeShortString on ContactType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}