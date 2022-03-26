// ignore_for_file: prefer_const_constructors

part of 'pages.dart';

class FormPatientPage extends StatefulWidget {
  final Patient? old;
  const FormPatientPage({Key? key, this.old}) : super(key: key);

  @override
  _FormPatientPageState createState() => _FormPatientPageState();
}

class _FormPatientPageState extends State<FormPatientPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController perawatController = TextEditingController();
  TextEditingController pasienController = TextEditingController();
  TextEditingController noRmController = TextEditingController();

  List<OrientationPainful> orientations = [];
  @override
  void initState() {
    if (widget.old != null) {
      perawatController.text = widget.old!.perawat;
      pasienController.text = widget.old!.pasien;
      noRmController.text = widget.old!.noRm;
      orientations = [];
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
                //Center(child: TimeInHourAndMinute()),
                SizedBox(height: 20),
                TextFormField(
                  controller: noRmController,
                  decoration: decorationForm.copyWith(labelText: 'No. RM'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: pasienController,
                  decoration: decorationForm.copyWith(labelText: 'Nama Pasien'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: perawatController,
                  decoration:
                      decorationForm.copyWith(labelText: 'Nama Perawat'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),

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
              Provider.of<PatientProvider>(context, listen: false)
                  .saveDataPatient(
                widget.old,
                Patient(
                  userId: widget.old == null
                      ? DateTime.now().millisecondsSinceEpoch.toString()
                      : widget.old!.userId,
                  noRm: noRmController.text,
                  pasien: pasienController.text,
                  perawat: perawatController.text,
                ),
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
