import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/cubitLayout/layout_cubit.dart';
import 'package:social_app/modules/edit_profile_screen.dart';
import 'package:social_app/modules/login_screen.dart';
import 'package:social_app/network/remote/cache_helper.dart';
import 'package:social_app/shared/component/shared_component.dart';
import '../shared/component/constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      builder: (context, state) {
        var cubit=context.read<LayoutCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('${cubit.title[cubit.index]}',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 27,
                  fontWeight: FontWeight.w600
              ),),
          ),
          body: ConditionalBuilder(
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Image.network(
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,'${cubit.model!.cover}'),
                          Positioned(
                            bottom: 0,
                            left: 120,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                      width: 160,
                                      height: 160,
                                      fit: BoxFit.cover,'${cubit.model!.image}'),
                                )
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('${cubit.model!.name}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 22
                      ),),
                    SizedBox(height: 10,),
                    Text('${cubit.model!.bio}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 15
                      ),),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: BuildButtom(text: 'Add Photos',
                                fontBold: true,
                                background: Theme.of(context).primaryColor,
                                border: false,
                                onpress: () {

                                }, width: 150, textcolor: Colors.white,
                                elevation: 0, height: 35),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child: BuildButtom(text: 'Edit profile',
                                fontBold: true,
                                border: false,
                                background: Color(0xFFEEEEEE),
                                onpress: () {
                                  Push(widget: EditProfileScreen(),
                                      context: context);
                                }, width: 150, textcolor: Colors.black,
                                elevation: 0, height: 37),
                          ),
                          SizedBox(width: 15,),
                          IconButton(
                            onPressed: () {
                              CacheHelper.RemoveData(key: 'uId');
                              cubit.model=null;
                              PushAndFinish(widget: LoginScreen(),
                                  context: context);
                            },
                            icon: Icon(IconlyBroken.logout,size: 30),)

                        ],
                      ),
                    ),
                    Divider(thickness: 1,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        Expanded(child:Column(children: [
                          Text('Posts',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).canvasColor,
                              fontSize: 18
                          ),),
                          Text('23',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).canvasColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                        ],)),
                        Expanded(child:Column(children: [
                          Text('Friends',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).canvasColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),),
                          Text('340',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).canvasColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),),
                        ],)),
                        Expanded(child:Column(children: [
                          Text('Followers',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).canvasColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),),
                          Text('132',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).canvasColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),),
                        ],)),
                        Expanded(child:Column(children: [
                          Text('Following',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).canvasColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                          Text('56',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).canvasColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                        ],)),
                      ],),
                    ),
                    Divider(thickness: 1,),
                    SizedBox(height: 10,),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        if(uId==cubit.posts[index].uId)
                          return buildCardPost(context,cubit,index);
                      },
                      itemCount: cubit.posts.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    )


                  ],
                ),
              );
            },
            fallback: (context) {
              return Center(child: CircularProgressIndicator(color: color,));
            },
            condition: cubit.model!=null,
          ),
        );
      },
      listener: (context, state) {

      },

    );
  }
}
