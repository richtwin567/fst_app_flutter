import 'package:flutter/material.dart';
import 'package:fst_app_flutter/global_const.dart';

enum Department { CHEM, COMP, GEO, LIFE, MATH, PHYS, OTHER }

extension DepartmentExt on Department {
  String toShortString() {
    return this.toString().split('.').last;
  }

  Color get departmentColour {
    switch (this) {
      case Department.CHEM:
        return CHEM_COLOUR;
        break;
      case Department.COMP:
        return COMP_COLOUR;
        break;
      case Department.GEO:
        return GEO_COLOUR;
        break;
      case Department.LIFE:
        return LIFE_SCI_COLOUR;
        break;
      case Department.MATH:
        return MATH_COLOUR;
        break;
      case Department.PHYS:
        return PHYS_COLOUR;
        break;
      case Department.OTHER:
        return Colors.grey;
        break;
      default:
        return Colors.grey;
        break;
    }
  }
}
