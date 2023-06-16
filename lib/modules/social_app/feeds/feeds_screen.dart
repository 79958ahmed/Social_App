import 'package:abdulla_mansour/models/social_app/post_model.dart';
import 'package:abdulla_mansour/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context, state) {},
      builder: (context,state){
       return ConditionalBuilder(
         //state is != SocialGetPostsLoadingStates
         condition: SocialCubit.get(context).posts.length>0 && SocialCubit.get(context).userModel !=null,
         builder: (context)=>SingleChildScrollView(
           physics: BouncingScrollPhysics(),
           child: Column(
             children:
             [
               Card(
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 elevation: 5,
                 margin: EdgeInsets.all(8,),
                 child: Stack(
                   alignment: AlignmentDirectional.bottomEnd,
                   children: [
                     Image(
                       image: NetworkImage(
                           'https://img.freepik.com/free-photo/view-through-arch-gate-blue-mosque-istanbul-is-turkey_628469-117.jpg?w=996&t=st=1680095807~exp=1680096407~hmac=bb86e8d4a8e6a469fd05ab50965e628bdb0efd0065e7f43c411cfc98d446be11'
                       ),
                       fit: BoxFit.cover,
                       height: 200,
                       width: double.infinity,
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                         'communicate with friends',
                         style: Theme.of(context).textTheme.subtitle1.copyWith(
                           color: Colors.white,
                         ),
                       ),
                     )
                   ],
                 ),
               ),
               ListView.separated(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index) =>buildPostItem( SocialCubit.get(context).posts[index],context,index),
                 separatorBuilder: (context,index)=>SizedBox(
                   height: 8,
                 ),
                 itemCount: SocialCubit.get(context).posts.length,
               ),
               SizedBox(
                 height: 8,
               ),
             ],
           ),
         ),
         fallback:  (context)=>Center(child: CircularProgressIndicator()),
       );
      },
    );
  }

  Widget buildPostItem(PostModel model,context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal:8 ,),
    child:Padding(
      padding: const EdgeInsets.all(10.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children:
            [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:
                      [
                        Text(
                         ' ${model.name}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),

                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16,
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.more_horiz,
                  size: 16,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),

          if(model.postimage !='')
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15,
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4,),
                image:DecorationImage(
                  image: NetworkImage(
                      '${model.postimage}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ) ,
          Padding(
            padding: const EdgeInsets.symmetric(vertical:5, ),
            child: Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child:Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,),
                      child: Row(
                        children:
                        [
                          Icon(
                            Icons.add_reaction,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(

                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child:Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical:5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          Icon(
                            Icons.comment,
                            size: 16,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(

                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10,),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel.image}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Write a comment ...',
                          style: Theme.of(context).textTheme.caption.copyWith(
                            height: 1.4,
                          ),
                        ),
                      ),
                      /*TextFormField
                    (
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is in your mind...?',
border: InputBorder.none,
                    ),
                  ),*/
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child:Row(
                  children:
                  [
                    Icon(
                      Icons.add_reaction,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(

                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {
              SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
