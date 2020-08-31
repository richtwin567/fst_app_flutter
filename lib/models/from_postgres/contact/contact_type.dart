enum ContactType { emergency, office, facultyStaff, other }

extension ContactTypeShortString on ContactType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
