import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Models/news_channels_headlines_model.dart';
import 'package:news_app/category_Screen.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList{bbcNews,aryNews,alJazeera}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd,yyyy');

  String name ='bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesScreen()));
            },
            icon: Image.asset(
              'images/category_icon.png',
              height: 20,
              width: 20,
            )),
        title: Text(
          'NEWS',

          style: GoogleFonts.poppins(
            fontSize: 24,

          ),
        ),
        centerTitle: true,
        actions: [
                  PopupMenuButton<FilterList>(
                    initialValue: selectedMenu,
                      icon: Icon(Icons.more_vert,color: Colors.black,),
                      onSelected: (FilterList item){
                      if(FilterList.bbcNews.name==item.name){
                         name='bbc-news';
                      }
                      if(FilterList.aryNews.name==item.name){
                        name='ary-news';
                      }
                      if(FilterList.alJazeera.name==item.name){
                        name='al-jazeera-english';
                      }
                      setState(() {
                        selectedMenu =item;
                      });
                      },
                      itemBuilder: (BuildContext context)=> <PopupMenuEntry<FilterList>>[
                          PopupMenuItem<FilterList>(
                              value: FilterList.bbcNews,
                              child: Text("BBC News")),
                        PopupMenuItem<FilterList>(
                            value: FilterList.aryNews,
                            child: Text("ARY News")),
                        PopupMenuItem<FilterList>(
                            value: FilterList.alJazeera,
                            child: Text("Al Jazeera")),
                      ]
                  )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelApi(name),
                builder: (BuildContext context, snapshot,) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitDancingSquare(
                        size: 40,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return SizedBox(
                            child: Stack(
                              children: [
                                Container(
                                  height: height * .6,
                                  width: width * .9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: Colors.grey, // Placeholder color
                                        child: Center(
                                          child: SpinKitDancingSquare(
                                            size: 40,
                                            color: Colors.blue, // Spinner color
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline,
                                              color: Colors.red),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(15),
                                      height: height * .22,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 25, top: 20, bottom: 20),
                                            width: width * .7,
                                            child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                )),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * .7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                    )),
                                                Text(format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
