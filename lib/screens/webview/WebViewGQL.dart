import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../API Services/graphql_service.dart';

class CommonWebViewGraphql extends StatefulWidget {
  final String url;
  final String title;

  const CommonWebViewGraphql(
      {super.key, required this.url,
      required this.title});

  @override
  _CommonWebViewState createState() => _CommonWebViewState();

}

class _CommonWebViewState extends State<CommonWebViewGraphql> {

  GraphQLService graphQLService = GraphQLService();

  String htmlData =
      """<div class=\"about-us-block\">\r\n<div class=\"about-us-block-image-outer\"><img src=\"https://staging2.omaliving.com/media/wysiwyg/aboutusbanner.jpg\" alt=\"\" width=\"100%\"></div>\r\n<div class=\"about-content-block\">\r\n<h1>ABOUT US</h1>\r\n<p>OMA is one of India’s most exclusive luxury lifestyle destinations with its iconic bouquet of décor, art and furniture. At OMA, we celebrate beauty in all its shades and nuances. It is our ode to the creative spirit of the universe, nurturing the unique and special talents from the world of art and design.</p>\r\n<p>Thoughtfully curated, every element of the OMA experience is special and signature, such that it becomes forever memorable and irreplaceable.</p>\r\n<p>As you inspire us, we hope OMA inspires you to design your personal universe of beauty and joy.</p>\r\n<div class=\"cercleOnly\">\r\n<div class=\"bannerHeading\">A LIFE <br>OF <br>BEAUTY</div>\r\n</div>\r\n</div>\r\n<div class=\"container\">\r\n<div class=\"row\">\r\n<div class=\"col span_7\"><img src=\"https://staging2.omaliving.com/media/wysiwyg/immersiveexperience.jpg\" alt=\"\"></div>\r\n<div class=\"col span_5\">\r\n<div class=\"imageCaptions\">\r\n<p>AN IMMERSIVE EXPERIENCE THAT <br>ELEVATES AND INSPIRES</p>\r\n<p>UNFOLDS A SENSE OF DISCOVERY</p>\r\n<p>REVEALS NEW TREASURES <br>EACH TIME</p>\r\n<p>CELEBRATES LIFE WITH FLAIR</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"row lifestryle-block\">\r\n<div class=\"col span_12\">\r\n<p>A LIFESTYLE<br>AN EXPERIENCE<br>A STATE OF MIND<br>A MODERN VOICE<br>A DESIGN GALLERY</p>\r\nOMA'S EVOLUTION</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"an-ode-to-creative-energy\">\r\n<div class=\"container-fluid\">\r\n<div class=\"row\">\r\n<div class=\"col span_12\">\r\n<figure><!--figcaption>AN ODE TOCREATIVE ENERGY</figcaption--><img src=\"https://staging2.omaliving.com/media/wysiwyg/13years.jpg\" alt=\"\" width=\"100%\"></figure>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"love-support-block\">\r\n<div class=\"container\">\r\n<ul>\r\n<li><img style=\"display: none;\" src=\"https://staging2.omaliving.com/media/wysiwyg/an-ode-to-creative-energy02.jpg\" alt=\"\"></li>\r\n<li><img style=\"display: none;\" src=\"https://staging2.omaliving.com/media/wysiwyg/an-ode-to-creative-energy03.jpg\" alt=\"\"></li>\r\n</ul>\r\n<div class=\"years-of-yours\">\r\n<div class=\"years-of-border\"><span class=\"count\">13</span> <span class=\"count-text\">YEARS OF YOUR<br>LOVE &amp; SUPPORT</span></div>\r\n</div>\r\n<img style=\"display: none;\" src=\"https://staging2.omaliving.com/media/wysiwyg/love-support01.jpg\" alt=\"\">\r\n<div class=\"image-caption transforming\">TRANSFORMING EVERY<br>EXPERIENCE INTO THE <br>EXTRAORDINARY</div>\r\n</div>\r\n<div class=\"our-values\">\r\n<div class=\"container\">\r\n<h2>OUR VALUES</h2>\r\n<div class=\"row\" style=\"margin-top: 0;\">\r\n<div class=\"container-inner\">\r\n<div class=\"col span_6\"><img src=\"https://staging2.omaliving.com/media/wysiwyg/inspiredcuration.jpg\" alt=\"\"><img style=\"display: none;\" src=\"<img\" alt=\"\">\"</div>\r\n<div class=\"col span_6\">\r\n<div class=\"our-values-content\">\r\n<div class=\"block-heading\">Inspired<br>curation</div>\r\n<p>a masterful selection of unique <br>and iconic pieces that befit <br>the urban sophisticate's lifestyle</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"row\">\r\n<div class=\"container-inner\">\r\n<div class=\"col span_6\">\r\n<div class=\"our-values-content\">\r\n<div class=\"block-heading\">impassioned devotion</div>\r\n<p>devoted to customer delight, <br>with a passion to deliver <br>an international experience</p>\r\n</div>\r\n</div>\r\n<div class=\"col span_6\"><img src=\"https://staging2.omaliving.com/media/wysiwyg/impassioneddevotion.jpg\" alt=\"\"></div>\r\n</div>\r\n</div>\r\n<div class=\"row\">\r\n<div class=\"container-inner\">\r\n<div class=\"col span_6\"><img src=\"https://staging2.omaliving.com/media/wysiwyg/welltemperedspirit.jpg\" alt=\"\"></div>\r\n<div class=\"col span_6\">\r\n<div class=\"our-values-content\">\r\n<div class=\"block-heading\">well-tempered spirit</div>\r\n<p>a rare, signature balance: <br>lush yet sublime <br>lavish yet personal <br>luxurious yet inviting</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"row\">\r\n<div class=\"container-inner\">\r\n<div class=\"col span_6\">\r\n<div class=\"our-values-content\">\r\n<div class=\"block-heading\">impeccably detailed</div>\r\n<p>immaculate finesse <br>as the hallmark of the brand, <br>lending it an unmistakeable <br>reputation</p>\r\n</div>\r\n</div>\r\n<div class=\"col span_6\"><img src=\"https://staging2.omaliving.com/media/wysiwyg/impeccablydetailed.jpg\" alt=\"\"></div>\r\n</div>\r\n</div>\r\n<div class=\"row\">\r\n<div class=\"container-inner\">\r\n<div class=\"col span_6\"><img src=\"https://staging2.omaliving.com/media/wysiwyg/signaturecharacter.jpg\" alt=\"\"></div>\r\n<div class=\"col span_6\">\r\n<div class=\"our-values-content\">\r\n<div class=\"block-heading\">signature character</div>\r\n<p>a distinct brand persona <br>that reveals itself through <br>signature products <br>and an inviting experience</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<!--div class=\"row lifestryle-block\">\r\n<div class=\"col span_12\">\r\n<p>BEAUTY<br>CELEBRATION<br>INSPIRATION<br>DISCOVERY<br>PLEASURE<br>CREATIVITY<br>JOY</p>\r\nthe soul of OMA</div>\r\n</div--></div>\r\n</div>\r\n</div>\r\n<!--div class=\"beauty-category about-us-timeless\">\r\n<div class=\"container\">\r\n<div class=\"row\">\r\n<div class=\"col span_12\">\r\n<div class=\"beauty-img-block\"><img style=\"display: none; margin: 0px  auto;\" src=\"https://staging2.omaliving.com/media/wysiwyg/an-ode-to-creative-energy01.jpg\" alt=\"\"></div>\r\n<div class=\"image-caption\">A TIMELESS<br>CONTEMPORARY <br>NARRATIVE</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div-->\r\n<style>\r\n   @media only screen and (max-width:767px) { \r\n    .design-story-content span.design-story-square:before,\r\n    .design-story-content span.design-story-square:after,\r\n    .creative-energy .blockHeading:before,\r\n    .creative-energy .blockHeading:after,\r\n    .content-block:before,\r\n    .content-block:after,\r\n    .beauty-img-block:before,\r\n    .beauty-img-block:after,\r\n    .imageCaptions:before,\r\n    .imageCaptions:after,\r\n    .years-of-yours:before,\r\n    .years-of-yours:after,\r\n    .image-caption:before,\r\n    .image-caption:after,\r\n    .our-values h2:before,\r\n    .our-values .row:before {\r\n        height: 3px;\r\n\r\n    }\r\n\r\n    .years-of-yours:before,\r\n    .years-of-yours:after {\r\n        height: 3px;\r\n        width: 96%;\r\n    }\r\n    .vasesjars .col {\r\n        padding: 0px 0px;\r\n    }\r\n    .design-story-content span.design-story-square span.border-left-right:before, .design-story-content span.design-story-square span.border-left-right:after, .years-of-border:before, .years-of-border:after{\r\n    width: 3px;\r\n    }\r\n    \r\n    \r\n}\r\n</style>""";

  dynamic getcustomwebview = [];

  @override
  void initState() {
    super.initState();
    getNavdata();
  }

  void getNavdata() async {
    print(widget.url);
    getcustomwebview = await graphQLService.getcustomwebview(widget.url);
    setState(() {});
    print(getcustomwebview.data?['cmsPage']['content']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black, size: 20),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:

                getcustomwebview.data['cmsPage']['content'] != null ?
                HtmlWidget(
                  getcustomwebview.data?['cmsPage']['content'],
                  customStylesBuilder: (element) {
                    if (element.classes.contains('foo')) {
                      return {'color': 'red'};
                    }
                    return null;
                  },
                  onErrorBuilder: (context, element, error) =>
                      Text('$element error: $error'),
                  onLoadingBuilder: (context, element, loadingProgress) =>
                      const CircularProgressIndicator(),
                  renderMode: RenderMode.column,
                  // set the default styling for text
                  textStyle: const TextStyle(fontSize: 14.0),
                ) : Container()
              ),
            ],
          ),
        ));
  }
}
