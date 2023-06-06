import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClicked;

  const ImageWidget({Key? key, required this.image, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    
    return Center(
      
      child: Stack(
        children: [
          buildImage(context),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
   // final imagePath = (this.image!=null)?this.image.path:'/storage/emulated/0/Download/achraf.jpg';
    final imagePath =this.image.path;
    final image = FileImage(File(imagePath));
   // File image = File(imagePath);
    print(imagePath);
    print(image);
    print("asseets");
    //print(AssetImage('assets/images/doctor_1.png'));
    return Container(
      width: 400,
      height: 300,
      child: Ink.image(
         //image: AssetImage('assets/images/doctor_1.png'),
       image: (image!=null)?image as ImageProvider:AssetImage('assets/images/brain.png') ,
        fit: BoxFit.cover,
        width: 150,
        height: 150,
        child: InkWell(
          onTap: () async{
            final source=await showImageSource(context);
            if(source==null) return;
            onClicked(source);
          },
        ),
      ),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context){
    if(Platform.isIOS){
      return showCupertinoModalPopup<ImageSource>(
        context: context,
         builder: (context)=>CupertinoActionSheet(
           actions: [
             CupertinoActionSheetAction(
               child: Text("camera"),
               onPressed: ()=>Navigator.of(context).pop(ImageSource.camera),
               ),
             CupertinoActionSheetAction(
               child: Text("gallery"),
               onPressed: ()=>Navigator.of(context).pop(ImageSource.gallery),
               ),
           ],
         )
         );
    }else{
      return showModalBottomSheet(context: context,
       builder: (context)=>Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           ListTile(
             leading: Icon(Icons.camera_alt),
             title: Text("camera"),
             onTap: ()=>Navigator.of(context).pop(ImageSource.camera)
           ),
           ListTile(
             leading: Icon(Icons.image),
             title: Text("gallery"),
             onTap: ()=>Navigator.of(context).pop(ImageSource.gallery)
           ),
         ],
       )
       );
    }
  }
}
