import 'dart:convert';

import 'package:ecommerce_api/frstPage.dart';
import 'package:ecommerce_api/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

class secondPage extends StatefulWidget {
  int index;
  secondPage({required this.index});

  @override
  State<secondPage> createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagesList = List.from(ApiList[widget.index]['images']);
    // init();
  }

  void init() {
    print("lengh : ${(ApiList[widget.index]['images'])}");

    String slist = " ${ApiList[widget.index]['images']}";
    String one = slist.replaceAll("[", "");
    String two = one.replaceAll(" ", "");
    String three = two.replaceAll("]", "");
    imagesList = three.split(",");
    print("dgsd =${slist}");
    print("object  vcxbx  =${imagesList}");

    for (int i = 0; i < imagesList.length; i++) {
      print("\n ${imagesList[i]}");
    }
  }

  List imagesList = [];
  @override
  Widget build(BuildContext context) {
    double rating = double.parse("${ApiList[widget.index]['rating']}");
    final _ratingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 3,
        // scrolledUnderElevation: 8,
        leading: IconButton(
            onPressed: () {
              ApiList.addAll(tempList);
              Navigator.pushReplacement(context, CupertinoModalPopupRoute(
                builder: (context) {
                  return const firstPage();
                },
              ));
            },
            splashRadius: 20,
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        title: Text("${ApiList[widget.index]['title']}"),
      ),
      body: Column(children: [
        Expanded(
            child: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        '${ApiList[widget.index]['thumbnail']}',
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
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Description : ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "${ApiList[widget.index]['description']}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                    child: GFCarousel(
                      items: imagesList.map(
                        (url) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 700),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    child: Image.network(
                                      url,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.contain,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black12,
                                              strokeWidth: 2.4,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    )),
                              ));
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
                  ),
                ]),
          ),
        )),
        Container(
          width: double.maxFinite,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "BRAND  ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffe3bc8a),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${ApiList[widget.index]['brand']}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "CATEGORY",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffe3bc8a),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          " ${ApiList[widget.index]['category']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "STOCK",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffe3bc8a),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          " ${ApiList[widget.index]['stock']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    StatefulBuilder(
                      builder: (BuildContext context, setState1) {
                        return Row(
                          children: [
                            GFRating(
                              color: const Color(0xffe3bc8a),
                              borderColor: const Color(0xffe3bc8a),
                              value: rating,
                              size: 20,
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
                            const SizedBox(width: 6.0),
                            Text(
                              '${rating.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Up to  ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffe3bc8a),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${ApiList[widget.index]['discountPercentage']} %",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "PRICE",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffe3bc8a),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "\$ ${ApiList[widget.index]['price']}",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GFButton(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        elevation: 3,
                        textColor: Colors.black,
                        size: 40,
                        color: const Color(0xffe3bc8a),
                        onPressed: () {},
                        text: "Add to Cart",
                        icon: const Icon(
                          size: 17,
                          Icons.add_shopping_cart_outlined,
                          color: Colors.black,
                        ),
                        shape: GFButtonShape.pills,
                      ),
                    ]),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
