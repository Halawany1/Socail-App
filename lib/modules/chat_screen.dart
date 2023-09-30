import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/modules/message_chat_screen.dart';
import 'package:social_app/shared/component/constants.dart';
import 'package:social_app/shared/component/shared_component.dart';
import 'package:social_app/shared/skelton.dart';

import '../bloc/cubitLayout/layout_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController=TextEditingController();
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            title: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      height: 40,
                      width: 40,
                      '${cubit.model!.image}',fit: BoxFit.cover,)),
                SizedBox(width: 10,),
                Text(
                  '${cubit.title[cubit.index]}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 27,
                      fontWeight: FontWeight.w600
                      ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Icon(IconlyBroken.edit),
              )
            ],
          ),
          body: ConditionalBuilder(
            condition: cubit.users.length>0,
            fallback:(context) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                  Skeleton(width: double.infinity,height: 35,),
                    SizedBox(height: 30,),
                    Row(children: [
                      Skeleton(height: 80,width: 80),
                      SizedBox(width: 15,),
                      Skeleton(height: 80,width: 80,),
                      SizedBox(width: 15,),
                      Skeleton(height: 80,width: 80,),
                      SizedBox(width: 15,),
                      Skeleton(height: 80,width: 80,),

                    ],),
                    SizedBox(height: 50,),
                   ListView.separated(
                     shrinkWrap: true,
                       itemBuilder: (context, index) =>
                       Row(children: [
                     Skeleton(height: 80,width: 80,),
                     SizedBox(width: 15,),
                     Skeleton(width: 150,height: 15,),
                   ],), separatorBuilder: (context, index) => SizedBox(height: 20,),
                       itemCount: 4)
                  ],
                ),
              );
            } ,
            builder:(context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.only(top: 22,),
                                  prefixIcon: Icon(IconlyBroken.search,size: 24,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  fillColor: Theme.of(context).shadowColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none
                                  )
                              ),),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 120,
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder:(context, index) =>
                                    buildAllusers(cubit,index,context),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 15,),
                                itemCount: cubit.users.length),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            InkWell(
                                onTap: () {
                                  Push(widget: MessageScreen(cubit.users[index] ),
                                      context: context);
                                },
                                child: buildUsers(cubit, context,index)),
                        separatorBuilder: (context, index) =>
                            Divider(color: Theme.of(context).hintColor,thickness: 1)
                        , itemCount:cubit.users.length)
                  ],),
              );
            },
          )
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildAllusers(LayoutCubit cubit,int index,context) {
    return Container(
            width: 65,
            height: 75,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      height: 65,
                      width: 65,
                      '${cubit.users[index].image}',fit: BoxFit.cover,)),
                SizedBox(height: 3,),
                Text('${cubit.users[index].name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyText2!.
              copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500

                ),),

              ],
            ),

          );
  }

  Widget buildUsers(LayoutCubit cubit, BuildContext context,int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
            children: [
              Container(
                width: 70,
              height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                      fit: BoxFit.cover,
                      '${cubit.users[index].image}'),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '${cubit.users[index].name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18),
              ),
            ],
          ),
    );
  }
}
