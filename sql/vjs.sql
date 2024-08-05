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

 Date: 05/08/2024 21:36:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
INSERT INTO `menu` VALUES (1, 'system', 0, 'layout/index', '/system', 1, '系统管理', 1, 0, 'Setting', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', '/system/user', 'admin', 0);
INSERT INTO `menu` VALUES (2, 'user', 1, 'system/user/index', '/system/user', 1, '用户管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (3, 'role', 1, 'system/role/index', '/system/role', 2, '角色管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (4, 'menu', 1, 'system/menu/index', '/system/menu', 3, '菜单管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (5, 'permission', 1, 'system/permission/index', '/system/permission', 4, '权限管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (6, 'user-add', 1, 'system/user/detail/index', '/system/user/add', NULL, '新增用户', 2, 2, 'User', 1, '2024-08-02 12:51:37', NULL, '2024-08-02 12:51:37', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (7, 'user-edit', 1, 'system/user/detail/index', '/system/user/edit/:userId', NULL, '编辑用户', 2, 2, 'User', 1, '2024-08-02 13:14:49', NULL, '2024-08-02 13:14:49', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (8, 'user-detail', 1, 'system/user/detail/index', '/system/user/detail/:userId', NULL, '用户详细', 2, 2, 'User', 1, '2024-08-02 13:14:49', NULL, '2024-08-02 13:14:49', NULL, 'admin', 0);

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
  `update_by` datetime NULL DEFAULT NULL COMMENT '更新人',
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
INSERT INTO `permission` VALUES (8, 'system:role:delete', '删除角色', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (9, 'system:menu:query', '查询菜单', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (10, 'system:menu:add', '新增菜单', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (11, 'system:menu:edit', '修改菜单', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (12, 'system:menu:delete', '删除菜单', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (13, 'system:permission:query', '查询权限', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (14, 'system:permission:add', '新增权限', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (15, 'system:permission:edit', '修改权限', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (16, 'system:permission:delete', '删除权限', 'admin', '2024-08-05 06:43:50', NULL, NULL);
INSERT INTO `permission` VALUES (1820304541141196802, 'system:role:query', '角色查询', 'admin', '2024-08-05 11:43:17', NULL, '2024-08-05 11:43:17');

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
INSERT INTO `role` VALUES (1820351924566765570, 'huawei小弟', 'admin', '2024-08-05 14:51:34', NULL, '2024-08-05 14:51:34');
INSERT INTO `role` VALUES (1820352066497818626, 'eqwe', 'admin', '2024-08-05 14:52:08', NULL, '2024-08-05 14:52:08');
INSERT INTO `role` VALUES (1820352904444366850, 'huawei小弟的', 'huawei', '2024-08-05 14:55:28', NULL, '2024-08-05 14:55:28');

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
INSERT INTO `role_menu` VALUES (1820351651714707457, 2, 1);
INSERT INTO `role_menu` VALUES (1820351651714707458, 2, 6);
INSERT INTO `role_menu` VALUES (1820351651714707459, 2, 7);
INSERT INTO `role_menu` VALUES (1820351651714707460, 2, 8);
INSERT INTO `role_menu` VALUES (1820351651714707461, 2, 2);
INSERT INTO `role_menu` VALUES (1820351651714707462, 2, 3);
INSERT INTO `role_menu` VALUES (1820351651714707463, 2, 4);
INSERT INTO `role_menu` VALUES (1820351651714707464, 2, 5);
INSERT INTO `role_menu` VALUES (1820427946033197058, 1820352904444366850, 1);
INSERT INTO `role_menu` VALUES (1820427946033197059, 1820352904444366850, 6);
INSERT INTO `role_menu` VALUES (1820427946033197060, 1820352904444366850, 7);
INSERT INTO `role_menu` VALUES (1820427946033197061, 1820352904444366850, 8);
INSERT INTO `role_menu` VALUES (1820427946033197062, 1820352904444366850, 2);
INSERT INTO `role_menu` VALUES (1820427946033197063, 1820352904444366850, 3);
INSERT INTO `role_menu` VALUES (1820427946033197064, 1820352904444366850, 4);

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
INSERT INTO `role_permission` VALUES (1820308458193313793, 3, 3);
INSERT INTO `role_permission` VALUES (1820351613395546114, 2, 1);
INSERT INTO `role_permission` VALUES (1820351613395546115, 2, 2);
INSERT INTO `role_permission` VALUES (1820351613395546116, 2, 3);
INSERT INTO `role_permission` VALUES (1820351613395546117, 2, 4);
INSERT INTO `role_permission` VALUES (1820351613395546118, 2, 1820304541141196802);
INSERT INTO `role_permission` VALUES (1820351613395546119, 2, 14);
INSERT INTO `role_permission` VALUES (1820351613395546120, 2, 16);
INSERT INTO `role_permission` VALUES (1820351613395546121, 2, 13);
INSERT INTO `role_permission` VALUES (1820351613395546122, 2, 10);
INSERT INTO `role_permission` VALUES (1820351613395546123, 2, 7);
INSERT INTO `role_permission` VALUES (1820351613395546124, 2, 6);
INSERT INTO `role_permission` VALUES (1820351613395546125, 2, 9);
INSERT INTO `role_permission` VALUES (1820351613395546126, 2, 12);
INSERT INTO `role_permission` VALUES (1820351613395546127, 2, 15);
INSERT INTO `role_permission` VALUES (1820351613395546128, 2, 11);
INSERT INTO `role_permission` VALUES (1820351613395546129, 2, 8);
INSERT INTO `role_permission` VALUES (1820426692498337794, 1820352904444366850, 15);
INSERT INTO `role_permission` VALUES (1820426692498337795, 1820352904444366850, 16);
INSERT INTO `role_permission` VALUES (1820426692498337796, 1820352904444366850, 14);

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
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$8rSmx1t3VoitB2krA.2uuOUwuTn6wJqxYpZ0SchTCDo9Z7ri1zdmG', '/minio/app/0c43434ea4f5612a97db6c88d706f64a.gif', 1, '2024-07-30 18:32:36', '2024-08-02 10:13:56', NULL, 'admin', 'chq_109@sina.com');
INSERT INTO `user` VALUES (2, 'huawei', '$2a$10$kOCJgPOMNecWEPUi0l.gaeM6MVMMCfZFJs0Hngx5QuQBq1LwBhrAi', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, '2024-07-30 20:48:27', '2024-07-30 20:48:27', NULL, 'admin', 'hq@qq.com');
INSERT INTO `user` VALUES (1819626829397458946, '额请问请问', '$2a$10$OSBCH.Jrv/Uj9CcMPPhkJ.WZlSuRH.R/1aMZiKKBpyl67WpqtIExW', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, '2024-08-03 14:50:18', '2024-08-03 14:56:17', NULL, 'admin', NULL);
INSERT INTO `user` VALUES (1819631450358644737, '恶趣味王企鹅', '$2a$10$rD.ZDKcWRiz/6K9hEgBCFOxMdPdIUZXBKsGY/kUBlom/pW15uXTTK', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, '2024-08-03 15:08:40', '2024-08-03 15:08:40', NULL, 'admin', NULL);
INSERT INTO `user` VALUES (1819631612548186114, '卫栖梧而且', '$2a$10$WrruhVRpNz7md8tBBuQtWOtl8dW5u3tf6ip7ixQSXAROf2g1zHg6K', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, '2024-08-03 15:09:18', '2024-08-05 11:33:25', NULL, 'admin', '');

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
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 2, 3);
INSERT INTO `user_role` VALUES (4, 3, 3);
INSERT INTO `user_role` VALUES (1819628336226336770, 1819626829397458946, 2);
INSERT INTO `user_role` VALUES (1819631450358644738, 1819631450358644737, 3);
INSERT INTO `user_role` VALUES (1819631450358644739, 1819631450358644737, 2);
INSERT INTO `user_role` VALUES (1820302060386553858, 1819631612548186114, 3);
INSERT INTO `user_role` VALUES (1820302060386553859, 1819631612548186114, 2);

SET FOREIGN_KEY_CHECKS = 1;
