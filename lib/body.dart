import 'package:flutter/material.dart';

import 'awesome.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key, required this.nidNumber});

  final String nidNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: const Text(
              'আপনার আবেদনটি সফলভাবে দাখিল করা হয়েছে : applicationId',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.green),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        AwesomeDialogSuccess().customTextAwesomeDialog(context, title: 'জাতিয় পরিচয়পত্র', text: nidNumber),
        AwesomeDialogSuccess().customTextAwesomeDialog(context, title: 'মোবাইল', text: 'mobileNum'),
        AwesomeDialogSuccess().customTextAwesomeDialog(context, title: 'জন্ম তারিখ', text: 'formattedDateOfBirth'),
        AwesomeDialogSuccess().customTextAwesomeDialog(context, title: 'বৈবাহিক অবস্থা', text: 'maritalStatus'),
        AwesomeDialogSuccess().customTextAwesomeDialog(context, title: 'লিঙ্গ', text: 'gander'),
        // AwesomeDialogSuccess().customTextAwesomeDialog(context, title: 'জাতীয় পরিচয়পত্রের ধরন', text: spouseNidType),

        // AwesomeDialogSuccess()
        //     .customTextAwesomeDialog(context, title: 'File', text: filePathController.text),
      ],
    );
  }
}
