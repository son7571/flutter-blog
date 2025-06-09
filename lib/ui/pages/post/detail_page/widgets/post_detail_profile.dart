import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:flutter_blog/data/model/post.dart';

class PostDetailProfile extends StatelessWidget {
  Post post;

  PostDetailProfile(this.post);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("${post.user.username}"),
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: "${baseUrl}${post.user.imgUrl}",
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        subtitle: Row(
          children: [
            Text("ssar@nate.com"),
            const SizedBox(width: mediumGap),
            const Text("·"),
            const SizedBox(width: mediumGap),
            const Text("Written on "),
            Text("May 25 ${post.createdAt}"),
          ],
        ));
  }
}
