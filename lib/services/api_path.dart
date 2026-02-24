class ApiPath {
  // old
  // static const String baseUrl = "https://work.mobidudes.in/CH/CookingChamps/api/";
  // static const String imageBaseUrl = "https://work.mobidudes.in/CH/CookingChamps/";
  //New
  ///........live
  static const String baseUrl = "https://cookingchamps.info/api/";
  static const String baseUrlStrip = "https://cookingchamps.info";
  static const String imageBaseUrl = "https://cookingchamps.info/";
  static const String videoBaseUrl = "https://cookingchamps.info/public/storage/";

  ///.....dev
  // static const String baseUrl = "https://dev.cookingchamps.info/api/";
  // static const String imageBaseUrl = "https://dev.cookingchamps.info/";
  // static const String videoBaseUrl = "https://dev.cookingchamps.info/public/storage/";

  static const String registerParent = "register-parent";
  static const String registerKids = "register-kid";
  static const String myChildListing = "my-child-listing";
  static const String login = "login";
  static const String socialLogin = "social-login";
  static const String logout = "logout";
  static const String userDetail = "user-detail";
  static const String updateProfile = "update-profile";
  static const String changePassword = "change-password";
  static const String deleteAccount = "delete-account";
  static const String deleteKid = "delete-kid";
  static const String forgotPassword = "forgot-password";
  static const String otpVerify = "otp-verify";
  static const String resetPassword = "reset-password";
  static const String addStories = "add-stories";
  static const String editStories = "edit-stories";
  static const String storyListing = "story-listing";
  static const String storyDetail = "story-detail";
  static const String recipeTools = "recipe-tools";
  static const String addRecipe = "add-recipe";
  static const String getRecipe = "recipe-listing";
  static const String recipeDetail = "recipe-detail";
  static const String helpSupport = "help-&-support";
  static const String aboutUs = "about-us";
  static const String addToFavorites = "add_to_favorites";
  static const String favoritesListing = "favorites-listing";
  static const String sendFriendRequest = "send-friend-request";
  static const String friendRequest = "friend-request";
  static const String acceptFriendRequest = "accept-friend-request";
  static const String notificationListing = "notification-listing";
  static const String friendRequestCount = "pending-friend-request-count";
  static const String shareStories = "share-stories";
  static const String home = "home?type=";
  static const String privacypolicy = "privacy-policy";
  static const String termsandcondition = "terms-and-condition";
  static const String followrequest = "send-follow-request";
  static const String followrequestlist = "follow-request-list";
  static const String editrecipe = "edit-recipe";
  static const String reactionrecipe = "like-recipe";
  static const String deleteNotification = "delete-notification";
  static const String updateRole = "update-role";
  static const String shops =  "${baseUrl}shops";
  static const String productDetail =  "${baseUrl}product-detail";
  static const String addToWishlist =  "${baseUrl}add-to-wishlist";
  static const String addToCart =  "${baseUrl}add-to-cart";
  static const String cartList =  "${baseUrl}cart-list";
  static const String removeCart =  "${baseUrl}remove-cart";
  static const String addAddress =  "${baseUrl}add-address";
  static const String editAddress =  "${baseUrl}edit-address";
  static const String deleteAddress =  "${baseUrl}delete-address";
  static const String addressList =  "${baseUrl}address-list";
  static const String productCategories =  "${baseUrl}product-categories";
  static const String updateQuantity =  "${baseUrl}update-quantity";
  static const String subscriptionList =  "${baseUrl}subscription-list";
  static const String myOrders =  "${baseUrl}my-orders";
  static const String orderDetails =  "${baseUrl}order-details";
  static const String getSchoolVideo =  "get-school";

}


///........stripeUrl
class AppUrls {
  static String getStripeUrl({
    required String userId,
    required String subscriptionId,
  }) {
    return "${ApiPath.baseUrlStrip}/purchase-plan?user_id=$userId&subscription_id=$subscriptionId";
  }
  static String orderStripeURL({
    required String userId,
    required String shippingAddressId,
  }) {
    return "${ApiPath.baseUrlStrip}/orders?user_id=$userId&shipping_address_id=$shippingAddressId";
  }
  static String purchasePlanKidURL({
    required String userId,
    required String kidId,
    required String subscriptionId,
  }) {
    return "${ApiPath.baseUrlStrip}/purchase-plan?user_id=$userId&kid_id=$kidId&subscription_id=$subscriptionId";
  }

  static String purchasePlanParentURL({
    required String parentId,
    required String subscriptionId,
  }) {
    return "${ApiPath.baseUrlStrip}/purchase-plan?user_id=$parentId&subscription_id=$subscriptionId";
  }

}


