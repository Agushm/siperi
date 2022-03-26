part of 'pages.dart';

class PatientOrientationsPage extends StatefulWidget {
  final Patient? patient;
  const PatientOrientationsPage(this.patient, {Key? key}) : super(key: key);

  @override
  State<PatientOrientationsPage> createState() =>
      _PatientOrientationsPageState();
}

class _PatientOrientationsPageState extends State<PatientOrientationsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrientationProvider>(builder: (context, prov, _) {
      return Scaffold(
        backgroundColor: Constants.grey,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: EdgeInsets.fromLTRB(10, 35, 10, 20),
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
              child: Column(
                children: [
                  _detailData(context,
                      title: 'No.RM', content: widget.patient!.noRm),
                  _detailData(context,
                      title: 'Nama Pasien', content: widget.patient!.pasien),
                  _detailData(context,
                      title: 'Nama Perawat', content: widget.patient!.perawat),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: deviceHeight(context) - (deviceHeight(context) / 4),
              ),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
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
                            "P (Penyebab)",
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "Q (Kualitas)",
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "R (Penyebaran)",
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "S (Skala)",
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "T (Waktu)",
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "Manajemen Neri",
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "Ket. Manajemen Neri",
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "Dibuat",
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "Pengkajian Ulang",
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
                    rows: prov.orientationsByUserId(widget.patient!.userId).map(
                      (data) {
                        // var lastPasien = prov.lastPasien();
                        // int index = prov.pasien.indexOf(data);
                        return DataRow(
                            // color: lastPasien == data
                            //     ? MaterialStateColor.resolveWith(
                            //         (states) => Colors.red[200]!)
                            //     : MaterialStateColor.resolveWith(
                            //         (states) => Colors.transparent),
                            onLongPress: () {},
                            cells: [
                              DataCell(
                                Text(data.p),
                              ),
                              DataCell(
                                Text(data.q),
                              ),
                              DataCell(
                                Text(data.r),
                              ),
                              DataCell(
                                Text(data.s.toString()),
                              ),
                              DataCell(
                                Text(data.t),
                              ),
                              DataCell(
                                Text(data.management),
                              ),
                              DataCell(
                                Text(data.ketManagement),
                              ),
                              DataCell(
                                Text(
                                  formatDate.format(data.createdAt),
                                ),
                              ),
                              DataCell(
                                Text(
                                  formatDate.format(data.release),
                                ),
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
                                                    FormOrientationPage(
                                                        patient: widget.patient,
                                                        old: data)));
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(Icons.edit,
                                              color: Colors.white, size: 12),
                                          SizedBox(width: 5),
                                          Text(
                                            'Edit',
                                            style:
                                                TextStyle(color: Colors.white),
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
                                          prov.deleteDataOrientation(
                                              data: data);
                                        }
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(Icons.close,
                                              color: Colors.white, size: 12),
                                          SizedBox(width: 5),
                                          Text(
                                            'Hapus',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]);
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(color: Colors.white),
          child: MaterialButton(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              color: Constants.primary,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormOrientationPage(
                            patient: widget.patient,
                          )),
                );
              },
              child: Text('Mulai Pengkajian',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500))),
        ),
      );
    });
  }
}

Widget _detailData(BuildContext context,
    {String? title, String? content, FontWeight? fontWeight}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title!,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      Container(
        width: deviceWidth(context) / 2,
        alignment: Alignment.centerRight,
        child: Text(
          content!,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: fontWeight ?? FontWeight.w300),
        ),
      ),
    ],
  );
}
