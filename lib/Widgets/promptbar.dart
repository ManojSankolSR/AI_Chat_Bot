import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class promptbar extends StatefulWidget {
  final bool loading;
  final void Function(TextEditingController _promptcontroller) onpressed;
  promptbar({super.key, required this.loading, required this.onpressed});

  @override
  State<promptbar> createState() => _promptbarState();
}

class _promptbarState extends State<promptbar> {
  final TextEditingController _promptcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned(
        bottom: 0,
        child: FadeInUp(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            // height: 50,
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
              maxWidth: 563,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      readOnly: widget.loading,
                      controller: _promptcontroller,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: "Enter Your Prompt",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.loading
                      ? null
                      : () {
                          widget.onpressed(_promptcontroller);
                        },
                  child: Container(
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: widget.loading
                        ? LoadingAnimationWidget.dotsTriangle(
                            color: Colors.white, size: 30)
                        : Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
