/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.102.129
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : 192.168.102.129:3306
 Source Schema         : vjs

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 17/09/2024 17:22:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`  (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
  `status` tinyint NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dept
-- ----------------------------

-- ----------------------------
-- Table structure for job_info
-- ----------------------------
DROP TABLE IF EXISTS `job_info`;
CREATE TABLE `job_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_type` tinyint NOT NULL COMMENT '1:fixed_rate 0:cron',
  `job_next_time` bigint NULL DEFAULT NULL COMMENT '下次执行时间',
  `job_rate` bigint NULL DEFAULT NULL COMMENT '周期单位（ms）',
  `job_cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `trigger_status` tinyint NULL DEFAULT 0 COMMENT '触发状态,1正常运行 0停止',
  `trigger_last_time` datetime NULL DEFAULT NULL COMMENT '上次调度时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '更新人',
  `next_time` datetime NULL DEFAULT NULL COMMENT '时间形式',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `job_name`(`job_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of job_info
-- ----------------------------
INSERT INTO `job_info` VALUES (6, 'print', '测试', 2, 1724316963486, NULL, '0 * * * * ?', 0, '2024-09-17 17:19:53', NULL, '2024-08-22 16:44:37', '2024-08-22 16:44:37', 'admin', 'admin', NULL);
INSERT INTO `job_info` VALUES (7, 'print2', '打印2', 1, 1724332558960, 5, NULL, 0, '2024-08-24 15:12:45', NULL, '2024-08-22 21:15:59', '2024-08-22 21:15:59', 'admin', 'admin', NULL);

-- ----------------------------
-- Table structure for job_log
-- ----------------------------
DROP TABLE IF EXISTS `job_log`;
CREATE TABLE `job_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `trigger_time` datetime NOT NULL COMMENT '触发时间',
  `handle_time` bigint NULL DEFAULT NULL COMMENT '处理时间(ms)',
  `handle_status` tinyint NULL DEFAULT NULL COMMENT '处理状态,1成功,2失败',
  `error_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '错误信息',
  `trigger_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '触发信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7738 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of job_log
-- ----------------------------
INSERT INTO `job_log` VALUES (7700, 6, '2024-09-13 13:06:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7701, 6, '2024-09-13 13:07:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7702, 6, '2024-09-13 13:08:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7703, 6, '2024-09-13 13:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7704, 6, '2024-09-13 13:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7705, 6, '2024-09-13 13:11:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7706, 6, '2024-09-13 13:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7707, 6, '2024-09-13 13:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7708, 6, '2024-09-13 13:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7709, 6, '2024-09-13 13:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7710, 6, '2024-09-13 13:16:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7711, 6, '2024-09-13 13:17:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7712, 6, '2024-09-13 13:18:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7713, 6, '2024-09-13 13:19:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7714, 6, '2024-09-13 13:20:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7715, 6, '2024-09-13 13:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7716, 6, '2024-09-13 13:22:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7717, 6, '2024-09-13 13:23:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7718, 6, '2024-09-13 13:24:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7719, 6, '2024-09-13 13:25:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7720, 6, '2024-09-13 13:26:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7721, 6, '2024-09-13 13:27:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7722, 6, '2024-09-13 13:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7723, 6, '2024-09-13 13:30:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7724, 6, '2024-09-13 13:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7725, 6, '2024-09-13 13:32:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7726, 6, '2024-09-13 13:33:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7727, 6, '2024-09-13 13:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7728, 6, '2024-09-13 13:35:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7729, 6, '2024-09-13 13:36:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7730, 6, '2024-09-13 13:37:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7731, 6, '2024-09-13 13:38:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7732, 6, '2024-09-13 13:39:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7733, 6, '2024-09-13 13:40:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7734, 6, '2024-09-13 13:41:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7735, 6, '2024-09-13 14:08:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7736, 6, '2024-09-13 14:09:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7737, 6, '2024-09-17 17:19:00', 0, 1, NULL, 'success');

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log`  (
  `id` bigint NOT NULL,
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录ip',
  `location` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip归属地',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  `login_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录人',
  `token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES (1828090658359898114, '0:0:0:0:0:0:0:1', '内网', '2024-08-26 23:22:32', 'admin', '44f6e0e6df1c3ca7f89384f0ca8f3acc');
INSERT INTO `login_log` VALUES (1828094469195550722, '0:0:0:0:0:0:0:1', '内网', '2024-08-26 23:37:40', 'admin', '2f67afe774447ef2c9d76edbb4ce9f90');
INSERT INTO `login_log` VALUES (1828094513596452865, '0:0:0:0:0:0:0:1', '内网', '2024-08-26 23:37:51', 'admin', 'df688bf88393ca4bd615cd5eec814f63');
INSERT INTO `login_log` VALUES (1828102963810279425, '0:0:0:0:0:0:0:1', '内网', '2024-08-27 00:11:26', 'huawei', '1122f5c75efba983d6398f7565f6ead0');
INSERT INTO `login_log` VALUES (1828108442410164225, '0:0:0:0:0:0:0:1', '内网', '2024-08-27 00:33:12', 'admin', '916c8810c98cfe330d6b66bb72a5caaf');
INSERT INTO `login_log` VALUES (1828306294201712642, '0:0:0:0:0:0:0:1', '内网', '2024-08-27 13:39:23', 'admin', '6f8356acaf1e512c177b891482e268cc');
INSERT INTO `login_log` VALUES (1828326871658516481, '0:0:0:0:0:0:0:1', '内网', '2024-08-27 15:01:10', 'admin', '2f5de0c18ceca8dcd20ddd5101f92866');
INSERT INTO `login_log` VALUES (1828653560024395778, '0:0:0:0:0:0:0:1', '内网', '2024-08-28 12:39:18', 'admin', '68b073945d2918d817ac2f3109468966');
INSERT INTO `login_log` VALUES (1828731277679910914, '0:0:0:0:0:0:0:1', '内网', '2024-08-28 17:48:07', 'admin', '6a983bf2502ba5f57ab9670cc0416658');
INSERT INTO `login_log` VALUES (1828746200459800578, '0:0:0:0:0:0:0:1', '内网', '2024-08-28 18:47:25', 'admin', '5dbbb2689bf70b27618b5777859ffcdf');
INSERT INTO `login_log` VALUES (1828746518513872897, '0:0:0:0:0:0:0:1', '内网', '2024-08-28 18:48:41', 'admin', '8631195efb057d6317a80945e1566dd2');
INSERT INTO `login_log` VALUES (1828747718621687810, '0:0:0:0:0:0:0:1', '内网', '2024-08-28 18:53:27', 'admin', '9f4d8f880d198e8d6e461979be6ff844');
INSERT INTO `login_log` VALUES (1829092486090452994, '0:0:0:0:0:0:0:1', '内网', '2024-08-29 17:43:26', 'admin', '20498039d4e71ddcc4e924a37359efb8');
INSERT INTO `login_log` VALUES (1829113346406862849, '0:0:0:0:0:0:0:1', '内网', '2024-08-29 19:06:20', 'admin', 'e9a3d24a406ffaec098d99907c2d3655');
INSERT INTO `login_log` VALUES (1833478999557390338, '0:0:0:0:0:0:0:1', '内网', '2024-09-10 20:13:53', 'admin', '667626c0b23dd9845c3a06692c902ab1');
INSERT INTO `login_log` VALUES (1833479146047651842, '0:0:0:0:0:0:0:1', '内网', '2024-09-10 20:14:27', 'admin', '59bd6c100ca74fc689ee7e8a98ae168b');
INSERT INTO `login_log` VALUES (1833796968648929282, '0:0:0:0:0:0:0:1', '内网', '2024-09-11 17:17:22', 'admin', '9dc3ff47197b56dde3de241664c20fe8');
INSERT INTO `login_log` VALUES (1833798300805980162, '0:0:0:0:0:0:0:1', '内网', '2024-09-11 17:22:40', 'admin', 'd64d15fc4795fd0cb1e93e267aaaf957');
INSERT INTO `login_log` VALUES (1833798401519517698, '0:0:0:0:0:0:0:1', '内网', '2024-09-11 17:23:04', 'admin', '5781a0c60fdc67ce2d638b97826ef8c1');
INSERT INTO `login_log` VALUES (1833798725219176450, '0:0:0:0:0:0:0:1', '内网', '2024-09-11 17:24:21', 'admin', 'feea89a229dce67e484e64334c391152');
INSERT INTO `login_log` VALUES (1834455418542227458, '0:0:0:0:0:0:0:1', '内网', '2024-09-13 12:53:49', 'admin', '333831ea44e9174ba3cb7e854ea9c695');
INSERT INTO `login_log` VALUES (1835971735669821441, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 17:19:07', 'admin', '8087a5963ac52224a08e9a7b28774519');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` bigint NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单id',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由路径',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单标题',
  `level` tinyint NULL DEFAULT 1 COMMENT '菜单层级 1 一级菜单 2 二级菜单 3 三级菜单',
  `type` tinyint NULL DEFAULT 0 COMMENT '菜单类型 0目录 1菜单 2其他',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1正常 0禁用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `redirect` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '重定向',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'admin' COMMENT '创建人',
  `link` tinyint NULL DEFAULT 0 COMMENT '是否外链 0非外链 1外链',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 'system', 0, 'layout/index', '/system', 3, '系统管理', 1, 0, 'Setting', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', '/system/user', 'admin', 0);
INSERT INTO `menu` VALUES (2, 'user', 1, 'system/user/index', '/system/user', 3, '用户管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (3, 'role', 1, 'system/role/index', '/system/role', 7, '角色管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (4, 'menu', 1, 'system/menu/index', '/system/menu', 8, '菜单管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (5, 'permission', 1, 'system/permission/index', '/system/permission', 9, '权限管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (6, 'user-add', 1, 'system/user/detail/index', '/system/user/add', 4, '新增用户', 2, 2, 'User', 1, '2024-08-02 12:51:37', NULL, '2024-08-02 12:51:37', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (7, 'user-edit', 1, 'system/user/detail/index', '/system/user/edit/:userId', 5, '编辑用户', 2, 2, 'User', 1, '2024-08-02 13:14:49', NULL, '2024-08-02 13:14:49', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (8, 'user-detail', 1, 'system/user/detail/index', '/system/user/detail/:userId', 2, '用户详细', 2, 2, 'User', 1, '2024-08-02 13:14:49', 'admin', '2024-08-02 13:14:49', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1823348525811974145, 'log', 1, 'system/log/index', '/system/log', 7, '日志管理', 2, 1, 'Calendar', 1, '2024-08-13 21:18:59', NULL, '2024-08-13 21:18:59', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1823701366858686465, 'apiDocument', 0, NULL, 'http://localhost:8080/api/swagger-ui/index.html', 13, '接口文档', 1, 1, 'ChatLineSquare', 1, '2024-08-14 20:41:03', 'admin', '2024-08-14 20:41:03', NULL, 'admin', 1);
INSERT INTO `menu` VALUES (1824754469368238082, 'generator', 1, 'system/generator/index', '/system/generator', 8, '文档生成', 2, 1, 'Box', 1, '2024-08-17 18:25:42', 'admin', '2024-08-17 18:25:42', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1825472650722430977, 'cache', 1, 'system/cache/index', '/system/cache', 10, '缓存管理', 2, 1, 'BellFilled', 1, '2024-08-19 17:59:30', 'admin', '2024-08-19 17:59:30', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1826103825019232257, 'cacheInfo', 1825472650722430977, 'system/cache/info', '/system/cache/info/:key', 1, '缓存详细', 3, 2, 'User', 1, '2024-08-21 11:47:34', 'admin', '2024-08-21 11:47:34', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1826235764657106945, 'schedule', 1, NULL, '/system/schedule', 11, '任务调度', 2, 0, 'Bicycle', 1, '2024-08-21 20:31:51', 'admin', '2024-08-21 20:31:51', '/system/schedule/job', 'admin', 0);
INSERT INTO `menu` VALUES (1826236194250305537, 'job', 1826235764657106945, 'system/schedule/job', '/system/schedule/job', 2, '任务管理', 3, 1, 'AlarmClock', 1, '2024-08-21 20:33:33', 'admin', '2024-08-21 20:33:33', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1826236706106388481, 'scheduleLog', 1826235764657106945, 'system/schedule/log', '/system/schedule/log', 3, '调度日志', 3, 1, 'DocumentCopy', 1, '2024-08-21 20:35:35', 'admin', '2024-08-21 20:35:35', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1828029462176948226, 'loginLog', 1, 'system/loginLog/index', '/system/loginLog', 12, '登录日志', 2, 1, 'ChatLineRound', 1, '2024-08-26 19:19:22', 'admin', '2024-08-26 19:19:22', NULL, 'admin', 0);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限标识',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限描述',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'system:user:add', '添加用户', NULL, '2024-08-04 17:59:29', NULL, NULL);
INSERT INTO `permission` VALUES (2, 'system:user:edit', '编辑用户', NULL, '2024-08-04 17:59:29', NULL, NULL);
INSERT INTO `permission` VALUES (3, 'system:user:remove', '删除用户', NULL, '2024-08-04 17:59:29', NULL, NULL);
INSERT INTO `permission` VALUES (4, 'system:user:query', '查看用户', NULL, '2024-08-04 17:59:29', NULL, NULL);
INSERT INTO `permission` VALUES (6, 'system:role:add', '新增角色', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (7, 'system:role:edit', '修改角色', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (8, 'system:role:remove', '删除角色', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (9, 'system:menu:query', '查询菜单', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (10, 'system:menu:add', '新增菜单', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (11, 'system:menu:edit', '修改菜单', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (12, 'system:menu:remove', '删除菜单', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (13, 'system:permission:query', '查询权限', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (14, 'system:permission:add', '新增权限', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (15, 'system:permission:edit', '修改权限', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (16, 'system:permission:remove', '删除权限', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (1820304541141196802, 'system:role:query', '角色查询', 'admin', '2024-08-05 11:43:17', NULL, '2024-08-05 11:43:17');
INSERT INTO `permission` VALUES (1823671284207239169, 'system:log:query', '查询日志', 'admin', '2024-08-14 18:41:31', NULL, '2024-08-14 18:41:31');
INSERT INTO `permission` VALUES (1823671879701938178, 'system:setting:query', '设置查询', 'admin', '2024-08-14 18:43:53', NULL, '2024-08-14 18:43:53');
INSERT INTO `permission` VALUES (1823942327941591042, 'system:admin:edit', '模式修改', 'admin', '2024-08-15 12:38:33', 'admin', '2024-08-15 12:38:33');
INSERT INTO `permission` VALUES (1823942560700297217, 'system:admin:query', '模式查询', 'admin', '2024-08-15 12:39:28', 'admin', '2024-08-15 12:39:28');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'admin' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '系统管理员', 'admin', '2024-08-04 17:46:59', NULL, NULL);
INSERT INTO `role` VALUES (2, '总管', 'admin', '2024-08-04 17:46:59', NULL, NULL);
INSERT INTO `role` VALUES (3, '大卫', 'admin', '2024-08-04 17:46:59', NULL, NULL);

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `id` bigint NOT NULL,
  `role_id` bigint NOT NULL COMMENT '角色id',
  `menu_id` bigint NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1834455594795270145, 2, 1);
INSERT INTO `role_menu` VALUES (1834455594795270146, 2, 8);
INSERT INTO `role_menu` VALUES (1834455594795270147, 2, 2);
INSERT INTO `role_menu` VALUES (1834455594795270148, 2, 6);
INSERT INTO `role_menu` VALUES (1834455594858184705, 2, 7);
INSERT INTO `role_menu` VALUES (1834455594858184706, 2, 1823348525811974145);
INSERT INTO `role_menu` VALUES (1834455594858184707, 2, 3);
INSERT INTO `role_menu` VALUES (1834455594858184708, 2, 4);
INSERT INTO `role_menu` VALUES (1834455594858184709, 2, 1824754469368238082);
INSERT INTO `role_menu` VALUES (1834455594858184710, 2, 5);
INSERT INTO `role_menu` VALUES (1834455594858184711, 2, 1823701366858686465);
INSERT INTO `role_menu` VALUES (1834455594858184712, 2, 1828029462176948226);
INSERT INTO `role_menu` VALUES (1834455594858184713, 2, 1826235764657106945);
INSERT INTO `role_menu` VALUES (1834455594858184714, 2, 1826236194250305537);
INSERT INTO `role_menu` VALUES (1834455594858184715, 2, 1826236706106388481);
INSERT INTO `role_menu` VALUES (1834455594858184717, 2, 1825472650722430977);
INSERT INTO `role_menu` VALUES (1834455594858184718, 2, 1826103825019232257);
INSERT INTO `role_menu` VALUES (1834455631055028226, 3, 1);
INSERT INTO `role_menu` VALUES (1834455631055028227, 3, 1823701366858686465);
INSERT INTO `role_menu` VALUES (1834455631055028228, 3, 8);
INSERT INTO `role_menu` VALUES (1834455631055028229, 3, 2);
INSERT INTO `role_menu` VALUES (1834455631055028230, 3, 6);
INSERT INTO `role_menu` VALUES (1834455631055028231, 3, 7);
INSERT INTO `role_menu` VALUES (1834455631055028232, 3, 3);
INSERT INTO `role_menu` VALUES (1834455631055028233, 3, 1823348525811974145);
INSERT INTO `role_menu` VALUES (1834455631055028234, 3, 4);
INSERT INTO `role_menu` VALUES (1834455631055028235, 3, 1824754469368238082);
INSERT INTO `role_menu` VALUES (1834455631055028236, 3, 5);
INSERT INTO `role_menu` VALUES (1834455631055028237, 3, 1825472650722430977);
INSERT INTO `role_menu` VALUES (1834455631055028238, 3, 1826103825019232257);
INSERT INTO `role_menu` VALUES (1834455631055028239, 3, 1826235764657106945);
INSERT INTO `role_menu` VALUES (1834455631055028240, 3, 1826236194250305537);
INSERT INTO `role_menu` VALUES (1834455631055028241, 3, 1826236706106388481);
INSERT INTO `role_menu` VALUES (1834455631055028242, 3, 1828029462176948226);

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` bigint NOT NULL,
  `role_id` bigint NOT NULL COMMENT '角色id',
  `permission_id` bigint NOT NULL COMMENT '权限标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1823963596275683330, 3, 1823942560700297217);
INSERT INTO `role_permission` VALUES (1823963596275683331, 3, 1820304541141196802);
INSERT INTO `role_permission` VALUES (1823963596275683332, 3, 1823671284207239169);
INSERT INTO `role_permission` VALUES (1823963596275683333, 3, 15);
INSERT INTO `role_permission` VALUES (1823963596275683334, 3, 14);
INSERT INTO `role_permission` VALUES (1823963596275683335, 3, 11);
INSERT INTO `role_permission` VALUES (1823963596275683336, 3, 8);
INSERT INTO `role_permission` VALUES (1823963596275683337, 3, 4);
INSERT INTO `role_permission` VALUES (1823963596275683338, 3, 1);
INSERT INTO `role_permission` VALUES (1823963596275683339, 3, 2);
INSERT INTO `role_permission` VALUES (1823963596275683340, 3, 6);
INSERT INTO `role_permission` VALUES (1823963596275683341, 3, 9);
INSERT INTO `role_permission` VALUES (1823963596275683342, 3, 12);
INSERT INTO `role_permission` VALUES (1823963596275683343, 3, 3);
INSERT INTO `role_permission` VALUES (1823963596275683344, 3, 7);
INSERT INTO `role_permission` VALUES (1823963596275683345, 3, 10);
INSERT INTO `role_permission` VALUES (1823963596275683346, 3, 13);
INSERT INTO `role_permission` VALUES (1823963596275683347, 3, 16);
INSERT INTO `role_permission` VALUES (1823963596275683348, 3, 1823671879701938178);
INSERT INTO `role_permission` VALUES (1834455445385773057, 1, 1);
INSERT INTO `role_permission` VALUES (1834455445385773058, 1, 2);
INSERT INTO `role_permission` VALUES (1834455445385773059, 1, 3);
INSERT INTO `role_permission` VALUES (1834455445385773060, 1, 4);
INSERT INTO `role_permission` VALUES (1834455445385773061, 1, 6);
INSERT INTO `role_permission` VALUES (1834455445385773062, 1, 7);
INSERT INTO `role_permission` VALUES (1834455445385773063, 1, 8);
INSERT INTO `role_permission` VALUES (1834455445385773064, 1, 9);
INSERT INTO `role_permission` VALUES (1834455445385773065, 1, 10);
INSERT INTO `role_permission` VALUES (1834455445385773066, 1, 11);
INSERT INTO `role_permission` VALUES (1834455445385773067, 1, 12);
INSERT INTO `role_permission` VALUES (1834455445385773068, 1, 13);
INSERT INTO `role_permission` VALUES (1834455445385773069, 1, 14);
INSERT INTO `role_permission` VALUES (1834455445385773070, 1, 15);
INSERT INTO `role_permission` VALUES (1834455445385773071, 1, 16);
INSERT INTO `role_permission` VALUES (1834455445385773072, 1, 1820304541141196802);
INSERT INTO `role_permission` VALUES (1834455445385773073, 1, 1823671284207239169);
INSERT INTO `role_permission` VALUES (1834455445385773074, 1, 1823671879701938178);
INSERT INTO `role_permission` VALUES (1834455445385773075, 1, 1823942327941591042);
INSERT INTO `role_permission` VALUES (1834455483050622977, 2, 1823942560700297217);
INSERT INTO `role_permission` VALUES (1834455483050622978, 2, 14);
INSERT INTO `role_permission` VALUES (1834455483050622979, 2, 15);
INSERT INTO `role_permission` VALUES (1834455483050622980, 2, 12);
INSERT INTO `role_permission` VALUES (1834455483050622981, 2, 8);
INSERT INTO `role_permission` VALUES (1834455483050622982, 2, 11);
INSERT INTO `role_permission` VALUES (1834455483050622983, 2, 1);
INSERT INTO `role_permission` VALUES (1834455483050622984, 2, 4);
INSERT INTO `role_permission` VALUES (1834455483050622985, 2, 2);
INSERT INTO `role_permission` VALUES (1834455483050622986, 2, 6);
INSERT INTO `role_permission` VALUES (1834455483050622987, 2, 9);
INSERT INTO `role_permission` VALUES (1834455483050622988, 2, 3);
INSERT INTO `role_permission` VALUES (1834455483050622989, 2, 7);
INSERT INTO `role_permission` VALUES (1834455483050622990, 2, 10);
INSERT INTO `role_permission` VALUES (1834455483050622991, 2, 13);
INSERT INTO `role_permission` VALUES (1834455483050622992, 2, 16);
INSERT INTO `role_permission` VALUES (1834455483050622993, 2, 1823671879701938178);
INSERT INTO `role_permission` VALUES (1834455483050622994, 2, 1823942327941591042);
INSERT INTO `role_permission` VALUES (1834455483050622995, 2, 1820304541141196802);
INSERT INTO `role_permission` VALUES (1834455483050622996, 2, 1823671284207239169);

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting`  (
  `id` bigint NOT NULL,
  `permission_mode` tinyint NULL DEFAULT 0 COMMENT '0 - 资本家模式, 我的附庸可以拥有我全部权力;  1 - 封建模式, 我的附庸只能拥有我创建的权力 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of setting
-- ----------------------------
INSERT INTO `setting` VALUES (1, 0);

-- ----------------------------
-- Table structure for sys_operation_log
-- ----------------------------
DROP TABLE IF EXISTS operation_log;
CREATE TABLE `sys_operation_log`  (
  `id` bigint NOT NULL COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `operation_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `operation_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `operation_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间,单位ms',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_operation_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ct`(`operation_time` ASC) USING BTREE,
  INDEX `idx_sys_operation_log_s`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_operation_log
-- ----------------------------
INSERT INTO operation_log VALUES (1824408668871884801, '新增用户', 1, 'com.chq.app.controller.UserController.add()', 'POST', 1, 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2024-08-16 19:31:37.168231\",\"email\":\"2156\",\"id\":\"1824408668771221506\",\"roles\":[{\"id\":\"3\"}],\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2024-08-16 19:31:37.168231\",\"username\":\"wqeeqwe\"}', '{\"code\":200,\"data\":1}', 0, '', '2024-08-16 19:31:37', 96);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '加密后的密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif' COMMENT '头像',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1正常 0禁用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$8rSmx1t3VoitB2krA.2uuOUwuTn6wJqxYpZ0SchTCDo9Z7ri1zdmG', '/minio/app/4823f861852d17ec03b15fa165416b36.avif', 1, '2024-07-30 18:32:36', '2024-08-23 21:28:59', 'admin', 'admin', 'chq_109@sina.com');
INSERT INTO `user` VALUES (2, 'huawei', '$2a$10$kOCJgPOMNecWEPUi0l.gaeM6MVMMCfZFJs0Hngx5QuQBq1LwBhrAi', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, '2024-07-30 20:48:27', '2024-08-15 14:01:24', 'admin', 'admin', 'hq@qq.com');
INSERT INTO `user` VALUES (3, 'dawei1', '$2a$10$wiNdBO3DMYF.0Pk8kHf/NekSXoYdFI.6AV.AuprXXj/6kYQH3reO2', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, '2024-08-14 18:40:03', '2024-08-14 18:40:03', NULL, 'admin', NULL);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL COMMENT '用户id',
  `role_id` bigint NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 3, 3);
INSERT INTO `user_role` VALUES (1826974920387665921, 1, 1);

SET FOREIGN_KEY_CHECKS = 1;
