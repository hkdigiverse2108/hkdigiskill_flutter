import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/blog/blog_model.dart';
import 'package:hkdigiskill/app/utils/globals.dart';

class BlogDetailsController extends GetxController {
  var title = "Crafting Effective Learning Guide Line".obs;
  var date = "15 Nov, 2023".obs;
  var comments = 0.obs;
  var imageUrl =
      "https://images.unsplash.com/photo-1515378791036-0648a3ef77b2".obs;
  var description =
      '''Consectetur adipisicing elit, sed do eiusmod tempor inc idid unt ut labore et dolore magna aliqua enim ad minim veniam, quis nostrud exercetation ullamco laboris nisi aliquip commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur enim ipsum voluptatem quia voluptas sit aspernatur aut adit aut fugit sed quia consequuntur magni dolores.

Excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est.'''
          .obs;
  var quote =
      "Lorem ipsum dolor amet con sectur eltiadicing elit sed do usmod tempor uniciidunt enim minim veniam nostrud."
          .obs;
  var quoteAuthor = "Simon Baker".obs;
  List<String> tags = ["Design", "Development"].obs;

  @override
  void onInit() {
    super.onInit();
    BlogModel blog = Get.arguments;
    title.value = blog.title;
    date.value = Globals.formatDate(blog.updatedAt);
    // comments.value = blog.comments;
    imageUrl.value = blog.coverImage;
    description.value = blog.content;
    quote.value =
        blog.quote ??
        "Lorem ipsum dolor amet con sectur eltiadicing elit sed do usmod tempor uniciidunt enim minim veniam nostrud.";
    quoteAuthor.value = blog.author;
    tags = [blog.category].obs;
    // tags = blog.tags;
  }
}
