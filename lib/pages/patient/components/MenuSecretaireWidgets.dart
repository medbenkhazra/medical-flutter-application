import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


/* class MenuWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuWidgetState();
}
 */
//class MenuWidgetState extends State<MenuWidget> {
class MenuSecretaireWidget extends StatelessWidget {
  const MenuSecretaireWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  IconButton(
          color: Colors.white,
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {
            print("menu clicked");
            
            print(context);
            print(ZoomDrawer.of(context));
            ZoomDrawer.of(context)!.toggle();
            //MenuPage();
            print("end");
          },
        );
  }

}