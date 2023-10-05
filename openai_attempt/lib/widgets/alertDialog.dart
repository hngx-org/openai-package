import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Use this for The Error response only
void errResponseDialog({required BuildContext? context, required String? errMessage}) {
  showDialog(
    context: context!,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.only(right: 60, left: 60, top: 50, bottom: 50),
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromRGBO(27, 94, 32, 1),
              width: 0.7,
            ),
            borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            errMessage ?? "An error Occured",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Exit",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}
