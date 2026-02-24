import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' show HtmlWidget;
import '../constant/my_color.dart';
import '../constant/my_fonts_style.dart';

class GrowingActivityScr extends StatefulWidget {
  String? title;
  String? description;

  GrowingActivityScr({super.key, this.title, this.description});

  @override
  State<GrowingActivityScr> createState() => _GrowingActivityScrState();
}

class _GrowingActivityScrState extends State<GrowingActivityScr> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.description${widget.description}");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(">>>> Description 02 :- ${widget.description} <<<");
     final bool isTab = MediaQuery.of(context).size.width > 600 ;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.yellowF6F1E1,
        surfaceTintColor: MyColor.yellowF6F1E1,
        toolbarHeight: isTab ?80 :60,
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          radius: 80,
          onTap: () {
            Navigator.pop(context);
            //  widget.onCallBack();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child:  Icon(
              Icons.arrow_back_ios,
              size: isTab ?32 : 28,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(widget.title.toString(),
            style: mediumTextStyle(fontSize: isTab ?25.0 : 18.0, color: MyColor.black)),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        child: widget.description == null ||
            widget.description!.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Html(
            data: cleanHtml(widget.description!),
            style: {
              "p": Style(
                fontSize: FontSize(18),
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
              ),
              "img": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                display: Display.block,
              ),
            },
            extensions: [
              TagExtension(
                tagsToExtend: {"img"},
                builder: (context) {
                  final src = context.attributes['src'];

                  if (src == null) {
                    return const SizedBox();
                  }

                  return Image.network(
                    src,
                    width: MediaQuery.of(context.buildContext!).size.width,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 40),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String cleanHtml(String html) {
    return html
    // remove <br> after images
        .replaceAll(RegExp(r'<br\s*/?>'), '')
    // remove empty paragraphs
        .replaceAll(RegExp(r'<p>\s*</p>'), '')
    // remove span wrapping breaks
        .replaceAll(RegExp(r'<span[^>]*>\s*</span>'), '');
  }
}
