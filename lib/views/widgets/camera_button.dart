import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../top_view.dart';

class CameraButton extends StatelessWidget {
  CameraButton ({Key? key}): super(key:key);

  final _picker = ImagePicker();

  Future _getBase64Image() async {
    String? base64Image;
    File? pickedImage;
    // ignore: deprecated_member_use
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      Uint8List imageBytes = pickedImage.readAsBytesSync();
      List<int> compressedImage = await _compressImageBytes(imageBytes);
      base64Image = base64Encode(compressedImage);
      String datetime = await _getDateTimeFromImageBytes(imageBytes);
      print(datetime);
    }
    return base64Image;
  }


  Future _compressImageBytes(Uint8List imageBytes) async {
    List? result = await FlutterImageCompress.compressWithList(
      imageBytes,
      minHeight: 600,
      minWidth: 600,
    );
    return result;
  }

  Future<String> _getDateTimeFromImageBytes(List<int> imageBytes) async {
    final tags = await readExifFromBytes(imageBytes);
    return tags["Image DateTime"].toString();
  }

  Future _postImage() async {
    final base64Image = await _getBase64Image();
    if (base64Image == null) {
      print("err");
      return null;
    }
    // String url = "http://localhost:8000/image";
    String url = "https://httpbin.org/post";
    Map<String, String> headers = {"content-type": "application/json"};
    final obj = {"userId": 0, "imageBase64": base64Image, "step": 0};
    String body = json.encode(obj);

    http.Response res =
        await http.post(Uri.parse(url), headers: headers, body: body);
    return res;
  }

  Future _updateStatus() async {
    // resのステータスチェック
    //   if (res.statusCode != 200) {
    final res = await _postImage();
    if (res == null) return null;
    final body = json.decode(res.body);
    print(body);
    // final user = User.fromJson(json.decode(body["data"]));
    // final user = User.fromJson({"id": 0, "userName": "testUser", "status": 0});
    //print(user);
    //return user;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final notifier = ref.read(topPageProvider.notifier);
      return Center(child: 
      FloatingActionButton(onPressed:(() {
          _getBase64Image();

          // ToDo: ステータスの更新
          // notifier.updateStatus();

          print('a');
        }), child: Icon(Icons.camera)),
      );
    });
  }
   

}