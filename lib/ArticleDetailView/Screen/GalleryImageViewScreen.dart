import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class GalleryImageViewScreen extends StatelessWidget {
  List<dynamic> gallery;
  GalleryImageViewScreen({Key? key, required this.gallery}) : super(key: key);
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          //shrinkWrap: true,
          itemCount: gallery.length,
          itemBuilder: (context, index) {
            messageController.text = gallery[index]['GalleryMessage'];
            return VStack([
              AspectRatio(
                aspectRatio: 16 / 13,
                child: InteractiveViewer(
                  panEnabled: true, // Set it to false
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.5,
                  maxScale: 2,
                  child: Image(
                    image: CachedNetworkImageProvider(
                        gallery[index]['GalleryImageUrl']),
                    //   fit: BoxFit.fill, // use this
                  ),
                ),
              ),
              15.heightBox,
              Text(gallery[index]['GalleryMessage']
                      //controller: messageController,
                      //readOnly: true,
                      // maxLines: 10,
                      // minLines: 2,
                      )
                  .text
                  .lg
                  .justify
                  //.ellipsis
                  .makeCentered()
                  .box
                  //.red600
                  .p12
                  .width(context.screenWidth)
                  //.height(context.screenWidth * 1.2)
                  .makeCentered()
            ], alignment: MainAxisAlignment.spaceEvenly)

                /* Container(
              width: context.screenWidth,
              height: context.screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(gallery[index]))),
            )*/
                ;
          },
        ),
      ),
    );
  }
}
