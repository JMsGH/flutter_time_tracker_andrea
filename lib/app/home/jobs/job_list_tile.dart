import 'package:flutter/material.dart';

import '../models/job.dart';

class JobListTle extends StatelessWidget {
  const JobListTle({Key? key, required this.job, this.onTap}) : super(key: key);

  final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
