import 'package:emartstore/model/CurrencyModel.dart';

const FINISHED_ON_BOARDING = 'finishedOnBoarding';
const COLOR_ACCENT = 0xFF8fd468;
const COLOR_PRIMARY_DARK = 0xFF2c7305;
const COLOR_DARK = 0xFF191A1C;
var COLOR_PRIMARY = 0xFF00B761;
const FACEBOOK_BUTTON_COLOR = 0xFF415893;
const COUPON_BG_COLOR = 0xFFFCF8F3;
const COUPON_DASH_COLOR = 0xFFCACFDA;
const GREY_TEXT_COLOR = 0xff5E5C5C;
const DARK_COLOR = 0xff191A1C;

const USERS = 'users';
const REPORTS = 'reports';
const STORAGE_ROOT = 'emart';
const VENDORS_CATEGORIES = 'vendor_categories';
const REVIEW_ATTRIBUTES = "review_attributes";

const VENDORS = 'vendors';
const PRODUCTS = 'vendor_products';
const SECTION = 'sections';
const ORDERS = 'vendor_orders';
const COUPONS = "coupons";
const ORDERS_TABLE = 'booked_table';
const FOOD_REVIEW = 'items_review';
const CONTACT_US = 'ContactUs';
const OrderTransaction = "order_transactions";
const VENDOR_ATTRIBUTES = "vendor_attributes";
const BRANDS = "brands";
const Order_Rating = 'items_review';
const STORY = 'story';
const REFERRAL = 'referral';


const SECOND_MILLIS = 1000;
const MINUTE_MILLIS = 60 * SECOND_MILLIS;
const HOUR_MILLIS = 60 * MINUTE_MILLIS;
String SERVER_KEY = 'Replace your key';
String GOOGLE_API_KEY = '';

const ORDER_STATUS_PLACED = 'Order Placed';
const ORDER_STATUS_ACCEPTED = 'Order Accepted';
const ORDER_STATUS_REJECTED = 'Order Rejected';
const ORDER_STATUS_DRIVER_PENDING = 'Driver Pending';
const ORDER_STATUS_DRIVER_ACCEPTED = 'Driver Accepted';
const ORDER_STATUS_DRIVER_REJECTED = 'Driver Rejected';
const ORDER_STATUS_SHIPPED = 'Order Shipped';
const ORDER_STATUS_IN_TRANSIT = 'In Transit';
const ORDER_STATUS_COMPLETED = 'Order Completed';

const USER_ROLE_VENDOR = 'vendor';

const Currency = 'currencies';
String symbol = '';
bool isRight = false;
int decimal = 0;
String currName = "";
String fileSize = "10";
CurrencyModel? currencyData;
bool isDineInEnable = false;
bool isLanguageShown = false;

const Setting = 'settings';
String placeholderImage = '';

const Wallet = "wallet";
const Payouts = "payouts";
String appVersion = '';

String getFileName(String url) {
  RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
  //This Regex won't work if you remove ?alt...token
  var matches = regExp.allMatches(url);

  var match = matches.elementAt(0);
  print("${Uri.decodeFull(match.group(2)!)}");
  return Uri.decodeFull(match.group(2)!);
}