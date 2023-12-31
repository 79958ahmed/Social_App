
import 'package:abdulla_mansour/models/shop_app/login_model.dart';
import 'package:abdulla_mansour/models/social_app/social_user_model.dart';
import 'package:abdulla_mansour/modules/shop_app/login/cubit/states.dart';
import 'package:abdulla_mansour/modules/shop_app/register/cubit/states.dart';
import 'package:abdulla_mansour/modules/social_app/social_register/cubit/states.dart';
import 'package:abdulla_mansour/shared/network/remote/dio_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/network/end_points.dart';
class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super (SocialRegisterInitialState());
static SocialRegisterCubit get(context)=>BlocProvider.of(context);


void userRegister({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,

})
{
  print('hello');

  emit(SocialRegisterLoadingState());
FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
).then((value)
{

  userCreate(
    uId: value.user.uid,
phone: phone,
    email: email,
    name: name,
  );

})
    .catchError((error)
{
  emit(SocialRegisterErrorState(error.toString()));
});
}

void userCreate({
  @required String name,
  @required String email,
  @required String phone,
  @required String uId,
})
{
  SocialUserModel model =SocialUserModel(
    name: name,
    email: email,
    phone: phone,
    uId: uId,
    bio: 'Write Your Bio ....',
    cover: 'https://img.freepik.com/free-photo/portrait-sensitive-man_23-2149444485.jpg?t=st=1680264049~exp=1680264649~hmac=751fc20a2ee08b83a918fff28cdfb0e5be5160d8ddef644e78d711fefd71c0ff',
    image: 'https://img.freepik.com/free-photo/portrait-sensitive-man_23-2149444485.jpg?t=st=1680264049~exp=1680264649~hmac=751fc20a2ee08b83a918fff28cdfb0e5be5160d8ddef644e78d711fefd71c0ff',
    isEmailVerified: false,
  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap()).then((value)
  {
    emit(SocialCreateSuccessState());
  }).catchError((error)
  {
    print(error.toString());
    emit(SocialCreateErrorState(error.toString()));
  });
}

IconData suffix=Icons.visibility_outlined;
bool isPassword=true;

void changePasswordVisibility()
{
  isPassword=!isPassword;
  suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(SocialRegisterChangePasswordVisibilityState());
}
}