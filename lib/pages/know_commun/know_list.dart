import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/refresh/refresh_footer_ex.dart';
import 'package:sunset/components/refresh/refresh_header_ex.dart';
import 'package:sunset/components/tabbar.dart';
import 'package:sunset/components/toast.dart';
import 'package:sunset/utils/api/know_req.dart';
import 'package:sunset/utils/request.dart';

class KnowList extends StatefulWidget {
  const KnowList({Key? key}) : super(key: key);

  @override
  _KnowListState createState() => _KnowListState();
}

class _KnowListState extends State<KnowList> {
  List list = [];
  int total = 0;
  Map<String, dynamic> pageMap = {"page_num": 1, "page_rows": 12};
  KnowReq knowReq = new KnowReq();

  void initState() {
    super.initState();
    getKnow();
  }

  // 列表
  Future<IndicatorResult> getKnow() async {
    try {
      Map res = await knowReq.getKnow(pageMap);
      print("分页>>${pageMap}");
      if (res["code"] == 200) {
        list.insertAll(list.length, res["data"]["list"]);
        total = res["data"]["total"];
        if (mounted) {
          setState(() {});
        }
        return IndicatorResult.success;
      }else{
        return IndicatorResult.fail;
      }
    } catch (e) {
      print(e);
      errToast();
      return IndicatorResult.fail;
    }
  }

  // 去详情
  void toPage(arg) {
    Navigator.pushNamed(context, "knowDetail", arguments: {
      "isthird": arg["isthird"],
      "url": arg["url"],
      "id": arg["id"]
    });
  }
 // 加载 刷新控制器
  EasyRefreshController _controller  = new EasyRefreshController(
    controlFinishRefresh: false,
    controlFinishLoad: false,
  );

  // 上拉加载
  Future<IndicatorResult> onLoad() async{
    pageMap["page_num"]++;
    if (list.length >= total) {
      return IndicatorResult.noMore;
    } else {
      IndicatorResult status = await getKnow();
      return status;
    }
  }
  // 下拉刷新
  Future<IndicatorResult> onRefresh() async{
    list = [];
    pageMap["page_num"] = 1;
    IndicatorResult status = await getKnow();
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomTabBar(title: "知识社区", bgColor: null, fontColor: null),
          Expanded(
              child: Container(
                  child: EasyRefresh(
                      header: RefreshHeaderEx(),
                      footer: RefreshFooterEx(),
                      onRefresh: onRefresh,
                      onLoad: onLoad,
                      controller: _controller ,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: list.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7.5, horizontal: 15),
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
                                              errorBuilder: (ctx, err,
                                                      stackTrace) =>
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
                                              alignment: Alignment.topLeft,
                                              height: 60,
                                              child: Text(
                                                list[index]["title"],
                                                softWrap: true,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffcccccc)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: Text(
                                                      list[index]["type_name"],
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffcccccc),
                                                          fontSize: 12)),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  constraints: BoxConstraints(
                                                      maxWidth: 64),
                                                  child: Text(
                                                      "${list[index]["read_num"].toString()} 阅读",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffcccccc),
                                                          fontSize: 13)),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  margin: EdgeInsets.only(
                                                      right: 40),
                                                  constraints: BoxConstraints(
                                                      maxWidth: 64),
                                                  child: Text(
                                                      "${list[index]["like_num"].toString()} 收藏",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffcccccc),
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
                                onTap: () => toPage(list[index]));
                          }))))
        ],
      ),
    );
  }
}
