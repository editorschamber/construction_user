class APIStrings {
 // Base URL
 static const String baseUrl = "https://backend-construction-main.vercel.app/api/";

 // Auth Endpoints
 static const String changePassword = "admin/change";
 static const String login = "admin/login";
 static const String verifyUser = "${baseUrl}admin/verify";

 // User Management Endpoints
 static const String users = "admin/users";

 // Orders Endpoints
 static const String approvedOrders = "approvedOrders";
 static const String pendingOrders = "pendingOrders";
 static const String createOrder = "${baseUrl}orders/create";
 static const String receiveOrder = "${baseUrl}receive";

 // Stock and Material Endpoints
 static const String availableStocks = "${baseUrl}availableStocks";
 static const String materials = "${baseUrl}materials";

 // Construction Sites and Labor Management
 static const String constructionSites = "${baseUrl}constructionSites";
 static const String labors = "${baseUrl}labors";
 static const String supervisors = "${baseUrl}supervisors";
}
