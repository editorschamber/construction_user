class APIStrings {
  // Base URL
  static const String baseUrl =
      "https://backend-construction-main.vercel.app/api/";

  // Auth Endpoints
  static const String changePassword = "admin/change";
  static const String login = "admin/login";
  static const String verifyUser = "admin/verify";
  static const String getUserDetails = "admin/getUserDetails";

  // User Management Endpoints
  static const String users = "admin/users";

  // Orders Endpoints
  static const String approvedOrders = "approvedOrders";
  static const String pendingOrders = "pendingOrders";
  static const String createOrder = "orders/create";
  static const String updateOrder = "orders/update";
  static const String receiveOrder = "receive";
  static const String getOrdersBySite = 'orders/getOrderBySiteId';
  static const String getOrdersByUser = 'orders/getOrderByUserId';

  // Stock and Material Endpoints
  static const String availableStocks =
      "availableStocks/getAvilableStockBySiteId";
  static const String materials = "materials";
  static const String materialUsage = 'materials/materialUsage';

  // Construction Sites and Labor Management
  static const String constructionSites = "constructionSites";
  static const String labors = "labors";
  static const String supervisors = "supervisors";
  static const String getSitesByUserId = "constructionSites/getSitesByUserId";
  static const String getAllMaterial = "materials/getAllMaterial";

  // Attendance Service
  static const String markAttendance = 'users/markAttendance';
  static const String laborAttendance = 'labor/addAttendance';
  static const String getLaborAttendance = 'labor/getAllAttendance';
  static const String getAllLabors = 'labor/getAllLabors';
  static const String getAttendanceByName = 'labor/getAttendance';
  static const String markAsOut = 'labor/markAsOut';


}
