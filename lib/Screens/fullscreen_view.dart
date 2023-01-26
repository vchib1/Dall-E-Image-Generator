import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imagegenerator/Services/save_image.dart';
import 'package:permission_handler/permission_handler.dart';

class FullScreenView extends StatelessWidget {

  final String link;
  const FullScreenView({Key? key,required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void saveImage()async{
      if(await Permission.storage.request().isGranted){
        SaveImage.saveFile(link);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
              content: Text("Image Saved to Gallery"),
            )
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              saveImage();
            },
            icon: const Icon(Icons.save_alt),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: InteractiveViewer(
          child: Hero(
            tag: link,
            child: CachedNetworkImage(
              imageUrl: link,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
