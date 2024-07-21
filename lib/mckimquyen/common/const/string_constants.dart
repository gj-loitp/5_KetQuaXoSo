class StringConstants {
  static const String loading = "Đang tải dữ liệu.\nVui lòng chờ...";
  static const String warning = "Thông báo";
  static const String errorMsg = "Có lỗi xảy ra, vui lòng thử lại sau.";
  static const String cancel = "Hủy";
  static const String confirm = "Xác nhận";
  static const String comingSoon = "Tính năng này đang được phát triển, sẽ được cập nhật ở phiên bản tiếp theo.";

  static const String URL_IMG_1 = "https://live.staticflickr.com/8381/28816409494_89aae208c3_b.jpg";
  static const String URL_IMG_2 = "https://live.staticflickr.com/8010/29360410281_fc971a298b_b.jpg";
  static const String URL_IMG_3 = "https://live.staticflickr.com/8071/29332087542_aa9445dd79_b.jpg";
  static const String URL_IMG_4 = "https://live.staticflickr.com/8556/29440140595_b7b81c7768_b.jpg";
  static const String URL_IMG_5 = "https://live.staticflickr.com/8438/28818520263_c7ea1b3e3f_b.jpg";
  static const String URL_IMG_6 = "https://live.staticflickr.com/8277/28953938513_9ea7e4a4e5_b.jpg";
  static const String URL_IMG_7 = "https://live.staticflickr.com/5542/30333782080_ef19d1b037_b.jpg";

  static const String kqApiXoso = "https://xosothantai.mobi/embedded";
  static const String kqMienNam = "$kqApiXoso/kq-miennam";
  static const String kqMienTrung = "$kqApiXoso/kq-mientrung";
  static const String kqMienBac = "$kqApiXoso/kq-mienbac";
  static const String kqMega = "$kqApiXoso/kq-mega";
  static const String kqPower = "$kqApiXoso/kq-power";
  static const String kqMax3d = "$kqApiXoso/kq-max3d";
  static const String kqProvince = "$kqApiXoso/kq-tinh?tinh=";

  // static const String apiXsmn = "https://baomoi.com/_next/data/qAJGq6pyG9k4QUEhaspKS/utilities/lottery/xsmn-mien-nam.json";
  //https://xoso.mobi/tin-tuc/cach-chen-ma-code-nhung-ket-qua-truc-tiep-xo-so-dua-vao-website-blog-n7417.html
  static getApiXsmn(String buildId) {
    return "https://baomoi.com/_next/data/$buildId/utilities/lottery/xsmn-mien-nam.json";
  }

  static getApiXsmt(String buildId) {
    return "https://baomoi.com/_next/data/$buildId/utilities/lottery/xsmt-mien-trung.json";
  }

  static getApiXsmb(String buildId) {
    return "https://baomoi.com/_next/data/$buildId/utilities/lottery/xsmb-mien-bac.json";
  }

  static getApiProvince(String buildId, String dateTime, String? slug) {
    // return "https://baomoi.com/_next/data/$buildId/utilities/lottery/xsmt-mien-trung.json";
    return "https://baomoi.com/_next/data/$buildId/utilities/lottery/$slug.json?date=$dateTime&slug=${slug ?? ""}";
  }
}
