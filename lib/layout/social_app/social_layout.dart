import 'package:abdulla_mansour/layout/social_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/social_app/cubit/states.dart';
import 'package:abdulla_mansour/modules/social_app/new_post/new_post_screen.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (context, state)
    {
      if(state is SocialNewPostStates)
        {
          navigateTo(context, NewPostScreen(),);
        }
    },
      builder:(context, state)
      {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
             cubit.titles[cubit.currentIndex],
            ),
            actions:
            [
              IconButton(onPressed:(){} ,
          icon: Icon(
            Icons.notifications,
          ),
              ),
              IconButton(onPressed:(){} ,
                icon: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items:
            [
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.chat,
                ),
                label: 'Chat'
              ),
              BottomNavigationBarItem(
                  icon:Icon(
                    Icons.add_circle_outline_outlined,
                  ),
                  label: 'Post'
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.map,
                ),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      } ,
      );
  }
}
