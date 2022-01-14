import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) : super(
          key: key,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 22.0),
          ),
          height: 44.0,
          primaryColor: Colors.indigo,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
