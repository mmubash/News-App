import 'package:news_app/Models/categories_news_model.dart';
import 'package:news_app/Models/news_channels_headlines_model.dart';
import 'package:news_app/repository/news_reposotry.dart';

class NewsViewModel{

  final _rep=NewsRepostory();
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelApi(String channelName)async{
    final response= await _rep.fetchNewsChannelApi(channelName );
    return response;
  }
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{
    final response= await _rep.fetchCategoriesNewsApi(category );
    return response;
  }
}