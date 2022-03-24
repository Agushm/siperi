part of 'models.dart';

class Patient {
  Patient({
    required this.noRm,
    required this.pasien,
    required this.perawat,
    required this.orientations,
  });
  late final String noRm;
  late final String pasien;
  late final String perawat;
  late final List<OrientationPainful> orientations;

  Patient.fromJson(Map<String, dynamic> json) {
    noRm = json['no_rm'];
    pasien = json['pasien'];
    perawat = json['perawat'];
    orientations = List.from(json['orientations'])
        .map((e) => OrientationPainful.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['no_rm'] = noRm;
    _data['pasien'] = pasien;
    _data['perawat'] = perawat;
    _data['orientations'] = orientations.map((e) => e.toJson()).toList();
    return _data;
  }
}
