import 'package:abdulla_mansour/layout/social_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/social_app/cubit/states.dart';
import 'package:abdulla_mansour/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context, state) {},
      builder: (context, state)
      {
        var userModel=SocialCubit.get(context).userModel;

        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:
            [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children:[
                    Align(
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              4,
                            ),
                            topRight: Radius.circular(
                              4,
                            ),
                          ),
                          image:DecorationImage(
                            image: NetworkImage(
                              '${userModel.cover}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            '${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  children:
                  [
                    Expanded(
                      child:InkWell(
                        child: Column(
                          children:
                          [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child:InkWell(
                        child: Column(
                          children:
                          [
                            Text(
                              '50',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child:InkWell(
                        child: Column(
                          children:
                          [
                            Text(
                              '100K',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child:InkWell(
                        child: Column(
                          children:
                          [
                            Text(
                              '630',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children:
                [
                  Expanded(
                    child:OutlinedButton(
                      onPressed: (){ },
                      child: Text(
                        'Add Photos'
                      ),
                    ),

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: ()
                    {
                      navigateTo(context, EditProfileScreen(),);
                    },
                    child: Icon(
                      Icons.edit,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
