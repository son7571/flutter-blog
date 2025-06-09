import 'package:flutter/material.dart';
import 'package:flutter_blog/data/gvm/session_gvm.dart';
import 'package:flutter_blog/ui/pages/post/list_page/wiegets/post_list_body.dart';
import 'package:flutter_blog/ui/widgets/custom_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class PostListPage extends ConsumerWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  PostListPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SessionModel model = ref.read(sessionProvider);

    return Scaffold(
      key: scaffoldKey,
      drawer: CustomNavigation(scaffoldKey),
      appBar: AppBar(
        title: Text("Blog ${model.isLogin} ${model.user!.username}"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {},
        child: PostListBody(),
      ),
    );
  }
}
