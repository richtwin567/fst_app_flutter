import 'package:flutter/material.dart';
import 'package:fst_app_flutter/global_const.dart';

// TODO: document Department @richtwin567
enum Department { biochem, chem, comp, geo, life, math, phys, other }

extension DepartmentExt on Department {
  String toShortString() {
    return this.toString().split('.').last;
  }

  Color get departmentColour {
    switch (this) {
      case Department.biochem:
        return biochemColour;
        break;
      case Department.chem:
        return chemColour;
        break;
      case Department.comp:
        return compColour;
        break;
      case Department.geo:
        return geoColour;
        break;
      case Department.life:
        return lifeSciColour;
        break;
      case Department.math:
        return mathColour;
        break;
      case Department.phys:
        return physColour;
        break;
      case Department.other:
        return Colors.grey;
        break;
      default:
        return Colors.grey;
        break;
    }
  }
}
