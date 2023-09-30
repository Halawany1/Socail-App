import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/cubitLayout/layout_cubit.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/shared/component/shared_component.dart';

import '../shared/component/constants.dart';

class MessageScreen extends StatelessWidget {
  UserModel? userModel;

  MessageScreen(this.userModel);

  @override
  Widget build(BuildContext context) {

    var messageController = TextEditingController();
    return Builder(
      builder: (context) {
        var cubit=context.read<LayoutCubit>();
        cubit.GetMessage(receiverId: userModel!.uId.toString());
        return BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            '${userModel!.image}'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${userModel!.name}',
                      style:
                      Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                          MessageModel message=cubit.messages[index];
                          print(message.arrange);
                          print(cubit.messages[index].text!);
                        if(userModel!.uId==cubit.messages[index].receiverId)
                          {
                            return buildAMyMessage(context,message);
                          }
                        else{
                          return buildMessage(context,message);
                        }


                      }, separatorBuilder: (context, index) => SizedBox(height: 15,),
                          itemCount: cubit.messages.length),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Theme.of(context).iconTheme.color),
                                hintText: 'type your message here...',
                              ),
                            ),
                          ),
                          Container(
                            height: 55,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),
                                          bottomRight:Radius.circular(15)),
                                    )),
                                onPressed: () {
                                  cubit.SendMessage
                                    (receiverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.clear();
                                },
                                child: Icon(IconlyBroken.send,)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Align buildAMyMessage(BuildContext context,MessageModel message) {
    return Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )),
                        child: Text(
                          message.text!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 17, color: Colors.white),
                        )),
                  );
  }

  Align buildMessage(BuildContext context,MessageModel message) {
    return Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Text(
                          message.text!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 17),
                        )),
                  );
  }
}
