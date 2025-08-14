import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future _pickImageFromGallery() async {
  final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (returnedImage != null) {



  }
}
Future _pickImageFromCamera() async {
  final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  if (returnedImage != null) {
  }
}

Future imageSheet(context)
{
  return showModalBottomSheet(context: context,
      builder:(BuildContext context)
      {
        return FractionallySizedBox(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF454545),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: ()
                async{
                  await _pickImageFromGallery();

                }
                  ,style: TextButton.styleFrom(padding: EdgeInsets.zero,) ,child: const ListTile(leading: Icon(CupertinoIcons.pencil_circle,color: Colors.white,),title: Text('Gallery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),

                const Divider(height: 1,color: Colors.white24,),

                TextButton(onPressed: ()async
                {
                  await _pickImageFromCamera();
                },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero,),
                  child: const ListTile(leading: Icon(CupertinoIcons.camera,color: Colors.white,),title: Text('Camera',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),
              ],
            ),
          ),
        );

      }
  );
}
