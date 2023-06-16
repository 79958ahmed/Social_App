import 'dart:io';

import 'package:abdulla_mansour/app_router.dart';
import 'package:abdulla_mansour/layout/social_app/cubit/states.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../layout/social_app/cubit/cubit.dart';

class EditProfileScreen extends StatelessWidget {

var nameController=TextEditingController();
var bioController=TextEditingController();
var phoneController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context, state) {} ,
      builder: (context,state)
      {

        var userModel=SocialCubit.get(context).userModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;

        nameController.text=userModel.name;
       phoneController.text=userModel.phone;
        bioController.text=userModel.bio;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions:
            [
              defaultTextButton(
                function: ()
                {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                  );
                },
                text: 'Update',
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:
                [
                  if(state is SocialUserUpdateLoadingStates)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingStates)
                    SizedBox(
                height: 10,
            ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:[
                        Align(
                          child:Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                          children:[
                          Container(
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
                                image: coverImage == null ? NetworkImage(
                                  '${userModel.cover}',
                                ):FileImage(coverImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                            IconButton(
                              onPressed: ()
                              {
                              SocialCubit.get(context).getCoverImage();
                              },
                                icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.photo,
                                    size: 16,
                                  ),
                                ),
                            ),
                ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                        children:[
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:profileImage == null? NetworkImage(
                                '${userModel.image}'):FileImage(profileImage) ,
                          ),
                        ),
                          IconButton(
                            onPressed: ()
                            {
                              SocialCubit.get(context).getprofileImage();
                            },
                            icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.photo,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
              ],
            ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage!= null)
                  Row(
      children:
      [
        if(SocialCubit.get(context).profileImage != null)
        Expanded(
            child: Column(
              children: [
              defaultButton(
                function:()
              {
SocialCubit.get(context).uploadProfileImage(
    name: nameController.text,
    phone: phoneController.text,
    bio: bioController.text,
);
              },
                text: 'upload profile ',
              ),
                if(state is SocialUserUpdateLoadingStates)
SizedBox(
                  height: 5,
                ),
                if(state is SocialUserUpdateLoadingStates)
                LinearProgressIndicator(),
              ],
            ),

        ),
        SizedBox(
            width: 5,
        ),
        if(SocialCubit.get(context).coverImage != null)
            Expanded(
              child: Column(
                children: [
                  defaultButton(
                    function:()
                    {
                      SocialCubit.get(context).uploadCoverImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    },
                    text: 'upload cover ',
                  ),
                  if(state is SocialUserUpdateLoadingStates)
                  SizedBox(
                    height: 5,
                  ),
                  if(state is SocialUserUpdateLoadingStates)
                  LinearProgressIndicator(),
                ],
              ),

            ),
      ],
      ),
                  SizedBox(
                    height: 20,
                  ),
                  dfaultFormfield(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value)
                    {
                    if(value.isEmpty) {
                      return 'Must Not Be Empty';
                    }
                    return null;
                    },
                    label: 'Name',
                    prefix:Icons.person,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  dfaultFormfield(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value)
                    {
                      if(value.isEmpty) {
                        return 'Must Not Be Empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix:Icons.article,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  dfaultFormfield(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value)
                    {
                      if(value.isEmpty) {
                        return 'Must Not Be Empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix:Icons.phone,
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
