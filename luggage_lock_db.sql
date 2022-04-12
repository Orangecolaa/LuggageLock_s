/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : luggage_lock_db

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 12/04/2022 13:25:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES (1, 'api');
INSERT INTO `auth_group` VALUES (2, 'download_data');

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add borrow record', 7, 'add_borrowrecord');
INSERT INTO `auth_permission` VALUES (26, 'Can change borrow record', 7, 'change_borrowrecord');
INSERT INTO `auth_permission` VALUES (27, 'Can delete borrow record', 7, 'delete_borrowrecord');
INSERT INTO `auth_permission` VALUES (28, 'Can view borrow record', 7, 'view_borrowrecord');
INSERT INTO `auth_permission` VALUES (29, 'Can add location', 8, 'add_location');
INSERT INTO `auth_permission` VALUES (30, 'Can change location', 8, 'change_location');
INSERT INTO `auth_permission` VALUES (31, 'Can delete location', 8, 'delete_location');
INSERT INTO `auth_permission` VALUES (32, 'Can view location', 8, 'view_location');
INSERT INTO `auth_permission` VALUES (33, 'Can add manufacturer', 9, 'add_manufacturer');
INSERT INTO `auth_permission` VALUES (34, 'Can change manufacturer', 9, 'change_manufacturer');
INSERT INTO `auth_permission` VALUES (35, 'Can delete manufacturer', 9, 'delete_manufacturer');
INSERT INTO `auth_permission` VALUES (36, 'Can view manufacturer', 9, 'view_manufacturer');
INSERT INTO `auth_permission` VALUES (37, 'Can add user activity', 10, 'add_useractivity');
INSERT INTO `auth_permission` VALUES (38, 'Can change user activity', 10, 'change_useractivity');
INSERT INTO `auth_permission` VALUES (39, 'Can delete user activity', 10, 'delete_useractivity');
INSERT INTO `auth_permission` VALUES (40, 'Can view user activity', 10, 'view_useractivity');
INSERT INTO `auth_permission` VALUES (41, 'Can add profile', 11, 'add_profile');
INSERT INTO `auth_permission` VALUES (42, 'Can change profile', 11, 'change_profile');
INSERT INTO `auth_permission` VALUES (43, 'Can delete profile', 11, 'delete_profile');
INSERT INTO `auth_permission` VALUES (44, 'Can view profile', 11, 'view_profile');
INSERT INTO `auth_permission` VALUES (45, 'Can add lock', 12, 'add_lock');
INSERT INTO `auth_permission` VALUES (46, 'Can change lock', 12, 'change_lock');
INSERT INTO `auth_permission` VALUES (47, 'Can delete lock', 12, 'delete_lock');
INSERT INTO `auth_permission` VALUES (48, 'Can view lock', 12, 'view_lock');
INSERT INTO `auth_permission` VALUES (49, 'Can add notification', 13, 'add_notification');
INSERT INTO `auth_permission` VALUES (50, 'Can change notification', 13, 'change_notification');
INSERT INTO `auth_permission` VALUES (51, 'Can delete notification', 13, 'delete_notification');
INSERT INTO `auth_permission` VALUES (52, 'Can view notification', 13, 'view_notification');
INSERT INTO `auth_permission` VALUES (53, 'Can add comment', 14, 'add_comment');
INSERT INTO `auth_permission` VALUES (54, 'Can change comment', 14, 'change_comment');
INSERT INTO `auth_permission` VALUES (55, 'Can delete comment', 14, 'delete_comment');
INSERT INTO `auth_permission` VALUES (56, 'Can view comment', 14, 'view_comment');
INSERT INTO `auth_permission` VALUES (57, 'Can add borrow record', 15, 'add_borrowrecord');
INSERT INTO `auth_permission` VALUES (58, 'Can change borrow record', 15, 'change_borrowrecord');
INSERT INTO `auth_permission` VALUES (59, 'Can delete borrow record', 15, 'delete_borrowrecord');
INSERT INTO `auth_permission` VALUES (60, 'Can view borrow record', 15, 'view_borrowrecord');
INSERT INTO `auth_permission` VALUES (61, 'Can add location', 16, 'add_location');
INSERT INTO `auth_permission` VALUES (62, 'Can change location', 16, 'change_location');
INSERT INTO `auth_permission` VALUES (63, 'Can delete location', 16, 'delete_location');
INSERT INTO `auth_permission` VALUES (64, 'Can view location', 16, 'view_location');
INSERT INTO `auth_permission` VALUES (65, 'Can add manufacturer', 17, 'add_manufacturer');
INSERT INTO `auth_permission` VALUES (66, 'Can change manufacturer', 17, 'change_manufacturer');
INSERT INTO `auth_permission` VALUES (67, 'Can delete manufacturer', 17, 'delete_manufacturer');
INSERT INTO `auth_permission` VALUES (68, 'Can view manufacturer', 17, 'view_manufacturer');
INSERT INTO `auth_permission` VALUES (69, 'Can add user activity', 18, 'add_useractivity');
INSERT INTO `auth_permission` VALUES (70, 'Can change user activity', 18, 'change_useractivity');
INSERT INTO `auth_permission` VALUES (71, 'Can delete user activity', 18, 'delete_useractivity');
INSERT INTO `auth_permission` VALUES (72, 'Can view user activity', 18, 'view_useractivity');
INSERT INTO `auth_permission` VALUES (73, 'Can add profile', 19, 'add_profile');
INSERT INTO `auth_permission` VALUES (74, 'Can change profile', 19, 'change_profile');
INSERT INTO `auth_permission` VALUES (75, 'Can delete profile', 19, 'delete_profile');
INSERT INTO `auth_permission` VALUES (76, 'Can view profile', 19, 'view_profile');
INSERT INTO `auth_permission` VALUES (77, 'Can add lock', 20, 'add_lock');
INSERT INTO `auth_permission` VALUES (78, 'Can change lock', 20, 'change_lock');
INSERT INTO `auth_permission` VALUES (79, 'Can delete lock', 20, 'delete_lock');
INSERT INTO `auth_permission` VALUES (80, 'Can view lock', 20, 'view_lock');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$260000$wqtcpwVtlAu1L5OwF09BXB$LsRlYEUBL/q5FBwucugHqpGcNMtLJZAYCdw2V2F/iJI=', '2022-04-11 00:26:51.399269', 1, 'admin', '', '', '1316863816@qq.com', 1, 1, '2022-04-06 20:48:00.000000');
INSERT INTO `auth_user` VALUES (2, 'pbkdf2_sha256$260000$IpVBnWXW4EeSszBci7f4X0$jFHXfvbqrJFTC9IJzGJw3HQiZXf3wCmIZ5gQmiHWDhs=', '2022-04-06 21:02:00.000000', 1, 'admin2', '', '', '1316863816@qq.com', 1, 1, '2022-04-06 21:01:00.000000');
INSERT INTO `auth_user` VALUES (3, 'pbkdf2_sha256$260000$zkc0UX0wV7NXGnvzuleA1M$VRF8PZVME0Jxyv3ui55arMuL/Pllg1F11Apy7dAhfV4=', '2022-04-08 10:56:32.427787', 0, 'test1', '', '', '1234567890@qq.com', 0, 1, '2022-04-08 01:52:14.251446');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
INSERT INTO `auth_user_groups` VALUES (3, 1, 1);
INSERT INTO `auth_user_groups` VALUES (4, 1, 2);

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for borrow_record
-- ----------------------------
DROP TABLE IF EXISTS `borrow_record`;
CREATE TABLE `borrow_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `borrower` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `borrower_phone_number` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `location` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `manufacturer` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `start_day` datetime(6) NOT NULL,
  `end_day` datetime(6) NOT NULL,
  `open_or_close` int(11) NOT NULL,
  `delete_status` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `closed_at` datetime(6) NOT NULL,
  `closed_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow_record
-- ----------------------------
INSERT INTO `borrow_record` VALUES (1, '用户01', '智能小白', '1234567890', '05车厢', '智能智造', 2, '2022-04-08 01:42:59.000000', '2022-04-08 02:35:14.000000', 0, 0, '2022-04-08 01:44:54.037853', 'admin', '2022-04-08 01:44:54.049724', '');
INSERT INTO `borrow_record` VALUES (2, '用户02', '小易1号', '1234567890', '01车厢', '易库', 1, '2022-04-08 01:44:59.000000', '2022-04-08 02:35:14.000000', 1, 0, '2022-04-08 01:45:28.569160', 'admin', '2022-04-08 01:48:12.380705', 'admin');
INSERT INTO `borrow_record` VALUES (3, '用户03', '迪宝1号', '1234567890', '02车厢', '迪玛智造', 2, '2022-04-08 01:45:31.000000', '2022-04-08 02:35:14.000000', 1, 0, '2022-04-08 01:46:03.952732', 'admin', '2022-04-08 01:48:09.691278', 'admin');
INSERT INTO `borrow_record` VALUES (4, '用户04', '安全卫士1号', '1234567890', '04车厢', '智能智造', 2, '2022-04-08 01:46:07.000000', '2022-04-08 02:35:14.000000', 1, 0, '2022-04-08 01:46:38.142719', 'admin', '2022-04-08 01:48:06.307896', 'admin');
INSERT INTO `borrow_record` VALUES (5, '用户05', '执行者1号', '1234567890', '03车厢', '执行者制造', 2, '2022-04-08 01:46:40.000000', '2022-04-08 02:35:14.000000', 1, 0, '2022-04-08 01:47:25.674538', 'admin', '2022-04-08 01:48:03.454156', 'admin');
INSERT INTO `borrow_record` VALUES (6, '用户06', '迪宝1号', '1234567890', '06车厢', '迪玛智造', 1, '2022-04-08 01:47:28.000000', '2022-04-08 02:35:14.000000', 1, 0, '2022-04-08 01:47:56.390888', 'admin', '2022-04-08 01:48:00.686134', 'admin');
INSERT INTO `borrow_record` VALUES (7, '用户02', '小易1号', '1234567890', '03车厢', '易库', 1, '2022-04-08 01:48:14.000000', '2022-04-08 02:35:14.000000', 0, 0, '2022-04-08 01:48:36.571603', 'admin', '2022-04-08 01:48:36.581883', '');

-- ----------------------------
-- Table structure for comment_comment
-- ----------------------------
DROP TABLE IF EXISTS `comment_comment`;
CREATE TABLE `comment_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `lock_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comment_comment_lock_id_7fc0e480_fk_lock_id`(`lock_id`) USING BTREE,
  INDEX `comment_comment_user_id_6078e57b_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `comment_comment_lock_id_7fc0e480_fk_lock_id` FOREIGN KEY (`lock_id`) REFERENCES `lock` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_comment_user_id_6078e57b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment_comment
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2022-04-06 21:03:33.296768', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"Superuser status\", \"Last login\"]}}]', 4, 2);
INSERT INTO `django_admin_log` VALUES (2, '2022-04-06 21:03:42.298236', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"Staff status\"]}}]', 4, 2);
INSERT INTO `django_admin_log` VALUES (3, '2022-04-06 21:03:58.947699', '1', 'api', 1, '[{\"added\": {}}]', 3, 2);
INSERT INTO `django_admin_log` VALUES (4, '2022-04-06 21:04:07.814747', '2', 'download_data', 1, '[{\"added\": {}}]', 3, 2);
INSERT INTO `django_admin_log` VALUES (5, '2022-04-06 21:04:18.813930', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 2);
INSERT INTO `django_admin_log` VALUES (6, '2022-04-06 21:04:26.743982', '2', 'admin2', 2, '[{\"changed\": {\"fields\": [\"Groups\", \"Last login\"]}}]', 4, 2);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (14, 'comment', 'comment');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (7, 'home', 'borrowrecord');
INSERT INTO `django_content_type` VALUES (8, 'home', 'location');
INSERT INTO `django_content_type` VALUES (12, 'home', 'lock');
INSERT INTO `django_content_type` VALUES (9, 'home', 'manufacturer');
INSERT INTO `django_content_type` VALUES (11, 'home', 'profile');
INSERT INTO `django_content_type` VALUES (10, 'home', 'useractivity');
INSERT INTO `django_content_type` VALUES (15, 'lock', 'borrowrecord');
INSERT INTO `django_content_type` VALUES (16, 'lock', 'location');
INSERT INTO `django_content_type` VALUES (20, 'lock', 'lock');
INSERT INTO `django_content_type` VALUES (17, 'lock', 'manufacturer');
INSERT INTO `django_content_type` VALUES (19, 'lock', 'profile');
INSERT INTO `django_content_type` VALUES (18, 'lock', 'useractivity');
INSERT INTO `django_content_type` VALUES (13, 'notifications', 'notification');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2022-04-07 13:58:18.214466');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2022-04-07 13:58:34.155007');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2022-04-07 13:58:38.801819');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2022-04-07 13:58:38.939680');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2022-04-07 13:58:39.114024');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2022-04-07 13:58:41.144639');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2022-04-07 13:58:43.711061');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2022-04-07 13:58:45.493998');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2022-04-07 13:58:45.571790');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2022-04-07 13:58:47.781539');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2022-04-07 13:58:47.874485');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2022-04-07 13:58:47.939429');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2022-04-07 13:58:51.057609');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2022-04-07 13:58:53.191171');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2022-04-07 13:58:58.689792');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2022-04-07 13:58:59.113170');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2022-04-07 13:59:03.287460');
INSERT INTO `django_migrations` VALUES (18, 'lock', '0001_initial', '2022-04-07 13:59:17.623920');
INSERT INTO `django_migrations` VALUES (19, 'comment', '0001_initial', '2022-04-07 13:59:25.612243');
INSERT INTO `django_migrations` VALUES (20, 'notifications', '0001_initial', '2022-04-07 13:59:37.058404');
INSERT INTO `django_migrations` VALUES (21, 'notifications', '0002_auto_20150224_1134', '2022-04-07 13:59:39.497226');
INSERT INTO `django_migrations` VALUES (22, 'notifications', '0003_notification_data', '2022-04-07 13:59:40.989735');
INSERT INTO `django_migrations` VALUES (23, 'notifications', '0004_auto_20150826_1508', '2022-04-07 13:59:41.073483');
INSERT INTO `django_migrations` VALUES (24, 'notifications', '0005_auto_20160504_1520', '2022-04-07 13:59:41.200387');
INSERT INTO `django_migrations` VALUES (25, 'notifications', '0006_indexes', '2022-04-07 13:59:44.425725');
INSERT INTO `django_migrations` VALUES (26, 'notifications', '0007_add_timestamp_index', '2022-04-07 13:59:45.251606');
INSERT INTO `django_migrations` VALUES (27, 'notifications', '0008_index_together_recipient_unread', '2022-04-07 13:59:47.000518');
INSERT INTO `django_migrations` VALUES (28, 'sessions', '0001_initial', '2022-04-07 13:59:48.526315');
INSERT INTO `django_migrations` VALUES (29, 'lock', '0002_alter_borrowrecord_end_day', '2022-04-07 21:08:19.842695');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0z8f2xw0qax46s6z2ol9d2rdli1bsjyv', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nc5LL:RXftpgFz1TvLoCwzurtz5KFww1DVu_TIo_PxXDXP_2w', '2022-04-20 21:05:03.819171');
INSERT INTO `django_session` VALUES ('4l0ua4081rdbna1bid5la5ck1gtqqq3c', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nc5b7:aiDG5XvvyUrFPc9xHvgjMqJBFi0uN1FVohg07-t-I3o', '2022-04-20 21:21:21.961776');
INSERT INTO `django_session` VALUES ('5bhoowh9wi1jyrek43btf2q5518uahx1', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nd433:OiRbiRenw-_6n0ZUuX5S_tiyq1uWQV4va_APaDbFTyg', '2022-04-23 13:54:13.679311');
INSERT INTO `django_session` VALUES ('89mbaynpu8ns5v69kntl9cwdvzmhri6e', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1ncWRx:9YCxiyPLf6Y2qGtIMZf3N9thJY61tBXxqomVoKrGzks', '2022-04-22 02:01:41.792839');
INSERT INTO `django_session` VALUES ('8mmgrls8lr3ns3h2qd5z1jlh4tzmjv20', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nd41H:Xp2i8ql_niaAugSvERwYU12JaVFBP0YHffwuDmqWhvY', '2022-04-23 13:52:23.114419');
INSERT INTO `django_session` VALUES ('dqkmgkfck47pkptr7wgtvdpfz2u9b9tu', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1ncJoe:iinSFEc1Mpjs9kMBQpF33sosyGy1JXayuQuIwrDTpI8', '2022-04-21 12:32:16.394863');
INSERT INTO `django_session` VALUES ('fbqzwavp7u2ofekvl9q2hob0a5hecnib', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nc7mM:CAOO2qJPDtT9Ra22AIQQIRf1EZCcCJClhhfUaWMRGEg', '2022-04-20 23:41:06.551165');
INSERT INTO `django_session` VALUES ('fdd5a500o35lycba7342ldlieza04kip', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nd5K0:dCjmUTKzRHRc-MzA2xmCLlmdpw4gBu9iosRENudi-MU', '2022-04-23 15:15:48.644659');
INSERT INTO `django_session` VALUES ('kbta86f1mh0wqlhk9ylm0rt84gl2ql4v', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nc5ph:C3QLWZR4M-aLt13-zCHRyX4m8I_qAPdDnXaNOrQtUNY', '2022-04-20 21:36:25.095567');
INSERT INTO `django_session` VALUES ('u9t9l8vmd3dnoh3y8b9x74fbky46pdea', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1ndaOp:H-Anj6nJuL5nz6j6WEkcQ9gh_sPzktq11lW56Mvcqk0', '2022-04-25 00:26:51.402340');
INSERT INTO `django_session` VALUES ('w626tp2teydnw68k52cejp5p99ku7bk7', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nd41j:fbdaHjIR7yYK5fPt3g7_z-yG3Rr5-PoRhokUUxIMqLc', '2022-04-23 13:52:51.760445');
INSERT INTO `django_session` VALUES ('zfmk6apj5tgqy4a6lnfaygudh6x9m0gz', '.eJxVjDsOwjAQBe_iGln-fyjpOYO13rVxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uGfBR-g7oDv02c5z7ukyZ7wo_6ODXmcrzcrh_Bw1G-9YZcy3CFYEOA5gKTpMOtrqA0XutoonWSSACDUqTQWmgOhtrNIpIePb-AAFkOD4:1nc5ya:zXnDKzQbxI47ak8epi_4sy-fBrDZkwl0H2dc28uH0v8', '2022-04-20 21:45:36.643503');

-- ----------------------------
-- Table structure for location
-- ----------------------------
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of location
-- ----------------------------
INSERT INTO `location` VALUES (1, '01车厢', '2022-04-08 01:36:21.396183');
INSERT INTO `location` VALUES (2, '02车厢', '2022-04-08 01:36:26.363440');
INSERT INTO `location` VALUES (3, '03车厢', '2022-04-08 01:36:32.076908');
INSERT INTO `location` VALUES (4, '04车厢', '2022-04-08 01:36:37.128275');
INSERT INTO `location` VALUES (5, '05车厢', '2022-04-08 01:36:45.746332');
INSERT INTO `location` VALUES (6, '06车厢', '2022-04-08 01:36:52.354951');
INSERT INTO `location` VALUES (7, '07车厢', '2022-04-08 01:36:58.257472');
INSERT INTO `location` VALUES (8, '08车厢', '2022-04-08 01:37:03.669850');

-- ----------------------------
-- Table structure for lock
-- ----------------------------
DROP TABLE IF EXISTS `lock`;
CREATE TABLE `lock`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `total_borrow_times` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL,
  `delete_status` int(11) NOT NULL,
  `lockshelf_number` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `location_id` bigint(20) NULL DEFAULT NULL,
  `manufacturer_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lock_location_id_1b41f1b4_fk_location_id`(`location_id`) USING BTREE,
  INDEX `lock_manufacturer_id_8950d5c9_fk_manufacturer_id`(`manufacturer_id`) USING BTREE,
  CONSTRAINT `lock_location_id_1b41f1b4_fk_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lock_manufacturer_id_8950d5c9_fk_manufacturer_id` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lock
-- ----------------------------
INSERT INTO `lock` VALUES (1, '小易1号', '智能行李锁保障行李安全。', '2022-04-08 01:40:46.495014', '2022-04-08 01:48:36.576293', 2, 19, 0, 0, '0001', 'Admin', 1, 2);
INSERT INTO `lock` VALUES (2, '迪宝1号', '智能行李锁保障行李安全。', '2022-04-08 01:41:12.602801', '2022-04-08 01:49:46.124285', 2, 8, 1, 0, '0001', 'admin', 2, 1);
INSERT INTO `lock` VALUES (3, '执行者1号', '智能行李锁保障行李安全。', '2022-04-08 01:41:51.729850', '2022-04-08 01:48:03.458931', 1, 20, 1, 0, '0001', 'Admin', 3, 5);
INSERT INTO `lock` VALUES (4, '安全卫士1号', '智能行李锁保障行李安全。', '2022-04-08 01:42:20.434366', '2022-04-08 01:48:06.313184', 1, 16, 1, 0, '0001', 'Admin', 4, 4);
INSERT INTO `lock` VALUES (5, '智能小白', '智能行李锁保障行李安全。', '2022-04-08 01:42:53.122680', '2022-04-08 01:50:02.441051', 1, 5, 0, 0, '0001', 'admin', 5, 4);

-- ----------------------------
-- Table structure for manufacturer
-- ----------------------------
DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE `manufacturer`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `contact` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manufacturer
-- ----------------------------
INSERT INTO `manufacturer` VALUES (1, '迪玛智造', '深圳', '123456789@qq.com', '2022-04-08 01:37:18.266712', 'Admin', '2022-04-08 01:37:18.276311');
INSERT INTO `manufacturer` VALUES (2, '易库', '广州', '123456789@qq.com', '2022-04-08 01:37:28.165168', 'Admin', '2022-04-08 01:37:28.173061');
INSERT INTO `manufacturer` VALUES (3, '蒙德', '北京', '123456789@qq.com', '2022-04-08 01:37:45.544224', 'Admin', '2022-04-08 01:37:45.551013');
INSERT INTO `manufacturer` VALUES (4, '智能智造', '上海', '123456789@qq.com', '2022-04-08 01:38:08.829797', 'Admin', '2022-04-08 01:38:08.836514');
INSERT INTO `manufacturer` VALUES (5, '执行者制造', '深圳', '123456789@qq.com', '2022-04-08 01:39:42.903934', 'Admin', '2022-04-08 01:39:42.909898');

-- ----------------------------
-- Table structure for notifications_notification
-- ----------------------------
DROP TABLE IF EXISTS `notifications_notification`;
CREATE TABLE `notifications_notification`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `unread` tinyint(1) NOT NULL,
  `actor_object_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `verb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `target_object_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `action_object_object_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `public` tinyint(1) NOT NULL,
  `action_object_content_type_id` int(11) NULL DEFAULT NULL,
  `actor_content_type_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `target_content_type_id` int(11) NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `emailed` tinyint(1) NOT NULL,
  `data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co`(`action_object_content_type_id`) USING BTREE,
  INDEX `notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co`(`actor_content_type_id`) USING BTREE,
  INDEX `notifications_notifi_target_content_type__ccb24d88_fk_django_co`(`target_content_type_id`) USING BTREE,
  INDEX `notifications_notification_deleted_b32b69e6`(`deleted`) USING BTREE,
  INDEX `notifications_notification_emailed_23a5ad81`(`emailed`) USING BTREE,
  INDEX `notifications_notification_public_1bc30b1c`(`public`) USING BTREE,
  INDEX `notifications_notification_unread_cce4be30`(`unread`) USING BTREE,
  INDEX `notifications_notification_timestamp_6a797bad`(`timestamp`) USING BTREE,
  INDEX `notifications_notification_recipient_id_unread_253aadc9_idx`(`recipient_id`, `unread`) USING BTREE,
  CONSTRAINT `notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co` FOREIGN KEY (`action_object_content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co` FOREIGN KEY (`actor_content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `notifications_notifi_target_content_type__ccb24d88_fk_django_co` FOREIGN KEY (`target_content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `notifications_notification_recipient_id_d055f3f0_fk_auth_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notifications_notification
-- ----------------------------

-- ----------------------------
-- Table structure for profile
-- ----------------------------
DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bio` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `profile_pic` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone_number` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `profile_user_id_2aeb6f6b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of profile
-- ----------------------------
INSERT INTO `profile` VALUES (1, '超级管理员', 'profile/20220410/avatar-2.jpg', 18, 'm', '12345678910', '123456789@qq.com', 1);

-- ----------------------------
-- Table structure for user_activity
-- ----------------------------
DROP TABLE IF EXISTS `user_activity`;
CREATE TABLE `user_activity`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `operation_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `target_model` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `delete_status` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_activity
-- ----------------------------
INSERT INTO `user_activity` VALUES (1, 'admin', '2022-04-08 01:36:21.399917', 'success', '位置', '创建位置 << 01车厢 >>', 0);
INSERT INTO `user_activity` VALUES (2, 'admin', '2022-04-08 01:36:26.367545', 'success', '位置', '创建位置 << 02车厢 >>', 0);
INSERT INTO `user_activity` VALUES (3, 'admin', '2022-04-08 01:36:32.080750', 'success', '位置', '创建位置 << 03车厢 >>', 0);
INSERT INTO `user_activity` VALUES (4, 'admin', '2022-04-08 01:36:37.132222', 'success', '位置', '创建位置 << 04车厢 >>', 0);
INSERT INTO `user_activity` VALUES (5, 'admin', '2022-04-08 01:36:45.754579', 'success', '位置', '创建位置 << 05车厢 >>', 0);
INSERT INTO `user_activity` VALUES (6, 'admin', '2022-04-08 01:36:52.359576', 'success', '位置', '创建位置 << 06车厢 >>', 0);
INSERT INTO `user_activity` VALUES (7, 'admin', '2022-04-08 01:36:58.261406', 'success', '位置', '创建位置 << 07车厢 >>', 0);
INSERT INTO `user_activity` VALUES (8, 'admin', '2022-04-08 01:37:03.676411', 'success', '位置', '创建位置 << 08车厢 >>', 0);
INSERT INTO `user_activity` VALUES (9, 'admin', '2022-04-08 01:37:18.273207', 'success', '制造商', '创建制造商 << 迪玛智造 >>', 0);
INSERT INTO `user_activity` VALUES (10, 'admin', '2022-04-08 01:37:28.169853', 'success', '制造商', '创建制造商 << 易库 >>', 0);
INSERT INTO `user_activity` VALUES (11, 'admin', '2022-04-08 01:37:45.548882', 'success', '制造商', '创建制造商 << 蒙德 >>', 0);
INSERT INTO `user_activity` VALUES (12, 'admin', '2022-04-08 01:38:08.833369', 'success', '制造商', '创建制造商 << 智能智造 >>', 0);
INSERT INTO `user_activity` VALUES (13, 'admin', '2022-04-08 01:39:42.907777', 'success', '制造商', '创建制造商 << 执行者制造 >>', 0);
INSERT INTO `user_activity` VALUES (14, 'admin', '2022-04-08 01:40:46.503494', 'success', '行李锁', '创建行李锁 << 小易1号 >>', 0);
INSERT INTO `user_activity` VALUES (15, 'admin', '2022-04-08 01:41:12.612369', 'success', '行李锁', '创建行李锁 << 迪宝1号 >>', 0);
INSERT INTO `user_activity` VALUES (16, 'admin', '2022-04-08 01:41:51.737002', 'success', '行李锁', '创建行李锁 << 执行者1号 >>', 0);
INSERT INTO `user_activity` VALUES (17, 'admin', '2022-04-08 01:42:20.444120', 'success', '行李锁', '创建行李锁 << 安全卫士1号 >>', 0);
INSERT INTO `user_activity` VALUES (18, 'admin', '2022-04-08 01:42:53.129780', 'success', '行李锁', '创建行李锁 << 智能小白 >>', 0);
INSERT INTO `user_activity` VALUES (19, 'admin', '2022-04-08 01:44:54.047406', 'success', '使用记录', '<< 用户01 >> 使用了行李锁 << 智能小白 >>', 0);
INSERT INTO `user_activity` VALUES (20, 'admin', '2022-04-08 01:45:28.580381', 'success', '使用记录', '<< 用户02 >> 使用了行李锁 << 小易1号 >>', 0);
INSERT INTO `user_activity` VALUES (21, 'admin', '2022-04-08 01:46:03.960312', 'success', '使用记录', '<< 用户03 >> 使用了行李锁 << 迪宝1号 >>', 0);
INSERT INTO `user_activity` VALUES (22, 'admin', '2022-04-08 01:46:38.154750', 'success', '使用记录', '<< 用户04 >> 使用了行李锁 << 安全卫士1号 >>', 0);
INSERT INTO `user_activity` VALUES (23, 'admin', '2022-04-08 01:47:25.682634', 'success', '使用记录', '<< 用户05 >> 使用了行李锁 << 执行者1号 >>', 0);
INSERT INTO `user_activity` VALUES (24, 'admin', '2022-04-08 01:47:56.399874', 'success', '使用记录', '<< 用户06 >> 使用了行李锁 << 迪宝1号 >>', 0);
INSERT INTO `user_activity` VALUES (25, 'admin', '2022-04-08 01:48:00.696119', 'info', '使用记录', '关闭 << 用户06 >> 使用 << 迪宝1号 >> 的记录', 0);
INSERT INTO `user_activity` VALUES (26, 'admin', '2022-04-08 01:48:03.461773', 'info', '使用记录', '关闭 << 用户05 >> 使用 << 执行者1号 >> 的记录', 0);
INSERT INTO `user_activity` VALUES (27, 'admin', '2022-04-08 01:48:06.316263', 'info', '使用记录', '关闭 << 用户04 >> 使用 << 安全卫士1号 >> 的记录', 0);
INSERT INTO `user_activity` VALUES (28, 'admin', '2022-04-08 01:48:09.699222', 'info', '使用记录', '关闭 << 用户03 >> 使用 << 迪宝1号 >> 的记录', 0);
INSERT INTO `user_activity` VALUES (29, 'admin', '2022-04-08 01:48:12.388774', 'info', '使用记录', '关闭 << 用户02 >> 使用 << 小易1号 >> 的记录', 0);
INSERT INTO `user_activity` VALUES (30, 'admin', '2022-04-08 01:48:36.579299', 'success', '使用记录', '<< 用户02 >> 使用了行李锁 << 小易1号 >>', 0);
INSERT INTO `user_activity` VALUES (31, 'admin', '2022-04-08 01:49:34.729773', 'warning', '行李锁', '更新行李锁 << 智能小白 >>', 0);
INSERT INTO `user_activity` VALUES (32, 'admin', '2022-04-08 01:49:46.118827', 'warning', '行李锁', '更新行李锁 << 迪宝1号 >>', 0);
INSERT INTO `user_activity` VALUES (33, 'admin', '2022-04-08 01:50:02.433522', 'warning', '行李锁', '更新行李锁 << 智能小白 >>', 0);
INSERT INTO `user_activity` VALUES (34, 'admin', '2022-04-08 01:52:14.424247', 'success', '用户', '创建新用户 << test1 >>', 0);

SET FOREIGN_KEY_CHECKS = 1;
