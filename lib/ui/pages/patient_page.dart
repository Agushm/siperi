part of 'pages.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({Key? key}) : super(key: key);

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SiPeRi',
              style: TextStyle(
                  fontSize: 18,
                  color: Constants.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            Text(
              'Aplikasi Sistem Pengkajian Nyeri',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<OrientationProvider>(
        builder: (context, prov, _) {
          return Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  blurRadius: 1,
                  spreadRadius: 1,
                )
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: commonTable(
                  columns: [
                    DataColumn(
                      label: Center(
                        child: Text(
                          "No RM",
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Nama Pasien",
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Nama Perawat",
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Opsi",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                  rows: prov.patients.map((data) {
                    // var lastPasien = prov.lastPasien();
                    // int index = prov.pasien.indexOf(data);
                    return DataRow(
                        // color: lastPasien == data
                        //     ? MaterialStateColor.resolveWith(
                        //         (states) => Colors.red[200]!)
                        //     : MaterialStateColor.resolveWith(
                        //         (states) => Colors.transparent),
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PatientOrientationsPage(data),
                            ),
                          );
                        },
                        cells: [
                          DataCell(
                            Text(data.noRm),
                          ),
                          DataCell(
                            Text(data.pasien),
                          ),
                          DataCell(
                            Text(data.perawat),
                          ),
                          DataCell(
                            Row(
                              children: [
                                MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                FormPatientPage(old: data)));
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit,
                                          color: Colors.white, size: 12),
                                      SizedBox(width: 5),
                                      Text(
                                        'Edit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5),
                                MaterialButton(
                                  color: Colors.red,
                                  onPressed: () async {
                                    var confirm = await DialogUtils.instance
                                        .showConfirmDialog(
                                            context,
                                            'Hapus Kategori',
                                            'Anda yakin ingin menghapus data ini?');
                                    if (confirm!) {
                                      prov.deleteDataPatient(data);
                                    }
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.close,
                                          color: Colors.white, size: 12),
                                      SizedBox(width: 5),
                                      Text(
                                        'Hapus',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]);
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primary,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPatientPage()),
          );
        },
        child: Icon(Icons.person_add, color: Colors.white, size: 25),
      ),
    );
  }
}
