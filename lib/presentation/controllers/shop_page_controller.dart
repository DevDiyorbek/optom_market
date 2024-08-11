// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
//
// class ShopPageController extends GetxController {
//   bool isLoading = false;
//   List<Post> items = [];
//
//   void apiPostLike(Post post) async {
//     isLoading = true;
//     update();
//
//     await DBService.likePost(post, true);
//
//     isLoading = false;
//     post.liked = true;
//     update();
//
//     var owner = await DBService.getOwner(post.uid);
//     sendNotificationToLikedMember(owner);
//   }
//
//   void sendNotificationToLikedMember(Member someone) async {
//     Member me = await DBService.loadMember();
//     await Network.POST(Network.API_SEND_NOTIF, Network.notifyLike(me, someone));
//   }
//
//   void apiPostUnLike(Post post) async {
//     isLoading = true;
//     update();
//
//     await DBService.likePost(post, false);
//
//     isLoading = false;
//     post.liked = false;
//     update();
//   }
//
//   apiLoadFeeds() {
//     isLoading = true;
//     update();
//     DBService.loadFeeds().then((value) => {resLoadFeeds(value)});
//   }
//
//   resLoadFeeds(List<Post> posts) {
//     items = posts;
//     isLoading = false;
//     update();
//   }
//
//   dialogRemovePost(Post post, BuildContext context) async {
//     var result = await Utils.dialogCommon(
//         context, "Instagram", "Do you want to delete this post?", false);
//
//     if (result) {
//       isLoading = true;
//       update();
//       DBService.removePost(post).then((value) => {apiLoadFeeds()});
//     }
//   }
// }
