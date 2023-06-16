import 'dart:io';

import 'package:abdulla_mansour/layout/social_app/cubit/states.dart';
import 'package:abdulla_mansour/models/social_app/message_model.dart';
import 'package:abdulla_mansour/models/social_app/social_user_model.dart';
import 'package:abdulla_mansour/models/social_app/user_model.dart';
import 'package:abdulla_mansour/modules/social_app/chats/chats_screen.dart';
import 'package:abdulla_mansour/modules/social_app/feeds/feeds_screen.dart';
import 'package:abdulla_mansour/modules/social_app/new_post/new_post_screen.dart';
import 'package:abdulla_mansour/modules/social_app/settings/settings_screen.dart';
import 'package:abdulla_mansour/modules/social_app/users/users_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/social_app/post_model.dart';
import '../../../shared/components/constants.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() :super(SocialInitialStates());
static SocialCubit get(context)=> BlocProvider.of(context);

SocialUserModel userModel;

void getUserData()
{
emit(SocialGetUserLoadingStates());
FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .get()
    .then((value)
{
 //print (value.data());
 userModel =SocialUserModel.fromJson(value.data());
 emit(SocialGetUserSuccessStates());
})
    .catchError((error)
{
   print(error.toString());
  emit(SocialGetUserErrorStates(error.toString()));
});

}



int currentIndex =0;

List<Widget> screens =
[
  FeedsScreen(),
  ChatsScreen(),
  NewPostScreen(),
  UsersScreen(),
  SettingsScreen(),
];

List<String> titles=
[
  'Home',
  'Chats',
  'Post',
  'Users',
  'Settings',

];

void changeBottomNav(int index) {
if(index==1)
  getUsers();
  if (index == 2)
    emit(SocialNewPostStates());
  else {
    currentIndex = index;
    emit(SocialChangeBottomNavStates());
  }
}


  File profileImage;
  var picker =ImagePicker();

  Future<void> getprofileImage() async
  {
    final pickedFile=await picker.getImage(
      source: ImageSource.gallery,
    );

    if(pickedFile !=null)
    {
      profileImage=File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessStates());
    }else
    {
      print('No Image Selected.');
      emit(SocialProfileImagePickedErrorStates());
    }
  }

  File coverImage;
 // var picker =ImagePicker();

  Future<void> getCoverImage() async
  {
    final pickedFile=await picker.getImage(
      source: ImageSource.gallery,
    );

    if(pickedFile !=null)
    {
      coverImage=File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessStates());
    }else
    {
      print('No Image Selected.');
      emit(SocialCoverImagePickedErrorStates());
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
})
  {
    emit(SocialUserUpdateLoadingStates());
firebase_storage.FirebaseStorage.instance
    .ref()
    .child('users/${Uri.file(profileImage.path).pathSegments.last}')
    .putFile(profileImage)
    .then((value)
{
  value.ref.getDownloadURL().then((value)
  {
    //emit(SocialUploadProfileImageSuccessStates());
    print(value);
updateUser(
    name: name,
    phone: phone,
    bio: bio,
  image: value,
);
  }).catchError((error)
  {
    emit(SocialUploadProfileImageErrorStates());
  });
})
    .catchError((error)
{
  emit(SocialUploadProfileImageErrorStates());
});
  }

  void uploadCoverImage({
  @required String name,
  @required String phone,
  @required String bio,
  })
  {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
       // emit(SocialUploadCoverImageSuccessStates());
        print(value);
        updateUser(
      name: name,
      phone: phone,
      bio: bio,
          cover: value,
      );
      }).catchError((error)
      {
        emit(SocialUploadCoverImageErrorStates());
      });
    })
        .catchError((error)
    {
      emit(SocialUploadCoverImageErrorStates());
    });
  }

 /* void updateUserImages({
  @required String name,
    @required String phone,
    @required String bio,

  })
  {
    emit(SocialUserUpdateLoadingStates());
    if(coverImage != null)
      {
        uploadCoverImage();
      }else if (profileImage != null)
        {
          uploadProfileImage();
        }else if(coverImage != null && profileImage != null)
          {

            }
            else
          {
updateUser(name: name, phone: phone, bio: bio);
          }
  }

  */

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover  ,
    String image,


  })
  {
    SocialUserModel model =SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel.email,
      cover: cover??userModel.cover,
      image: image??userModel.image,
      uId: userModel.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value)
    {
      getUserData();
    })
        .catchError((error)
    {
      emit(SocialUserUpdateErrorStates());
    });
  }

  File postImage;
  // var picker =ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile=await picker.getImage(
      source: ImageSource.gallery,
    );

    if(pickedFile !=null)
    {
      postImage=File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessStates());
    }else
    {
      print('No Image Selected.');
      emit(SocialPostImagePickedErrorStates());
    }
  }

void removePostImage()
{
  postImage=null;
  emit(SocialRemovePostImageStates());
}

  void uploaPostImage({
    @required String dateTime,
    @required String text,

  })
  {
    emit(SocialCreatePostLoadingStates());
  firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        // emit(SocialUploadCoverImageSuccessStates());
        print(value);
        createPost(
            dateTime: dateTime,
            text: text,
          postimage:  value,
        );
      }).catchError((error)
      {
        emit(SocialCreatePostErrorStates());
      });
    })
        .catchError((error)
    {
        emit(SocialCreatePostErrorStates());
    });
  }
  void createPost({
    @required String dateTime,
    @required String text,
    String postimage,
  })
  {

    emit(SocialCreatePostLoadingStates());

    PostModel model =PostModel(
      name: userModel.name,
      image:userModel.image,
      uId: userModel.uId,
dateTime: dateTime,
      text: text,
      postimage: postimage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value)
    {
      getPosts();
emit(SocialCreatePostSuccessStates());
    })
        .catchError((error)
    {
      emit(SocialCreatePostErrorStates());
    });
  }
  List<PostModel>posts= [];
  List<String>postId= [];
  List<int>likes=[];


  void getPosts()
  {
    emit(SocialGetPostsLoadingStates());
FirebaseFirestore.instance
    .collection('posts')
    .get()
    .then((value)
{
  value.docs.forEach((element) 
  {
    element.reference.collection('likes')
    .get()
    .then((value)
    {

      likes.add(value.docs.length);
      postId.add(element.id);
      posts.add(PostModel.fromJson(element.data()));
    })
    .catchError((error)
    {});

  });

  emit(SocialGetPostsSuccessStates());
})
    .catchError((error)
{
  emit(SocialGetPostsErrorStates(error.toString()));
});
  }
  void likePost(String postId)
  {
FirebaseFirestore.instance
    .collection('posts')
    .doc(postId)
.collection('likes')
    .doc(userModel.uId)
    .set({
  'like':true,
})
    .then((value)
{
  getPosts();
emit(SocialLikePostSuccessStates());
})
    .catchError((error)
{
emit(SocialLikePostErrorStates(error.toString()));
});
  }


  List<SocialUserModel> users=[];

  void getUsers()
  {
   if(users.length==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
if(element.data()['uId'] !=userModel.uId )
        users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessStates());
    })
        .catchError((error)
    {
      emit(SocialGetAllUsersErrorStates(error.toString()));
    });
  }

  void sendMessage({
    @required String recieverId,
    @required String dateTime,
    @required String text,

  })
  {
MessageModel model=MessageModel(
  text: text,
  senderId: userModel.uId,
recieverId: recieverId,
  dateTime: dateTime,
);

//my chat

FirebaseFirestore.instance
.collection('users')
.doc(userModel.uId)
.collection('chats')
.doc(recieverId)
.collection('message')
.add(model.toMap())
.then((value)
{
emit(SocialSendMessageSuccessStates());
}).catchError((error)
{
  emit(SocialSendMessageErrorStates());
});

//reciever Chat

FirebaseFirestore.instance
    .collection('users')
    .doc(recieverId)
    .collection('chats')
    .doc(userModel.uId)
    .collection('message')
    .add(model.toMap())
    .then((value)
{
  emit(SocialSendMessageSuccessStates());
}).catchError((error)
{
  emit(SocialSendMessageErrorStates());
});
  }

  List <MessageModel> messages=[];

  void getMessages({
    @required String recieverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
        {
          messages=[];

          event.docs.forEach((element)
          {
messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessageSuccessStates());
        });


  }

}