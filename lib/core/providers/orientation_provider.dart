// ignore_for_file: prefer_const_constructors

part of "providers.dart";

class OrientationProvider extends ChangeNotifier {
  OrientationProvider() {
    init();
  }
  void init() async {
    var local = await LocalStorage.instance.getData('orientations');
    if (local != null) {
      List<OrientationPainful> load = [];
      var d = json.decode(local);
      d.forEach((e) {
        load.add(OrientationPainful.fromJson(e));
      });
      _orientations = load;
      addPendingAlarm();
    }

    print("Orientations: $local");
  }

  List<OrientationPainful> _orientations = [];

  List<OrientationPainful> get orientations => _orientations;

  String? lastAlarmPatient() {
    List<OrientationPainful> _load = [];
    _orientations.forEach((e) async {
      var isBefore = e.release.isBefore(DateTime.now());
      if (isBefore) {
        _load.add(e);
      }
    });
    if (_load.isEmpty) {
      return null;
    }
    _load.sort((a, b) => a.release.compareTo(b.release));
    return _load.last.userId;
  }

  List<OrientationPainful> orientationsByUserId(String userId) {
    return _orientations.where((e) => e.userId == userId).toList();
  }

  void saveDataOrientation({
    OrientationPainful? oldData,
    OrientationPainful? newData,
  }) {
    if (oldData == null) {
      _orientations.add(newData!);
    } else {
      int index = _orientations.indexOf(oldData);
      _orientations[index] = newData!;
    }
    saveOrientationsToLocalStorage();
    notifyListeners();
  }

  void deleteDataOrientation({OrientationPainful? data}) {
    _orientations.remove(data!);
    saveOrientationsToLocalStorage();
    notifyListeners();
  }

  void saveOrientationsToLocalStorage() async {
    await LocalStorage.instance.saveData('orientations',
        json.encode(_orientations.map((e) => e.toJson()).toList()));
    addPendingAlarm();
  }

  Future addPendingAlarm() async {
    _orientations.forEach((e) async {
      int index = _orientations.indexOf(e);
      var isAfter = e.release.isAfter(DateTime.now());
      if (isAfter) {
        await _addScheduledAlarm(index, e);
      }
      print('Orientation Selisih isBefore=${isAfter}');
    });
  }

  Future _addScheduledAlarm(int index, OrientationPainful data) async {
    AndroidAlarmManager.oneShotAt(data.release, index, showNotifOrientation,
        alarmClock: true, allowWhileIdle: true, wakeup: true);
  }
}

void showNotifOrientation() async {
  final DateTime now = DateTime.now();

  final Int64List vibrationPattern = Int64List(4);
  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your other channel id',
    'your other channel name',
    channelDescription: 'your other channel description',
    sound: RawResourceAndroidNotificationSound('ringtone'),
    enableVibration: true,
    importance: Importance.max,
    priority: Priority.high,
    vibrationPattern: vibrationPattern,
  );

  LocalNotification.flutterLocalNotificationsPlugin.show(
    0,
    'Waktunya Pengkajian Nyeri Ulang',
    '${DateFormat('EEEE, dd-MM-yyyy HH:mm WIB', 'id_ID').format(now)}',
    NotificationDetails(android: androidPlatformChannelSpecifics),
  );
}
