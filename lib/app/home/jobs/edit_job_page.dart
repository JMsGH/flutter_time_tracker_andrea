import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';

import '../../services/database.dart';
import '../models/job.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key? key, required this.database, this.job})
      : super(key: key);
  final Database database;
  final Job? job;

  static Future<void> show(
    BuildContext context, {
    required Database database,
    Job? job,
  }) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(database: database, job: job),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  final _ratePerHourFocusNode = FocusNode();
  bool _isLoading = false;

  String? _name;
  int? _ratePerHour;

  @override
  initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job!.name;
      _ratePerHour = widget.job!.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    if (_validateAndSaveForm()) {
      try {
        // await Future.delayed(const Duration(seconds: 5));
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job!.name);
        }
        if (allNames.contains(_name)) {
          showAlertDialog(
            context,
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          );
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(id: id, name: _name!, ratePerHour: _ratePerHour!);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Operation failed ',
          exception: e,
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job?.name != null ? 'Edit Job' : 'New Job'),
        elevation: 2.0,
        actions: <Widget>[
          TextButton(
            onPressed: !_isLoading ? _submit : null,
            style: TextButton.styleFrom(
              primary: Colors.white,
              onSurface: Colors.grey,
            ),
            //ButtonStyle(backgroundColor:
            //     MaterialStateProperty.resolveWith<Color>(
            //         (Set<MaterialState> states) {
            //   if (states.contains(MaterialState.pressed)) {
            //     return Colors.blue.shade300;
            //   }
            //   return Colors.transparent;
            // })),
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey.shade200,
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        initialValue: _name,
        decoration: InputDecoration(
          labelText: 'Job name',
          enabled: _isLoading == false,
        ),
        validator: (value) => (value != null) && (value.isNotEmpty)
            ? null
            : 'Name can\'t be empty',
        onSaved: (value) => _name = value!,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_ratePerHourFocusNode),
      ),
      TextFormField(
        initialValue: _ratePerHour != null ? _ratePerHour.toString() : null,
        decoration: InputDecoration(
          labelText: 'Rate per hour',
          enabled: _isLoading == false,
        ),
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHour =
            ((value != null) && (value.isNotEmpty) ? int.tryParse(value) : 0)!,
        focusNode: _ratePerHourFocusNode,
      ),
    ];
  }
}
