import 'package:ai_app/Widgets/promptbar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'API/chatgptapi.dart';

class HomeScreenTabs extends StatefulWidget {
  final bool chatgpt;
  HomeScreenTabs({super.key, required this.chatgpt});

  @override
  State<HomeScreenTabs> createState() => _HomeScreenTabsState();
}

class _HomeScreenTabsState extends State<HomeScreenTabs>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _loading = false;
  final List ques = [];
  final List ans = [];

  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void onpressed(TextEditingController _promptcontroller) async {
    final prompt = _promptcontroller.text;
    if (prompt.trim().isNotEmpty) {
      _scrollController.animateTo(1,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
      setState(() {
        _loading = true;
      });
      setState(() {
        ques.add(prompt);
      });

      _promptcontroller.clear();
      final ans1 = widget.chatgpt
          ? await chatgptapi().chatgpt(prompt)
          : await chatgptapi().dallai(prompt);
      setState(() {
        ans.add(ans1);
      });

      // print(_promptcontroller.text);
      setState(() {
        _loading = false;
      });
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Please Enter Some Text",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            child: SafeArea(
              child: Container(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: SizedBox(
                          width: 200,
                          child: Image.asset(
                            widget.chatgpt
                                ? "lib/assets/images/avatar.png"
                                : "lib/assets/images/avatar2.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInRight(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: MediaQuery.of(context).size.width,
                          constraints: const BoxConstraints(
                            maxWidth: 563,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              )
                            ],
                            color: widget.chatgpt
                                ? const Color.fromRGBO(110, 204, 175, 1)
                                : const Color.fromRGBO(190, 173, 250, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.chatgpt ? "Chat-Gpt" : "Dall-E",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  widget.chatgpt
                                      ? "ChatGPT is an artificial intelligence (AI) chatbot that uses natural language processing to create humanlike conversational dialogue."
                                      : "DALL-E is a generative AI model developed by OpenAI, designed to generate images from text description prompts",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ques.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                constraints: const BoxConstraints(
                                  maxWidth: 563,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ques[index],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 15),
                                    Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 563,
                                      ),
                                      padding:
                                          ((_loading) && (index == ans.length))
                                              ? const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                )
                                              : const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            topLeft: Radius.circular(0),
                                          )),
                                      child: ((_loading) &&
                                              (index == ans.length))
                                          ? LoadingAnimationWidget.waveDots(
                                              color: Colors.black, size: 50)
                                          : widget.chatgpt
                                              ? Text(
                                                  ans[index],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: ans[index],
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          LoadingAnimationWidget
                                                              .waveDots(
                                                                  color: Colors
                                                                      .black,
                                                                  size: 50),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Text(
                                                    "Can't load image",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                      // Image.network(ans[index]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          promptbar(
            loading: _loading,
            onpressed: onpressed,
          )
        ],
      ),
    );
  }
}
