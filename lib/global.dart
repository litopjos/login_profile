import "package:flutter/material.dart";

const ROUTE_USER_PROFILE = "Router User Profile";

Future<void> showAlertDialog(BuildContext ctx, String message) async {
  await showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Container(
                  child: SingleChildScrollView(
                    child: Text(message),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('OK'),
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        );
      });
}
