import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/know_req.dart';
import 'package:sunset/utils/request.dart';

class MyLike extends StatefulWidget {
  const MyLike({Key? key}) : super(key: key);

  @override
  _MyLikeState createState() => _MyLikeState();
}

class _MyLikeState extends State<MyLike> {

  List list = [];
  int total = 0;
  bool isPoint = false;
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 100};
  KnowReq knowReq = new KnowReq();

  void initState() {
    super.initState();
    this.getMyLike();
  }

  // 我的收藏列表
  void getMyLike() async {
    try {
      Map res = await knowReq.getMyLike(pageMap);
      print("我的收藏>>${res["data"]}");
      if (res["code"] == 200) {
        list.insertAll(list.length, res["data"]["list"]);
        total = res["data"]["total"];
        isPoint = true;
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      errToast();
    }
  }
  // 去详情
  void toPage(arg){
    Navigator.pushNamed(context, "knowDetail", arguments: {
      "isthird": arg["isthird"],
      "url": arg["url"],
      "id": arg["id"]
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "我的收藏", bgColor: null, fontColor: null),
          Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                                    child: Container(
                                      height: 80,
                                      color: Color(0xffeeeeee),
                                      child: Image.network(
                                          list[index]["isthird"] == 1
                                              ? list[index]["cover_img"]
                                              : baseUrl +
                                              list[index]["cover_img"],
                                          fit: BoxFit.cover,
                                          width: 110,
                                          errorBuilder:
                                              (ctx, err, stackTrace) =>
                                              Image.asset(
                                                  'assets/images/lazy.png',
                                                  fit: BoxFit.fill,
                                                  width: 110)),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 60,
                                              child: Text(
                                                list[index]["title"],
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
                                                  child: Text(
                                                      list[index]["type_name"],
                                                      style: TextStyle(
                                                          color: Color(0xffcccccc),
                                                          fontSize: 12)),
                                                ),
                                                Container(
                                                  alignment: Alignment.centerRight,
                                                  constraints:
                                                  BoxConstraints(maxWidth: 64),
                                                  child: Text(
                                                      "${list[index]["read_num"].toString()} 阅读",
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
                                                  child: Text(
                                                      "${list[index]["like_num"].toString()} 收藏",
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
                            onTap: ()=>toPage(list[index]));
                      }))

          )
        ],
      ),
    );
  }
}
