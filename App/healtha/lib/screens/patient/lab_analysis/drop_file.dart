// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healtha/localization/generated/l10n.dart';

class FileDropWidget extends StatefulWidget {
  const FileDropWidget({super.key});

  @override
  _FileDropWidgetState createState() => _FileDropWidgetState();
}

class _FileDropWidgetState extends State<FileDropWidget> {
  File? _pickedFile;
  String _dropText = 'Drag your file here';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // Color of the border
              style: BorderStyle.solid, // Solid border style
              width: 1.0, // Border width
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.18,
          child: DragTarget<List<String>>(
            onWillAccept: (data) {
              return data?.length == 1; // Accept only one file
            },
            onAccept: (data) {
              setState(() {
                _pickedFile = File(data.first);
                _dropText =
                    _pickedFile!.path.split('/').last; // Display file name
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Icon(
                    Icons.cloud_upload_outlined,
                    size: 55.0,
                    color: Colors.grey,
                  ),
                  Text(
                    _dropText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: false);
                      if (result != null && result.files.isNotEmpty) {
                        setState(() {
                          _pickedFile = File(result.files.single.path!);
                          _dropText = _pickedFile!.path.split('/').last;
                        });
                      }
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(
                          0), // Set elevation to 0
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(
                          MediaQuery.of(context).size.width * 0.6,
                          MediaQuery.of(context).size.height * 0.055,
                        ), // Set the width and height as needed
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff00bb9a)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.zero, // Set border radius to zero
                        ),
                      ),
                    ),
                    child: Text(
                      S.of(context).Browse_File,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
