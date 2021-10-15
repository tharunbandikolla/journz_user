import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';

class AppbarTitleAndLogo extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarTitleAndLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 12,
      leading: Container(
          width: getWidth(context) * 0.01,
          height: getWidth(context) * 0.01,
          padding: EdgeInsets.all(1.5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              //color: Colors.amber,
              image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.contain,
                image: AssetImage('images/fluenzologo.png'),
              ))),
      title: Text(
        'FLUENZO',
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
