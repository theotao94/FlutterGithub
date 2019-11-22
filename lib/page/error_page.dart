import 'package:flutter/material.dart';
import 'package:flutter_github/common/localizations/defult_localizations.dart';
import 'package:flutter_github/common/style/har_style.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  final TextEditingController textEditingController =
  new TextEditingController();

  ErrorPage(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: HARColors.primaryValue,
      child: new Center(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: width,
          decoration: new BoxDecoration(
            color: Colors.white.withAlpha(30),
            gradient:
            RadialGradient(tileMode: TileMode.mirror, radius: 0.1, colors: [
              Colors.white.withAlpha(10),
              HARColors.primaryValue.withAlpha(100),
            ]),
            borderRadius: BorderRadius.all(Radius.circular(width / 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image(
                  image: new AssetImage(HARICons.DEFAULT_USER_ICON),
                  width: 90.0,
                  height: 90.0),
              new SizedBox(
                height: 11,
              ),
              Material(
                child: new Text(
                  "Error Occur",
                  style: new TextStyle(fontSize: 24, color: Colors.white),
                ),
                color: HARColors.primaryValue,
              ),
              new SizedBox(
                height: 40,
              ),
              new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new FlatButton(
                      color: HARColors.white.withAlpha(100),
                      onPressed: () {
                        String content = errorMessage;
                        textEditingController.text = content;
                        //TODO 错误弹框提示
//                        CommonUtils.showEditDialog(
//                            context,
//                            HAYLocalization.i18n(context).home_reply,
//                                (title) {}, (res) {
//                          content = res;
//                        }, () {
//                          if (content == null || content.length == 0) {
//                            return;
//                          }
////                          CommonUtils.showLoadingDialog(context);
////                          IssueDao.createIssueDao(
////                              "CarGuo", "gsy_github_app_flutter", {
////                            "title": HAYLocalization.i18n(context).home_reply,
////                            "body": content
////                          }).then((result) {
////                            Navigator.pop(context);
////                            Navigator.pop(context);
////                          });
//                        },
//                            titleController: new TextEditingController(),
//                            valueController: textEditingController,
//                            needTitle: false);
                      },
                      child: Text("Report")),
                  new SizedBox(
                    width: 40,
                  ),
                  new FlatButton(
                      color: HARColors.white.withAlpha(100),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Back"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}