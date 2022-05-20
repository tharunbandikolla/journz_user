import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SaiHeader extends StatelessWidget {
  const SaiHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.screenWidth,
        height: context.screenHeight * 0.085,
        color: Colors.blue.shade50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('JOURNZ')
                  .text
                  .bold
                  .xl2
                  .make()
                  /*  Image.asset(
            'assets/images/journzLogoFigma.png',
            fit: BoxFit.fill,
          ) */
                  .box
                  .px16
                  .alignCenterLeft
                  .width(context.screenWidth * 0.125)
                  .height(context.screenHeight * 0.07)
                  .make(),
              SizedBox(width: context.screenWidth * 0.125),
              Row(
                children: [
                  DropdownButton<String>(
                    value: 'Trending',
                    items: <String>[
                      'Trending',
                      'All',
                      'Business',
                      'Empowerment',
                      'Mindset',
                      'Awarness',
                      'Social Issues'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  )
                      .box
                      .px3
                      //.width(context.screenWidth * 0.075)
                      .height(context.screenHeight * 0.06)
                      .make(),
                  //SizedBox(width: context.screenWidth * 0.01),
                  VerticalDivider(
                    color: Colors.black26,
                    thickness: 1.25,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Search Here...", border: InputBorder.none),
                  )
                      .box
                      .py4
                      .width(context.screenWidth * 0.3)
                      .height(context.screenHeight * 0.06)
                      .make(),
                ],
              )
                  .box
                  .alignCenterLeft
                  .border(color: Colors.black)
                  // .width(context.screenWidth * 0.4)
                  .height(context.screenHeight * 0.06)
                  .make(),
              /* SizedBox(
            width: context.screenWidth * 0.1,
          ),
          Row(
            children: [
              Container(
                width: context.screenWidth * 0.1,
                height: context.screenHeight * 0.06,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Create Account').text.white.make(),
              ),
              SizedBox(width: context.screenWidth * 0.015),
              Container(
                width: context.screenWidth * 0.1,
                height: context.screenHeight * 0.06,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Sign in'),
              )
             ],
          )*/
            ]));
  }
}
