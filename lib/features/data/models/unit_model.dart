import 'package:mobileapp/features/domain/entities/unit.dart';

class UnitModel extends Unit {
  UnitModel({required super.unitID, required super.unitName});

  factory UnitModel.fromEntity(Unit unit) {
    return UnitModel(unitID: unit.unitID, unitName: unit.unitName);
  }

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(unitID: json["unitID"], unitName: json["unitName"]);
  }

  Map<String, dynamic> toJson() {
    return {"unitID": unitID, "unitName": unitName};
  }
}
