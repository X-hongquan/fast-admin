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

 Date: 25/08/2024 00:07:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_info
-- ----------------------------
INSERT INTO `job_info` VALUES (6, 'print', '测试', 2, 1724316963486, NULL, '0 * * * * ?', 0, '2024-08-24 23:45:08', NULL, '2024-08-22 16:44:37', '2024-08-22 16:44:37', 'admin', 'admin', NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 7128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_log
-- ----------------------------
INSERT INTO `job_log` VALUES (7078, 6, '2024-08-24 19:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7079, 6, '2024-08-24 19:45:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7080, 6, '2024-08-24 19:46:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7081, 6, '2024-08-24 19:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7082, 6, '2024-08-24 19:48:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7083, 6, '2024-08-24 19:49:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7084, 6, '2024-08-24 19:50:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7085, 6, '2024-08-24 19:51:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7086, 6, '2024-08-24 19:52:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7087, 6, '2024-08-24 19:53:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7088, 6, '2024-08-24 19:54:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7089, 6, '2024-08-24 19:55:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7090, 6, '2024-08-24 19:56:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7091, 6, '2024-08-24 19:57:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7092, 6, '2024-08-24 19:58:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7093, 6, '2024-08-24 19:59:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7094, 6, '2024-08-24 20:00:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7095, 6, '2024-08-24 20:01:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7096, 6, '2024-08-24 20:02:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7097, 6, '2024-08-24 20:03:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7098, 6, '2024-08-24 20:04:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7099, 6, '2024-08-24 20:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7100, 6, '2024-08-24 20:06:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7101, 6, '2024-08-24 20:07:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7102, 6, '2024-08-24 20:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7103, 6, '2024-08-24 20:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7104, 6, '2024-08-24 20:10:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7105, 6, '2024-08-24 20:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7106, 6, '2024-08-24 20:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7107, 6, '2024-08-24 20:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7108, 6, '2024-08-24 22:33:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7109, 6, '2024-08-24 22:35:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7110, 6, '2024-08-24 22:36:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7111, 6, '2024-08-24 22:37:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7112, 6, '2024-08-24 22:38:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7113, 6, '2024-08-24 22:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7114, 6, '2024-08-24 22:40:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7115, 6, '2024-08-24 22:41:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7116, 6, '2024-08-24 22:42:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7117, 6, '2024-08-24 22:43:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7118, 6, '2024-08-24 22:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7119, 6, '2024-08-24 22:45:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7120, 6, '2024-08-24 22:46:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7121, 6, '2024-08-24 22:47:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7122, 6, '2024-08-24 22:48:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7123, 6, '2024-08-24 22:49:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7124, 6, '2024-08-24 22:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7125, 6, '2024-08-24 23:43:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7126, 6, '2024-08-24 23:44:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7127, 6, '2024-08-24 23:45:00', 0, 1, NULL, 'success');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1824758343051251713, 2, 1);
INSERT INTO `role_menu` VALUES (1824758343051251714, 2, 1823701366858686465);
INSERT INTO `role_menu` VALUES (1824758343051251715, 2, 8);
INSERT INTO `role_menu` VALUES (1824758343051251716, 2, 7);
INSERT INTO `role_menu` VALUES (1824758343051251717, 2, 6);
INSERT INTO `role_menu` VALUES (1824758343051251718, 2, 2);
INSERT INTO `role_menu` VALUES (1824758343051251719, 2, 3);
INSERT INTO `role_menu` VALUES (1824758343051251720, 2, 4);
INSERT INTO `role_menu` VALUES (1824758343051251721, 2, 5);
INSERT INTO `role_menu` VALUES (1824758343051251722, 2, 1823348525811974145);
INSERT INTO `role_menu` VALUES (1824758343051251723, 2, 1824754469368238082);
INSERT INTO `role_menu` VALUES (1824758388488146946, 3, 1);
INSERT INTO `role_menu` VALUES (1824758388488146947, 3, 1823701366858686465);
INSERT INTO `role_menu` VALUES (1824758388488146948, 3, 2);
INSERT INTO `role_menu` VALUES (1824758388555255809, 3, 3);
INSERT INTO `role_menu` VALUES (1824758388555255810, 3, 4);
INSERT INTO `role_menu` VALUES (1824758388555255811, 3, 5);
INSERT INTO `role_menu` VALUES (1824758388555255812, 3, 8);
INSERT INTO `role_menu` VALUES (1824758388555255813, 3, 6);
INSERT INTO `role_menu` VALUES (1824758388555255814, 3, 7);
INSERT INTO `role_menu` VALUES (1824758388555255815, 3, 1824754469368238082);
INSERT INTO `role_menu` VALUES (1824758388555255816, 3, 1823348525811974145);

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` bigint NOT NULL,
  `role_id` bigint NOT NULL COMMENT '角色id',
  `permission_id` bigint NOT NULL COMMENT '权限标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1823963449642815490, 2, 1823942560700297217);
INSERT INTO `role_permission` VALUES (1823963449642815491, 2, 1823671284207239169);
INSERT INTO `role_permission` VALUES (1823963449642815492, 2, 1820304541141196802);
INSERT INTO `role_permission` VALUES (1823963449642815493, 2, 14);
INSERT INTO `role_permission` VALUES (1823963449642815494, 2, 15);
INSERT INTO `role_permission` VALUES (1823963449642815495, 2, 12);
INSERT INTO `role_permission` VALUES (1823963449642815496, 2, 8);
INSERT INTO `role_permission` VALUES (1823963449642815497, 2, 11);
INSERT INTO `role_permission` VALUES (1823963449642815498, 2, 1);
INSERT INTO `role_permission` VALUES (1823963449642815499, 2, 4);
INSERT INTO `role_permission` VALUES (1823963449642815500, 2, 2);
INSERT INTO `role_permission` VALUES (1823963449642815501, 2, 6);
INSERT INTO `role_permission` VALUES (1823963449705730050, 2, 9);
INSERT INTO `role_permission` VALUES (1823963449705730051, 2, 3);
INSERT INTO `role_permission` VALUES (1823963449705730052, 2, 7);
INSERT INTO `role_permission` VALUES (1823963449705730053, 2, 10);
INSERT INTO `role_permission` VALUES (1823963449705730054, 2, 13);
INSERT INTO `role_permission` VALUES (1823963449705730055, 2, 16);
INSERT INTO `role_permission` VALUES (1823963449705730056, 2, 1823671879701938178);
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

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting`  (
  `id` bigint NOT NULL,
  `permission_mode` tinyint NULL DEFAULT 0 COMMENT '0 - 资本家模式, 我的附庸可以拥有我全部权力;  1 - 封建模式, 我的附庸只能拥有我创建的权力 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setting
-- ----------------------------
INSERT INTO `setting` VALUES (1, 0);

-- ----------------------------
-- Table structure for sys_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operation_log`;
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operation_log
-- ----------------------------
INSERT INTO `sys_operation_log` VALUES (1824408668871884801, '新增用户', 1, 'com.chq.app.controller.UserController.add()', 'POST', 1, 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2024-08-16 19:31:37.168231\",\"email\":\"2156\",\"id\":\"1824408668771221506\",\"roles\":[{\"id\":\"3\"}],\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2024-08-16 19:31:37.168231\",\"username\":\"wqeeqwe\"}', '{\"code\":200,\"data\":1}', 0, '', '2024-08-16 19:31:37', 96);

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 3, 3);
INSERT INTO `user_role` VALUES (1826974920387665921, 1, 1);

SET FOREIGN_KEY_CHECKS = 1;
