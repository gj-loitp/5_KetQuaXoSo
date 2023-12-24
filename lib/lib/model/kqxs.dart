import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class KQXS {
  PageProps? pageProps;

  // bool? bNSSP;

  KQXS({
    this.pageProps,
    // this.bNSSP,
  });

  KQXS.fromJson(Map<String, dynamic> json) {
    pageProps = json['pageProps'] != null ? PageProps.fromJson(json['pageProps']) : null;
    // bNSSP = json['__N_SSP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pageProps != null) {
      data['pageProps'] = pageProps!.toJson();
    }
    // data['__N_SSP'] = bNSSP;
    return data;
  }

  List<DataWrapper> getDataWrapper() {
    var entries = pageProps?.resp?.data?.content?.entries ?? List.empty();
    var listDataWrapper = <DataWrapper>[];

    void addDataWrapperByEntries(Entries entries) {
      var index = listDataWrapper.indexWhere((element) => element.id == entries.id);
      if (index < 0) {
        //chua co DataWrapper nay -> tao moi
        var dataWrapper = DataWrapper();
        dataWrapper.id = entries.id;
        dataWrapper.displayName = entries.displayName;

        var recordKQXS = <RecordKQXS>[];
        recordKQXS.add(
          RecordKQXS(
            award: entries.award,
            value: entries.value,
          ),
        );
        dataWrapper.recordKQXS = recordKQXS;

        listDataWrapper.add(dataWrapper);
      } else {
        //da co DataWrapper nay roi
        listDataWrapper[index].recordKQXS?.add(
              RecordKQXS(
                award: entries.award,
                value: entries.value,
              ),
            );
      }
    }

    for (var element in entries) {
      addDataWrapperByEntries(element);
    }
    return listDataWrapper;
  }
}

class PageProps {
  Resp? resp;

  // String? userAgent;
  // bool? isBot;
  // String? hostName;

  PageProps({
    this.resp,
    // this.userAgent,
    // this.isBot,
    // this.hostName,
  });

  PageProps.fromJson(Map<String, dynamic> json) {
    resp = json['resp'] != null ? Resp.fromJson(json['resp']) : null;
    // userAgent = json['userAgent'];
    // isBot = json['isBot'];
    // hostName = json['hostName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (resp != null) {
      data['resp'] = resp!.toJson();
    }
    // data['userAgent'] = userAgent;
    // data['isBot'] = isBot;
    // data['hostName'] = hostName;
    return data;
  }
}

class Resp {
  // int? err;
  // String? msg;
  Data? data;

  // String? version;
  // int? timestamp;

  Resp({
    // this.err,
    // this.msg,
    this.data,
    // this.version,
    // this.timestamp,
  });

  Resp.fromJson(Map<String, dynamic> json) {
    // err = json['err'];
    // msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    // version = json['version'];
    // timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['err'] = err;
    // data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    // data['version'] = version;
    // data['timestamp'] = timestamp;
    return data;
  }
}

class Data {
  // String? page;
  // int? categoryIdOfPage;
  // String? categoryShortUrl;
  // Head? head;
  // Ad? ad;
  // bool? showMenu;
  // Breadcrumb? breadcrumb;
  Content? content;

  // String? pageUrl;

  Data({
    // this.page,
    // this.categoryIdOfPage,
    // this.categoryShortUrl,
    // this.head,
    // this.ad,
    // this.showMenu,
    // this.breadcrumb,
    this.content,
    // this.pageUrl,
  });

  Data.fromJson(Map<String, dynamic> json) {
    // page = json['page'];
    // categoryIdOfPage = json['categoryIdOfPage'];
    // categoryShortUrl = json['categoryShortUrl'];
    // head = json['head'] != null ? Head.fromJson(json['head']) : null;
    // ad = json['ad'] != null ? Ad.fromJson(json['ad']) : null;
    // showMenu = json['showMenu'];
    // breadcrumb = json['breadcrumb'] != null ? Breadcrumb.fromJson(json['breadcrumb']) : null;
    content = json['content'] != null ? Content.fromJson(json['content']) : null;
    // pageUrl = json['pageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['page'] = page;
    // data['categoryIdOfPage'] = categoryIdOfPage;
    // data['categoryShortUrl'] = categoryShortUrl;
    // if (head != null) {
    //   data['head'] = head!.toJson();
    // }
    // if (ad != null) {
    //   data['ad'] = ad!.toJson();
    // }
    // data['showMenu'] = showMenu;
    // if (breadcrumb != null) {
    //   data['breadcrumb'] = breadcrumb!.toJson();
    // }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    // data['pageUrl'] = pageUrl;
    return data;
  }
}

class Head {
  Meta? meta;
  List<JsonLd>? jsonLd;

  Head({this.meta, this.jsonLd});

  Head.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['jsonLd'] != null) {
      jsonLd = <JsonLd>[];
      json['jsonLd'].forEach((v) {
        jsonLd!.add(JsonLd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (jsonLd != null) {
      data['jsonLd'] = jsonLd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  String? title;
  String? ogTitle;
  String? description;
  String? keywords;
  String? url;
  String? ogUrl;
  String? type;
  String? imageUrl;
  int? imageWidth;
  int? imageHeight;
  String? robots;
  String? canonicalUrl;
  String? ogSiteName;

  Meta(
      {this.title,
      this.ogTitle,
      this.description,
      this.keywords,
      this.url,
      this.ogUrl,
      this.type,
      this.imageUrl,
      this.imageWidth,
      this.imageHeight,
      this.robots,
      this.canonicalUrl,
      this.ogSiteName});

  Meta.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    ogTitle = json['ogTitle'];
    description = json['description'];
    keywords = json['keywords'];
    url = json['url'];
    ogUrl = json['ogUrl'];
    type = json['type'];
    imageUrl = json['imageUrl'];
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
    robots = json['robots'];
    canonicalUrl = json['canonicalUrl'];
    ogSiteName = json['ogSiteName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['ogTitle'] = ogTitle;
    data['description'] = description;
    data['keywords'] = keywords;
    data['url'] = url;
    data['ogUrl'] = ogUrl;
    data['type'] = type;
    data['imageUrl'] = imageUrl;
    data['imageWidth'] = imageWidth;
    data['imageHeight'] = imageHeight;
    data['robots'] = robots;
    data['canonicalUrl'] = canonicalUrl;
    data['ogSiteName'] = ogSiteName;
    return data;
  }
}

class JsonLd {
  String? name;
  String? url;
  String? context;
  String? type;

  JsonLd({this.name, this.url, this.context, this.type});

  JsonLd.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    context = json['@context'];
    type = json['@type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['@context'] = context;
    data['@type'] = type;
    return data;
  }
}

class Ad {
  bool? isNoAd;
  Masthead? masthead;

  Ad({this.isNoAd, this.masthead});

  Ad.fromJson(Map<String, dynamic> json) {
    isNoAd = json['isNoAd'];
    masthead = json['masthead'] != null ? Masthead.fromJson(json['masthead']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isNoAd'] = isNoAd;
    if (masthead != null) {
      data['masthead'] = masthead!.toJson();
    }
    return data;
  }
}

class Masthead {
  String? elId;
  String? url;
  Params? params;

  Masthead({this.elId, this.url, this.params});

  Masthead.fromJson(Map<String, dynamic> json) {
    elId = json['elId'];
    url = json['url'];
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['elId'] = elId;
    data['url'] = url;
    if (params != null) {
      data['params'] = params!.toJson();
    }
    return data;
  }
}

class Params {
  String? zoneId;
  int? page;
  int? id;

  Params({this.zoneId, this.page, this.id});

  Params.fromJson(Map<String, dynamic> json) {
    zoneId = json['zoneId'];
    page = json['page'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zoneId'] = zoneId;
    data['page'] = page;
    data['id'] = id;
    return data;
  }
}

class Breadcrumb {
  List<Left>? left;

  Breadcrumb({this.left});

  Breadcrumb.fromJson(Map<String, dynamic> json) {
    if (json['left'] != null) {
      left = <Left>[];
      json['left'].forEach((v) {
        left!.add(Left.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (left != null) {
      data['left'] = left!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Left {
  String? name;
  String? url;

  Left({this.name, this.url});

  Left.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Content {
  // String? id;
  // String? boardId;
  // String? displayName;
  // String? shortName;
  // String? lastDay;
  // String? drawDays;
  // String? drawStartTime;
  // String? region;
  // List<Boards>? boards;
  // Banner? banner;
  // List<DrawRecent>? drawRecent;
  List<Entries>? entries;

  // bool? dialing;
  // List<Items>? items;
  // String? keyword;

  Content({
    // this.id,
    // this.boardId,
    // this.displayName,
    // this.shortName,
    // this.lastDay,
    // this.drawDays,
    // this.drawStartTime,
    // this.region,
    // this.boards,
    // this.banner,
    // this.drawRecent,
    this.entries,
    // this.dialing,
    // this.items,
    // this.keyword,
  });

  Content.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // boardId = json['boardId'];
    // displayName = json['displayName'];
    // shortName = json['shortName'];
    // lastDay = json['lastDay'];
    // drawDays = json['drawDays'];
    // drawStartTime = json['drawStartTime'];
    // region = json['region'];
    // if (json['boards'] != null) {
    //   boards = <Boards>[];
    //   json['boards'].forEach((v) {
    //     boards!.add(Boards.fromJson(v));
    //   });
    // }
    // banner = json['banner'] != null ? Banner.fromJson(json['banner']) : null;
    // if (json['drawRecent'] != null) {
    //   drawRecent = <DrawRecent>[];
    //   json['drawRecent'].forEach((v) {
    //     drawRecent!.add(DrawRecent.fromJson(v));
    //   });
    // }
    if (json['entries'] != null) {
      entries = <Entries>[];
      json['entries'].forEach((v) {
        entries!.add(Entries.fromJson(v));
      });
    }
    // dialing = json['dialing'];
    // if (json['items'] != null) {
    //   items = <Items>[];
    //   json['items'].forEach((v) {
    //     items!.add(Items.fromJson(v));
    //   });
    // }
    // keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    // data['boardId'] = boardId;
    // data['displayName'] = displayName;
    // data['shortName'] = shortName;
    // data['lastDay'] = lastDay;
    // data['drawDays'] = drawDays;
    // data['drawStartTime'] = drawStartTime;
    // data['region'] = region;
    // if (boards != null) {
    //   data['boards'] = boards!.map((v) => v.toJson()).toList();
    // }
    // if (banner != null) {
    //   data['banner'] = banner!.toJson();
    // }
    // if (drawRecent != null) {
    //   data['drawRecent'] = drawRecent!.map((v) => v.toJson()).toList();
    // }
    if (entries != null) {
      data['entries'] = entries!.map((v) => v.toJson()).toList();
    }
    // data['dialing'] = dialing;
    // if (items != null) {
    //   data['items'] = items!.map((v) => v.toJson()).toList();
    // }
    // data['keyword'] = keyword;
    return data;
  }
}

class Boards {
  String? id;
  String? boardId;
  String? displayName;
  String? shortName;
  String? lastDay;
  String? drawDays;
  String? drawStartTime;
  String? region;

  Boards(
      {this.id,
      this.boardId,
      this.displayName,
      this.shortName,
      this.lastDay,
      this.drawDays,
      this.drawStartTime,
      this.region});

  Boards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boardId = json['boardId'];
    displayName = json['displayName'];
    shortName = json['shortName'];
    lastDay = json['lastDay'];
    drawDays = json['drawDays'];
    drawStartTime = json['drawStartTime'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['boardId'] = boardId;
    data['displayName'] = displayName;
    data['shortName'] = shortName;
    data['lastDay'] = lastDay;
    data['drawDays'] = drawDays;
    data['drawStartTime'] = drawStartTime;
    data['region'] = region;
    return data;
  }
}

class Banner {
  String? url;
  String? thumb;

  Banner({this.url, this.thumb});

  Banner.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['thumb'] = thumb;
    return data;
  }
}

class DrawRecent {
  String? date;

  DrawRecent({this.date});

  DrawRecent.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    return data;
  }
}

class Entries {
  String? id;
  String? boardId;
  String? displayName;
  String? award;
  String? value;
  String? compareValue;
  String? region;

  Entries({
    this.id,
    this.boardId,
    this.displayName,
    this.award,
    this.value,
    this.compareValue,
    this.region,
  });

  Entries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boardId = json['boardId'];
    displayName = json['displayName'];
    award = json['award'];
    value = json['value'];
    compareValue = json['compareValue'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['boardId'] = boardId;
    data['displayName'] = displayName;
    data['award'] = award;
    data['value'] = value;
    data['compareValue'] = compareValue;
    data['region'] = region;
    return data;
  }
}

class Items {
  int? id;
  int? contentId;
  String? title;
  String? description;
  int? date;
  String? url;
  String? redirectUrl;
  String? thumb;
  String? thumbL;
  String? classNames;
  Publisher? publisher;
  bool? isNoFilter;
  bool? thumbIsGif;
  List<int>? contentTypes;

  Items(
      {this.id,
      this.contentId,
      this.title,
      this.description,
      this.date,
      this.url,
      this.redirectUrl,
      this.thumb,
      this.thumbL,
      this.classNames,
      this.publisher,
      this.isNoFilter,
      this.thumbIsGif,
      this.contentTypes});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentId = json['contentId'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    url = json['url'];
    redirectUrl = json['redirectUrl'];
    thumb = json['thumb'];
    thumbL = json['thumbL'];
    classNames = json['classNames'];
    publisher = json['publisher'] != null ? Publisher.fromJson(json['publisher']) : null;
    isNoFilter = json['isNoFilter'];
    thumbIsGif = json['thumbIsGif'];
    contentTypes = json['contentTypes'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contentId'] = contentId;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['url'] = url;
    data['redirectUrl'] = redirectUrl;
    data['thumb'] = thumb;
    data['thumbL'] = thumbL;
    data['classNames'] = classNames;
    if (publisher != null) {
      data['publisher'] = publisher!.toJson();
    }
    data['isNoFilter'] = isNoFilter;
    data['thumbIsGif'] = thumbIsGif;
    data['contentTypes'] = contentTypes;
    return data;
  }
}

class Publisher {
  String? logo;
  String? icon;
  int? width;
  int? height;
  String? url;
  String? name;
  bool? showName;
  String? shortName;

  Publisher({this.logo, this.icon, this.width, this.height, this.url, this.name, this.showName, this.shortName});

  Publisher.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    icon = json['icon'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    name = json['name'];
    showName = json['showName'];
    shortName = json['shortName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['icon'] = icon;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['name'] = name;
    data['showName'] = showName;
    data['shortName'] = shortName;
    return data;
  }
}

class DataWrapper {
  String? id;
  String? displayName;
  List<RecordKQXS>? recordKQXS;

  DataWrapper({this.id, this.displayName, this.recordKQXS});

  DataWrapper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    if (json['recordKQXS'] != null) {
      recordKQXS = <RecordKQXS>[];
      json['recordKQXS'].forEach((v) {
        recordKQXS!.add(RecordKQXS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['displayName'] = displayName;
    if (recordKQXS != null) {
      data['recordKQXS'] = recordKQXS!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String getValueByAward(String award, String myCurrentLottery) {
    var record = recordKQXS?.firstWhere((element) => element.award == award);
    var text = record?.value ?? "";

    var arr = text.split("-");
    var s = "";
    for (var element in arr) {
      s += "${element.trim()}\n";
    }

    debugPrint("roy93~ getValueByAward s $s");
    debugPrint("roy93~ getValueByAward myCurrentLottery $myCurrentLottery");

    return s.trim();
  }
}

class RecordKQXS {
  String? award;
  String? value;

  RecordKQXS({this.award, this.value});

  RecordKQXS.fromJson(Map<String, dynamic> json) {
    award = json['award'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['award'] = award;
    data['value'] = value;
    return data;
  }
}
