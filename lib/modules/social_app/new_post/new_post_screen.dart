import 'package:abdulla_mansour/app_router.dart';
import 'package:abdulla_mansour/layout/social_app/cubit/cubit.dart';
import 'package:abdulla_mansour/layout/social_app/cubit/states.dart';
import 'package:abdulla_mansour/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/social_layout.dart';

class NewPostScreen extends StatelessWidget {

  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (context, state)
    {
      if(state is SocialCreatePostSuccessStates) {
        navigateTo(context, SocialLayout(),);
        SocialCubit.get(context).getPosts();
      }
    },
      builder: (context, state)
      {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                function: ()
              {
                var now =DateTime.now();

if(SocialCubit.get(context).postImage==null)
  {
    SocialCubit.get(context).createPost(
        dateTime: now.toString(),
        text: textController.text,
    );
  }else
    {
      SocialCubit.get(context).uploaPostImage(
          dateTime: now.toString(),
          text: textController.text,
      );
    }
              },
                text: 'POST',
              ),
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child:   Column(
              children:
              [
                if(state is SocialCreatePostLoadingStates)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingStates)
                SizedBox(
                  height: 10,
                ),
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/premium-vector/arabic-window-design-ramadan-kareem-greeting-card_611910-3410.jpg?w=826'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child:  Text(
                        'Ahmed Yassin',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField
                    (
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is in your mind...?',
border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children:[
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(4,),
                        image:DecorationImage(
                          image:FileImage(SocialCubit.get(context).postImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                 SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children:[
                  Expanded(
                    child: TextButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).getPostImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Icon(
                            Icons.image,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'add photo '
                          ),
                        ],
                      ),
                    ),
                  ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(
                              Icons.tag,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                'tags'
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
                ),
              ],
            ),
          ) ,
        );
      },
    );
  }
}

