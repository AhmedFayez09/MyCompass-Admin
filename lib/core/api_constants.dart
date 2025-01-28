class ApiConstants {
  static const String baseUrl = 'https://riedbergapp.up.railway.app/';
  static const String loginUrl = 'auth/login';
  static const String getAllAdminsUrl = 'admin';
  static const String createNewFamilyUrl = 'user/createUser';
  static const String getAllFamiliesUrl = 'user/usersProfiles';
  static const String addAdminUrl = 'auth/register';
  static const String getAllEmployeesUrl = 'employee/employeesProfiles';
  static const String addEmployeeUrl = 'employee/createEmployee';
  static const String getAllGalleryUrl = 'operations/getGallery';
  static const String getProfileUrl = 'operations/profile';
  static const String addAnnouncementUrl = 'admin/creatAnnouncement';
  static const String getAllIsdUrl = 'operations/allIds';
  static const String getAllAnnouncementUrl = 'operations/getAllAnnouncement';
  static const String getAllMaintenancesUrl = 'admin/getAllMaintenances';
  static const String getAllFamiliesIdsUrl = 'user/usersIds';
  static const String getAllEmployeesIdsUrl = 'employee/employeeIds';
  static const String addGalleryUrl = 'admin/addGallery';
  static const String getPostsUrl = 'operations/allPosts';
  static const String addPostUrl = 'operations/addPost';
  static const String deleteAllAnnouncementsUrl = 'admin/deleteAllAnnouncements';
  static const String deleteAllGalleriesUrl = 'admin/deleteAllGalleries';
  static const String createFastNotificationUrl = 'admin/createNotification';
  static const String getUserStatusUrl = 'admin/getAllResponses';
  static const String handleResponseUrl = 'operations/handleResponse';
  static const String getNonResponders = 'admin/getNonResponders';

  static   String deleteFamilyUrl ({required String id})=> 'user/deleteUser/$id';
  static   String deleteAdminUrl ({required String id})=> 'admin/deleteAdmin/$id';
  static   String deleteEmployeeUrl ({required String id})=> 'employee/deleteEmployee/$id';
  static   String updateFamilyUrl ({required String id})=> 'admin/updateFamily/$id';
  static   String updateFamilyPasswordUrl ({required String id})=> 'admin/updatePassword/$id';
  static   String deletePostUrl ({required String id})=> 'operations/deletePost/$id';
  static   String changeMaintenanceStatusUrl ({required String id})=> 'admin/changeStatus/$id';
  static   String updatePostUrl ({required String id})=> 'operations/updatePost/$id';
  static   String deleteSpAnnouncementUrl ({required String id})=> 'admin/deleteSpAnnouncement/$id';
  static   String updateAnnouncementUrl ({required String id})=> 'admin/updateAnnouncement/$id';
  static   String deleteGalleryUrl ({required String id})=> 'admin/deleteGallery/$id';
  static   String updateGalleryUrl ({required String id})=> 'admin/updateGallery/$id';
  static   String updateEmployeeUrl ({required String id})=> 'employee/updateEmployee/$id';
  static   String addCommentUrl ({required String id})=> 'operations/createComment/$id';
  static   String addReplyUrl ({required String id})=> 'operations/$id/reply';
  static   String addPostLikeUrl ({required String id})=> 'operations/$id/postlike';
  static   String addPostUnLikeUrl ({required String id})=> 'operations/$id/postunlike';
  static   String getCommentsUrl ({required String id})=> 'operations/getComments/$id';
  static   String updateAdminUrl ({required String id})=> 'admin/updateAdmin/$id';

}