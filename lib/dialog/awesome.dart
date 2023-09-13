import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AwesomeDialogSuccess {
  customAwesomeCustomDialog(
    BuildContext context, {
    required Widget widget,
  }) {
    return AwesomeDialog(
      padding: EdgeInsets.zero,
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      body: widget,
      btnOkOnPress: () {},
    ).show();
  }

  Widget customTextAwesomeDialog(
    BuildContext context, {
    required String title,
    required String text,
  }) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                child: Row(
                  children: [
                    Text(
                      ': $text',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Divider(
          thickness: 2,
        )
      ],
    );
  }

  TextStyle awesomeDialogBodyTextStyle() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white);
  }
}
