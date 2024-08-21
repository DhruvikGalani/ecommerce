import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_api/SecondIndexPage.dart';
import 'package:ecommerce_api/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';

class firstPage extends StatefulWidget {
  const firstPage({super.key});

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    var url = Uri.https('dummyjson.com', 'products');
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    Map mapApi = jsonDecode(response.body);
    ApiList = List.from(mapApi["products"]);
    tempList = List.from(ApiList);
    // print("map=======  $mapApi");
    // print("Api=======  $ApiList");

    var cateurl = Uri.https('dummyjson.com', '/products/category-list');
    var cateresponse = await http.get(cateurl);
    print('Response status: ${cateresponse.statusCode}');
    print('Response body: ${cateresponse.body}');
    List<String> l = List.from(jsonDecode(cateresponse.body));
    print("l == = ${List.from(jsonDecode(cateresponse.body))}");
    cateList = ['All'] + List.from(l);
    print(cateList);
    setState(() {});
  }

  List<String> imList = [
    'asset/img/im1.jpg',
    'asset/img/im2.jpg',
    'asset/img/im3.jpg',
    'asset/img/im4.jpg',
    'asset/img/im5.jpg',
    'asset/img/im6.jpg',
  ];

  ItemScrollController itemScrollController = ItemScrollController();
  int tempind = 0;
  @override
  Widget build(BuildContext context) {
    return (cateList.length > 1)
        ? Scaffold(
            backgroundColor: Colors.white,
            drawer: Drawer(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ), //BoxDecoration
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.black),
                      accountName: Text(
                        "Dhruvik Galani",
                        style: TextStyle(fontSize: 18),
                      ),
                      accountEmail: Text("dgalani03@gmail.com"),
                      currentAccountPictureSize: Size.square(50),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          "A",
                          style: TextStyle(fontSize: 30.0, color: Colors.black),
                        ), //Text
                      ), //circleAvatar
                    ), //UserAccountDrawerHeader
                  ), //DrawerHeader
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(' My Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text(' My Course '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.workspace_premium),
                    title: const Text(' Go Premium '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.video_label),
                    title: const Text(' Saved Videos '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text(' Edit Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('LogOut'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text(
                "BazaarByte",
              ),
              actions: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.black,
                  ),
                ),
              ],
              centerTitle: true,
            ),
            body: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CupertinoTextField(
                        onChanged: (value) {
                          setState(() {
                            tempind = 0;
                            print("tempind :: $tempind");
                            print("val : $value");
                            log("temp : ${tempList[0]}");
                            if (tempList.isNotEmpty) {
                              ApiList = tempList
                                  .where((element) => element['title']
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toString().toLowerCase()))
                                  .toList();
                            }
                            print("ap : $ApiList");
                          });
                        },
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500.withOpacity(.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.all(15),
                        cursorWidth: 2,
                        cursorRadius: Radius.circular(10),
                        cursorColor: Colors.white38,
                        cursorOpacityAnimates: true,
                        prefix: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Icon(
                            CupertinoIcons.search,
                            color: Colors.white60,
                            size: 20,
                          ),
                        ),
                        placeholder: "Find your favorite recipe...",
                        placeholderStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GFCarousel(
                      items: imList.map(
                        (url) {
                          return (cateList.length > 1)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 200,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        child: Image.asset(
                                          "$url",
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.fill,
                                        )),
                                  ))
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: shimmerContainer(100, null),
                                );
                        },
                      ).toList(),
                      initialPage: 0,
                      pagerSize: 10,
                      viewportFraction: .8,
                      activeIndicator: Color(0xffe3bc8a),
                      passiveIndicator: Colors.transparent,
                      passiveDotBorder:
                          Border.all(color: Colors.black, width: .6),
                      hasPagination: true,
                      activeDotBorder:
                          Border.all(color: Colors.black, width: .6),
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      autoPlayCurve: Curves.easeInToLinear,
                      autoPlay: true,
                      reverse: false,
                      autoPlayInterval: Duration(seconds: 3),
                      pauseAutoPlayOnTouch: Duration(seconds: 5),
                      onPageChanged: (index) {
                        setState(() {
                          index;
                        });
                      },
                    ),
                    StatefulBuilder(
                      builder: (context, setState1) {
                        return SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: ScrollablePositionedList.builder(
                              itemScrollController: itemScrollController,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  (cateList.length > 1) ? cateList.length : 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, ind) {
                                return (cateList.length > 1)
                                    ? methodlist(ind, setState1)
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: shimmerContainer(2, 70),
                                      );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            itemCount:
                                (cateList.length > 1) ? ApiList.length : 6,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 3.4,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: (MediaQuery.of(context)
                                                .size
                                                .width /
                                            2) /
                                        (MediaQuery.of(context).size.height /
                                            3.2)),
                            itemBuilder: (context, index) {
                              return (cateList.length > 1)
                                  ? listView_Method(
                                      index,
                                      (MediaQuery.of(context).size.width / 2),
                                      (MediaQuery.of(context).size.height /
                                          3.2))
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: shimmerContainer(null, null),
                                    );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        : Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ), //BoxDecoration
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.black),
                      accountName: Text(
                        "Dhruvik Galani",
                        style: TextStyle(fontSize: 18),
                      ),
                      accountEmail: Text("dgalani03@gmail.com"),
                      currentAccountPictureSize: Size.square(50),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          "A",
                          style: TextStyle(fontSize: 30.0, color: Colors.black),
                        ), //Text
                      ), //circleAvatar
                    ), //UserAccountDrawerHeader
                  ), //DrawerHeader
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(' My Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text(' My Course '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.workspace_premium),
                    title: const Text(' Go Premium '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.video_label),
                    title: const Text(' Saved Videos '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text(' Edit Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('LogOut'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text(
                "BazaarByte",
              ),
              actions: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.black,
                  ),
                ),
              ],
              centerTitle: true,
            ),
            body: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: shimmerContainer(50, null),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GFCarousel(
                      items: imList.map(
                        (url) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: shimmerContainer(100, null),
                          );
                        },
                      ).toList(),
                      initialPage: 0,
                      pagerSize: 10,
                      viewportFraction: .8,
                      activeIndicator: Color(0xffe3bc8a),
                      passiveIndicator: Colors.transparent,
                      passiveDotBorder:
                          Border.all(color: Colors.black, width: .6),
                      hasPagination: true,
                      activeDotBorder:
                          Border.all(color: Colors.black, width: .6),
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      autoPlayCurve: Curves.easeInToLinear,
                      autoPlay: true,
                      reverse: false,
                      autoPlayInterval: Duration(seconds: 3),
                      pauseAutoPlayOnTouch: Duration(seconds: 5),
                      onPageChanged: (index) {
                        setState(() {
                          index;
                        });
                      },
                    ),
                    StatefulBuilder(
                      builder: (context, setState1) {
                        return SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: ScrollablePositionedList.builder(
                              itemScrollController: itemScrollController,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, ind) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: shimmerContainer(2, 70),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            itemCount: 6,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 3.4,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: (MediaQuery.of(context)
                                                .size
                                                .width /
                                            2) /
                                        (MediaQuery.of(context).size.height /
                                            3.2)),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: shimmerContainer(null, null),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget methodlist(int ind, StateSetter setState1) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            radius: 20,
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              setState1(() {
                itemScrollController.scrollTo(
                    index: ind, duration: Duration(milliseconds: 1300));
                tempind = ind;
              });
              if (tempind == 0) {
                setState1(() {
                  ApiList = List.from(tempList);
                });
              } else {
                ApiList.clear();
                if (cateList.length > 1) {
                  var url = Uri.https(
                      'dummyjson.com', '/products/category/${cateList[ind]}');
                  var response = await http.get(url);
                  print("---------------  ${response.body}");
                  setState1(() {
                    Map mapApi = jsonDecode(response.body);
                    ApiList = List.from(mapApi["products"]);
                  });
                }
              }
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                "${cateList[ind]}",
                style: TextStyle(
                  color: (ind == tempind) ? Colors.black87 : Colors.black12,
                  fontSize: 18,
                  fontWeight:
                      (ind == tempind) ? FontWeight.w500 : FontWeight.w400,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Container(
              height: (ind == tempind) ? 2.5 : 0,
              width: (ind == tempind) ? 15 : 0,
              decoration: (ind == tempind)
                  ? BoxDecoration(
                      color: Color(0xff2F7C2c),
                      borderRadius: BorderRadius.circular(5))
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget listView_Method(int index, double width, double hieght) {
    final _ratingController = TextEditingController();
    double rating = double.parse("${ApiList[index]['rating']}");

    return StatefulBuilder(
      builder: (BuildContext context, setState1) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, CupertinoModalPopupRoute(
                builder: (context) {
                  return secondPage(index: index);
                },
              ));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 130),
              decoration: BoxDecoration(
                color: Colors.white, // Container background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffC4C1C1)
                        .withOpacity(.15), // Box shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 3, // Blur radius
                    offset: const Offset(.95, 0), // Offset
                  ),
                  BoxShadow(
                      color:
                          Colors.black12.withOpacity(.30), // Box shadow color
                      spreadRadius: .5, // Spread radius
                      blurRadius: 4.5,
                      offset: const Offset(0, 1.89) // Blur radius
                      ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: Image.network(
                        '${ApiList[index]['thumbnail']}',
                        width: double.maxFinite,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.black12,
                                strokeWidth: 2.4,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${ApiList[index]['title']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            GFRating(
                              color: const Color(0xeacb991c),
                              borderColor: const Color(0xeacb991c),
                              value: rating,
                              size: 15,
                              allowHalfRating: true,
                              controller: _ratingController,
                              onChanged: (value) {
                                setState1(() {
                                  print("object1  $rating");
                                  print("object1 === $value");
                                  rating = value;
                                });
                              },
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              '${rating.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '\$${ApiList[index]['price']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget shimmerContainer(double? heigth, double? width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: width ?? double.maxFinite,
        height: heigth ?? double.maxFinite,
      ),
    );
  }
}
