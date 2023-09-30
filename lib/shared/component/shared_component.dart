import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/cubitAuthentication/authentication_cubit.dart';

import '../../bloc/cubitLayout/layout_cubit.dart';
import 'constants.dart';

Widget BuildBackground({
  required String text,
}) {
  return Image.asset(
    'images/$text',
    width: double.infinity,
    fit: BoxFit.cover,
  );
}

Widget BuildLogo({
  required String text,
  required double width,
  required double height,
}) {
  return Image.asset(
    'images/$text',
    width: width,
    height: height,
  );
}

Widget BuildTextFormField({required String hintText,
  required TextEditingController controller,
  VoidCallback ?ontap,
  bool boarder=false,
  IconData ?prefixIcon,
  bool ?password,
  required String? Function(String?) validate,
  bool pass = false,}) {
  return TextFormField(
    controller: controller,
    validator: validate,
    obscureText: pass ? !password! : false,
    decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:prefixIcon!=null?Icon(prefixIcon):null,
        suffixIcon: pass ? GestureDetector(
          onTap: ontap,
          child: Icon(!password! ?
          CupertinoIcons.eye_slash :
          CupertinoIcons.eye,),
        ) : null,
        hintStyle: GoogleFonts.dmSans(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        border: boarder?OutlineInputBorder():UnderlineInputBorder()),
  );
}

Widget BuildButtom({
  required String text,
  required VoidCallback onpress,
  required double width,
  required Color textcolor,
  required double elevation,
  Color background = color,
  bool fontBold=false,
  bool border=true,
  required double height
}) {
  return ElevatedButton(onPressed: onpress,
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          minimumSize: Size(width, height),
          maximumSize: Size(width, height),
          backgroundColor: background,
          shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: border?BorderSide(color: color, width: 1.5):BorderSide(color: background, width: 1.5)
          )
      ),
      child: Text(text, style: GoogleFonts.poppins(
          color: textcolor,
        fontWeight: fontBold?FontWeight.w700:null
      ),));
}

Widget BuildLineRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(width: 140,
        height: 1,
        color: Colors.grey,
      ),
      SizedBox(width: 7,),
      Text('OR', style: GoogleFonts.dmSans(fontSize: 14,
          color: Colors.grey),),
      SizedBox(width: 7,),
      Container(width: 140,
        height: 1,
        color: Colors.grey,
      ),

    ],
  );
}
enum ToastState { SUCCESS, ERROR, WARNING }

void ShowToast({
  required String message,
  required ToastState state
}) async {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ChooseToastState(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Color ChooseToastState(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Future PushAndFinish({required Widget widget,required context}) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget,));
}

Future Push({required Widget widget,required context}) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget,));
}


Card buildCardPost(BuildContext context,LayoutCubit cubit,int index) {
  return Card(
    elevation: 15,
    shadowColor: Theme.of(context).iconTheme.color,
    color: Theme.of(context).cardColor,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                      '${cubit.posts[index].image}'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${cubit.posts[index].name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    '${cubit.posts[index].dateTime}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              Spacer(),
              Icon(IconlyBroken.more_circle,color: Theme.of(context).iconTheme.color,)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.5),
            child: Divider(
              thickness: 1,
            ),
          ),
          if(cubit.posts[index].text!='')
            Text(
                '${cubit.posts[index].text}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
            ),
          if(cubit.posts[index].text!='')
            SizedBox(height: 10,),
          if(cubit.posts[index].postImage!='')
            Card(
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  '${cubit.posts[index].postImage}'),
            ),
          if(cubit.posts[index].postImage!='')
            SizedBox(height: 10,),
          Row(
            children: [
              InkWell(
                onTap: () {
                  cubit.LikePost(cubit.posdId[index]);
                },
                child: Row(children: [
                  Icon(IconlyBroken.heart,size:20,color: Colors.red,),
                  SizedBox(width: 5,),
                  Text('${cubit.likes[index]}',style:Theme.of(context).textTheme.caption,),
                ],),
              ),
              Spacer(),
              InkWell(
                onTap: () {

                },
                child: Row(children: [
                  Icon(IconlyBroken.chat,size:20 ,color: Colors.amber,),
                  SizedBox(width: 5,),
                  Text('0',style:Theme.of(context).textTheme.caption,),
                  SizedBox(width: 5,),
                  Text('comment',style:Theme.of(context).textTheme.caption,)
                ],),
              )
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Row(children: [
            InkWell(
              onTap: () {

              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover,
                          '${cubit.model!.image}'),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Write a comment....',style:Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w600
                  ),),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                cubit.LikePost(cubit.posdId[index]);
              },
              child: Row(children: [
                Icon(IconlyBroken.heart,size:20,color: Colors.red,),
                SizedBox(width: 5,),
                Text('Like',style:Theme.of(context).textTheme.caption,)
              ],),
            )

          ],),

        ],
      ),
    ),
  );
}
