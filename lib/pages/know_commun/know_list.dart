import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/tabbar.dart';

class KnowList extends StatefulWidget {
  const KnowList({Key? key}) : super(key: key);

  @override
  _KnowListState createState() => _KnowListState();
}

class _KnowListState extends State<KnowList> {
  List list = ["99", '9', "999+"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "知识社区", bgColor: null, fontColor: null),
          Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: list.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      "https://th.bing.com/th/id/R.83d51b55fc95657f927c3d3d25c62be5?rik=37%2fqxBZ6VRgn%2bw&pid=ImgRaw&r=0",
                                      fit: BoxFit.cover,
                                      width: 110,
                                      height: 80,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Container(
                                          height: 60,
                                          child: Text(
                                            "众里寻他千百度，蓦然回首，那人却在灯火阑珊处",
                                            softWrap: true,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800),
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Color(0xffcccccc)),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Text("饮食",
                                                  style: TextStyle(
                                                      color: Color(0xffcccccc),
                                                      fontSize: 12)),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              constraints:
                                                  BoxConstraints(maxWidth: 64),
                                              child: Text("${list[index]} 阅读",
                                                  style: TextStyle(
                                                      color: Color(0xffcccccc),
                                                      fontSize: 13)),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              margin:
                                                  EdgeInsets.only(right: 40),
                                              constraints:
                                                  BoxConstraints(maxWidth: 64),
                                              child: Text("${list[index]} 收藏",
                                                  style: TextStyle(
                                                      color: Color(0xffcccccc),
                                                      fontSize: 13)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            onTap: () {});
                      })))
        ],
      ),
    );
  }
}
