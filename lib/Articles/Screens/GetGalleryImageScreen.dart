import 'dart:io';
import '/Articles/ArticlesBloc/GetGalleryFileCubit/getgalleryfile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class GetGalleryImage extends StatelessWidget {
  GetGalleryImage({Key? key}) : super(key: key);
  File? fileImg;
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final galleryCubit = BlocProvider.of<GetgalleryfileCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: "Select Image From Gallery".text.make(),
      ),
      body: BlocBuilder<GetgalleryfileCubit, GetgalleryfileState>(
        builder: (context, state) {
          state.file != null ? fileImg = state.file : fileImg = null;
          return state.file == null
              ? Center(
                  child: ElevatedButton(
                      onPressed: () {
                        galleryCubit.getPhoto();
                      },
                      child: Text('Add Image')),
                )
              : SingleChildScrollView(
                  child: Container(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.85,
                    child: VStack(
                      [
                        AspectRatio(
                          aspectRatio: 16 / 13,
                          child: Image(
                            image: FileImage(fileImg!),
                            //   fit: BoxFit.fill, // use this
                          ),
                        ).box.px12.make(),
                        TextField(
                          maxLength: 30,
                          minLines: 1,
                          maxLines: 5,
                          controller: messageController,
                          decoration:
                              InputDecoration(hintText: 'Describe your Moment'),
                        ).box.px12.make(),
                        ElevatedButton(
                                onPressed: () {
                                  Map<String, dynamic> imageData = {
                                    'imageFile': fileImg,
                                    'message': messageController.text.trim()
                                  };
                                  Navigator.pop(context, imageData);
                                },
                                child: Text('Done'))
                            .box
                            .px12
                            .makeCentered()
                      ],
                      alignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
