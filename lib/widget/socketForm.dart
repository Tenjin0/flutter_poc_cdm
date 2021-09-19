import 'package:flutter/material.dart';

class SocketForm extends StatefulWidget {
  final Function onValidate;

  const SocketForm({Key? key, required this.onValidate}) : super(key: key);

  @override
  _SocketFormState createState() => _SocketFormState();
}

class _SocketFormState extends State<SocketForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fname = TextEditingController();
  String hostname = "";
  String port = "";
  String namespace = "";

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            Text("Enter URL",
                style: TextStyle(fontSize: 30, color: Color(0xFF363f93))),
            SizedBox(
              height: height * 0.04,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Enter the hostname"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter correct hostname";
                } else {
                  hostname = value;
                  return null;
                }
              },
            ),
            SizedBox(
              height: height * 0.04,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Enter the port"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter correct port";
                } else {
                  port = value;
                  return null;
                }
              },
            ),
            SizedBox(
              height: height * 0.04,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Enter the namespace"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter correct namespace";
                } else {
                  namespace = value;
                  return null;
                }
              },
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF363f93),
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      this.widget.onValidate(hostname, port, namespace);
                    }
                  },
                ),
                // NeumorphicButton(
                //   margin: EdgeInsets.only(top: 12),
                //   onPressed: () {
                //     if (formKey.currentState!.validate()) {
                //       final snackBar =
                //           SnackBar(content: Text("Submitting form"));
                //       _scafffoldkey.currentState!.showSnackBar(snackBar);
                //     }
                //   },
                //   style: NeumorphicStyle(
                //     color: Color(0xFF363f93),
                //     shape: NeumorphicShape.concave,
                //     boxShape: NeumorphicBoxShape.circle(),
                //     border: NeumorphicBorder(
                //       isEnabled: false,
                //       color: Color(0x33000000),
                //       width: 0.8,
                //     ),
                //   ),
                //   child: Icon(Icons.arrow_right, color: Colors.white),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
