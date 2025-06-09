import 'package:flutter/material.dart';
import 'package:flutter_blog/ui/pages/post/list_page/wiegets/post_list_body.dart';
import 'package:flutter_blog/ui/widgets/custom_navigator.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class PostListPage extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  PostListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomNavigation(scaffoldKey),
      appBar: AppBar(
        title: Text("Blog"),
      ),
      body: PostListBody(),
    );
  }
}
