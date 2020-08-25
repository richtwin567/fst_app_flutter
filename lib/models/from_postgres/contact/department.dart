enum Department { CHEM, COMP, GEO, LIFE, MATH, PHYS, OTHER }

extension DepartmentShortString on Department {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
