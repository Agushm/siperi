// ignore_for_file: prefer_const_constructors

part of "providers.dart";

class PatientProvider extends ChangeNotifier {
  PatientProvider() {
    init();
  }
  void init() async {
    var local = await LocalStorage.instance.getData('patients');
    if (local != null) {
      List<Patient> load = [];
      var d = json.decode(local);
      d.forEach((e) {
        load.add(Patient.fromJson(e));
      });
      _patients = load;
      notifyListeners();
    }

    print("Patient: $local");
  }

  List<Patient> _patients = [];
  // List.generate(
  //   20,
  //   (index) => Patient(
  //     pasien: 'Pasien $index',
  //     perawat: 'Perawat $index',
  //     noRm: 'RM $index',
  //     orientations: List.generate(
  //       20,
  //       (index) => OrientationPainful(
  //           p: 'P $index',
  //           q: 'Q $index',
  //           r: 'R $index',
  //           s: 'S $index',
  //           t: 'T $index',
  //           management: 'Non Farmakologis'),
  //     ),
  //   ),
  // );
  List<Patient> get patients => _patients;

  void saveDataPatient(Patient? oldData, Patient? newData) {
    if (oldData == null) {
      _patients.add(newData!);
    } else {
      int index = _patients.indexOf(oldData);
      _patients[index] = newData!;
    }
    savePatientsToLocalStorage();
    notifyListeners();
  }

  void deleteDataPatient(Patient? data) {
    _patients.remove(data);
    savePatientsToLocalStorage();
    notifyListeners();
  }

  void savePatientsToLocalStorage() async {
    await LocalStorage.instance.saveData(
        'patients', json.encode(_patients.map((e) => e.toJson()).toList()));
  }
}
