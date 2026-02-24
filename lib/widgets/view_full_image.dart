import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:flutter/material.dart';

class ViewFullImage extends StatefulWidget {
  final String image;
  const ViewFullImage({super.key,required this.image});

  @override
  State<ViewFullImage> createState() => _ViewFullImageState();
}

class _ViewFullImageState extends State<ViewFullImage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
       mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.clear_rounded,color: Colors.white,),
          ),
          hsized10,
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(ApiPath.imageBaseUrl+widget.image)),

        ],
      ),
    );
  }
}
