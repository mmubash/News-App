import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news_app/Models/categories_news_model.dart';

import 'package:news_app/Models/news_channels_headlines_model.dart';

class NewsRepostory{
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelApi (String newsChannel)async{
    String newsUrl = 'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=be7456974b5949c79c239ae5632d22f2';
    print(newsUrl);
    final response= await http.get(Uri.parse(newsUrl));
    print(response.statusCode.toString());
    print(response);
  if(response.statusCode==200){
    final body =jsonDecode(response.body);
   return NewsChannelsHeadlinesModel.fromJson(body);
  }else
  {throw('Erorr');}
  }


  Future<CategoriesNewsModel> fetchCategoriesNewsApi (String category)async{
    String newsUrl = 'https://newsapi.org/v2/everything?q=${category}&apiKey=be7456974b5949c79c239ae5632d22f2';
    print(newsUrl);
    final response= await http.get(Uri.parse(newsUrl));
    print(response.statusCode.toString());
    print(response);
    if(response.statusCode==200){
      final body =jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }else
    {throw('Erorr');}
  }
}