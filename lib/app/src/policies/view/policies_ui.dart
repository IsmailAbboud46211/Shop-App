import 'package:flutter/material.dart';
import 'package:shop_app/app/src/policies/data/app_policies.dart';
import 'package:shop_app/core/extension/media_query.dart';
import 'package:shop_app/core/extension/sized_box.dart';
import 'package:shop_app/core/themes/app_color.dart';

class Policies extends StatelessWidget {
  const Policies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(context.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  maxRadius: context.width / 20,
                  child: Icon(
                    Icons.lock,
                    color: AppColors.softGrey,
                  ),
                ),
                (context.width / 10).pw,
                Text(
                  "App Policies",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: context.width * 0.04,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : AppColors.deepBlue,
                  ),
                ),
              ],
            ),
            (context.height / 20).ph,
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  maxRadius: context.width / 40,
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: AppColors.softGrey,
                                    ),
                                  ),
                                ),
                                (context.width / 10).pw,
                                Expanded(
                                  child: Text(
                                    " ${appPolicies[index]}",
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: context.height * 0.02),
                        itemCount: appPolicies.length),
                    (context.height / 10).ph,
                    ElevatedButton(
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                      child: const Text(
                          //LocaleKeys.ok.tr()
                          "ok"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
