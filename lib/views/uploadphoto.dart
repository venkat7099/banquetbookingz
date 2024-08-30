import 'dart:io';

// import 'package:driver_app/providers/loader.dart';
// import 'package:driver_app/providers/phoneauthnotifier.dart';
// import 'package:driver_app/providers/selectionprovider.dart';
// import 'package:driver_app/providers/uploadimageprovider.dart';
// import 'package:driver_app/widgets/button.dart';
import 'package:banquetbookingz/providers/imageprovider.dart';
import 'package:banquetbookingz/providers/selectionmodal.dart';
import 'package:banquetbookingz/widgets/button.dart';
import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhoto extends StatelessWidget {
  Future<ImageSource?> _showImageSourceSelector(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrrenWidth = MediaQuery.of(context).size.width;
    final scrrenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF330099)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Photo Upload',
            style: TextStyle(
                color: Color(0xFF1e1e1e),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        // Adjust the color to match your design
      ),
      body: Center(
        child: Container(
          width: scrrenWidth * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer(builder: (context, ref, child) {
                  final pickedFile = ref.watch(imageProvider).profilePic;
                  return Stack(
                    children: [
                      pickedFile != null
                          ? Container(
                              height: scrrenHeight * 0.45,
                              width: scrrenWidth * 0.54,
                              color: Colors.grey,
                              child: Image.file(File(pickedFile.path)))
                          : Container(
                              height: scrrenHeight * 0.45,
                              width: scrrenWidth * 0.54,
                              color: Colors.grey,
                            ),
                      Positioned(
                          bottom: 0,
                          child: Column(
                            children: [
                              pickedFile == null
                                  ? CustomElevatedButton(
                                      borderRadius: 2,
                                      text: "Take Photo",
                                      width: scrrenWidth * 0.54,
                                      backGroundColor: Colors.black,
                                      onPressed: () async {
                                        final ImageSource? source =
                                            await _showImageSourceSelector(
                                                context);
                                        if (source != null) {
                                          ref
                                              .read(imageProvider.notifier)
                                              .pickImage(context, source,
                                                  'profilePic');
                                        }
                                      },
                                    )
                                  : Row(
                                      children: [
                                        CustomElevatedButton(
                                          borderRadius: 2,
                                          text: "Retake",
                                          width: scrrenWidth * 0.27,
                                          backGroundColor: Color(0xFF80fd4f4f),
                                          onPressed: () async {
                                            final ImageSource? source =
                                                await _showImageSourceSelector(
                                                    context);
                                            if (source != null) {
                                              ref
                                                  .read(imageProvider.notifier)
                                                  .pickImage(context, source,
                                                      'profilePic');
                                            }
                                          },
                                        ),
                                        CustomElevatedButton(
                                          borderRadius: 2,
                                          text: "Ok",
                                          width: scrrenWidth * 0.27,
                                          backGroundColor: Color(0xFF8043b256),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop();
                                          },
                                        )
                                      ],
                                    )
                            ],
                          ))
                    ],
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Take a picture of you with \na white or clear background",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xFF1e1e1e)),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer(
                      builder: (context, value, child) {
                        final PickedImage =
                            value.watch(imageProvider).profilePic;

                        var val = value.watch(selectionModelProvider);
                        
                        //print(value.isloading);
                        return CustomElevateButton(
                          borderRadius: 15.0,
                          input: PickedImage != null ? true : false,
                          text: "Save",
                          backGroundColor: PickedImage != null
                              ? Color(0xFF330099)
                              : Color(0xFFb0b0b0),
                          isLoading: false,
                          onPressed: PickedImage == null
                              ? null
                              : () {
                                  //print(value.isloading);
                                  Navigator.of(context).pop();

                                  //print(value.isloading);
                                },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
