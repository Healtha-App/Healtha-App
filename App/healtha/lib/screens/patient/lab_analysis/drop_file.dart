import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../localization/generated/l10n.dart';

class FileDropWidget extends StatefulWidget {
  final Function(String, String) onFilePicked; // Pass file path and content

  const FileDropWidget({super.key, required this.onFilePicked});

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
              color: Colors.grey,
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.18,
          child: DragTarget<List<String>>(
            onWillAccept: (data) {
              return data?.length == 1;
            },
            onAccept: (data) async {
              setState(() {
                _pickedFile = File(data.first);
                _dropText = _pickedFile!.path.split('/').last;
              });

              String content = await _pickedFile!.readAsString();
              widget.onFilePicked(_pickedFile!.path, content);
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
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.storage,
                      ].request();

                        FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
                        if (result != null && result.files.isNotEmpty) {
                          setState(() {
                            _pickedFile = File(result.files.single.path!);
                            _dropText = _pickedFile!.path.split('/').last;
                          });

                          String content = await _pickedFile!.readAsString();
                          widget.onFilePicked(_pickedFile!.path, content);
                        }
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(
                          MediaQuery.of(context).size.width * 0.6,
                          MediaQuery.of(context).size.height * 0.055,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff00bb9a)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
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
