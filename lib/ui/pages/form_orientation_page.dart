// ignore_for_file: prefer_const_constructors

part of 'pages.dart';

class FormOrientationPage extends StatefulWidget {
  final Patient? patient;
  final OrientationPainful? old;
  const FormOrientationPage({Key? key, this.patient, this.old})
      : super(key: key);

  @override
  _FormOrientationPageState createState() => _FormOrientationPageState();
}

class _FormOrientationPageState extends State<FormOrientationPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController pController = TextEditingController();
  TextEditingController qController = TextEditingController();
  TextEditingController rController = TextEditingController();
  TextEditingController sController = TextEditingController();
  TextEditingController tController = TextEditingController();
  TextEditingController managementController = TextEditingController();

  @override
  void initState() {
    if (widget.old != null) {
      pController.text = widget.old!.p;
      qController.text = widget.old!.q;
      rController.text = widget.old!.r;
      sController.text = widget.old!.s;
      tController.text = widget.old!.t;
      managementController.text = widget.old!.management;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengkajian Nyeri',
          style: TextStyle(
            fontSize: 18,
            color: Constants.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showPedoman(context);
            },
            icon: Icon(Icons.info_outline_rounded),
            color: Constants.primary,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: TimeInHourAndMinute()),
                SizedBox(height: 20),
                TextFormField(
                  controller: pController,
                  decoration:
                      decorationForm.copyWith(labelText: 'P (Penyebab)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: qController,
                  decoration:
                      decorationForm.copyWith(labelText: 'Q (Kualitas)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: rController,
                  decoration:
                      decorationForm.copyWith(labelText: 'R (Penyebaran)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: sController,
                  decoration: decorationForm.copyWith(labelText: 'S (Skala)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: tController,
                  decoration: decorationForm.copyWith(labelText: 'T (Waktu)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                TextFormField(
                  controller: managementController,
                  decoration: decorationForm.copyWith(
                      labelText: 'Manajemen Pengkajian'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: MaterialButton(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Constants.primary,
          height: 60,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Provider.of<OrientationProvider>(context, listen: false)
                  .saveDataOrientation(
                patient: widget.patient,
                oldData: widget.old,
                newData: OrientationPainful(
                    p: pController.text,
                    q: qController.text,
                    r: rController.text,
                    s: sController.text,
                    t: tController.text,
                    management: managementController.text),
              );
              Navigator.pop(context);
            }
          },
          child: Text(
            'Simpan Data',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
