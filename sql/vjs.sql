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

 Date: 21/09/2024 10:00:44
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
  `job_type` tinyint NOT NULL COMMENT ' 工作方式 (1:fixed_rate, 2: cron)',
  `job_next_time` bigint NULL DEFAULT NULL COMMENT '下次执行时间',
  `job_rate` bigint NULL DEFAULT NULL COMMENT '周期单位s',
  `job_cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `trigger_status` tinyint NULL DEFAULT 0 COMMENT '触发状态 (1: 运行, 0: 停止)',
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
INSERT INTO `job_info` VALUES (6, 'print', '测试', 2, 1724316963486, NULL, '0 * * * * ?', 0, '2024-09-19 15:16:59', NULL, '2024-08-22 16:44:37', '2024-08-22 16:44:37', 'admin', 'admin', NULL);
INSERT INTO `job_info` VALUES (7, 'print2', '打印2', 1, 1724332558960, 5, NULL, 0, '2024-08-24 15:12:45', NULL, '2024-08-22 21:15:59', '2024-08-22 21:15:59', 'admin', 'admin', NULL);

-- ----------------------------
-- Table structure for job_log
-- ----------------------------
DROP TABLE IF EXISTS `job_log`;
CREATE TABLE `job_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `trigger_time` datetime NOT NULL COMMENT '触发时间',
  `handle_time` bigint NULL DEFAULT NULL COMMENT '处理时间 单位ms',
  `handle_status` tinyint NULL DEFAULT NULL COMMENT '处理状态  (1: 成功, 0: 失败)',
  `error_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '错误信息',
  `trigger_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '触发信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7738 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of job_log
-- ----------------------------

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
INSERT INTO `login_log` VALUES (1837309160555851777, '0:0:0:0:0:0:0:1', '内网', '2024-09-21 09:53:34', 'admin', '99702c83bce0ca3a6847f3a13f973e3d');

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
  `level` tinyint NULL DEFAULT 1 COMMENT '菜单层级',
  `type` tinyint NULL DEFAULT 0 COMMENT '菜单类型 (0: 目录, 1: 菜单, 2: 其他)',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 (1: 正常, 0: 禁用)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `redirect` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '重定向',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'admin' COMMENT '创建人',
  `link` tinyint NULL DEFAULT 0 COMMENT '是否外链 (0: 非外链, 1: 外链)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 'system', 0, 'layout/index', '/system', 1, '系统管理', 1, 0, 'Setting', 1, '2024-07-31 05:49:29', 'admin', '2024-07-31 05:49:29', '/system/statistics', 'admin', 0);
INSERT INTO `menu` VALUES (2, 'user', 1, '', '/system/user', 2, '用户管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', 'admin', '2024-09-18 18:30:48', '/system/user/index', 'admin', 0);
INSERT INTO `menu` VALUES (3, 'role', 1, 'system/role/index', '/system/role', 3, '角色管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (4, 'menu', 1, 'system/menu/index', '/system/menu', 4, '菜单管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (5, 'permission', 1, 'system/permission/index', '/system/permission', 5, '权限管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (6, 'user-list', 2, 'system/user/index', '/system/user/index', 1, '用户列表', 3, 2, 'AlarmClock', 1, '2024-09-18 18:31:52', 'admin', '2024-09-18 18:32:55', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (7, 'user-detail', 2, 'system/user/detail', '/system/user/detail/:userId', 2, '用户详细', 3, 2, 'User', 1, '2024-08-02 13:14:49', 'admin', '2024-09-18 18:27:26', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (8, 'user-add', 2, 'system/user/add', '/system/user/add', 3, '新增用户', 3, 2, 'User', 1, '2024-08-02 12:51:37', 'admin', '2024-09-18 18:28:56', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (9, 'user-edit', 2, 'system/user/edit', '/system/user/edit/:userId', 4, '编辑用户', 3, 2, 'User', 1, '2024-08-02 13:14:49', 'admin', '2024-09-18 18:27:41', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (10, 'operationLog', 1, 'system/operationLog/index', '/system/operationLog', 6, '日志管理', 2, 1, 'Calendar', 1, '2024-08-13 21:18:59', 'admin', '2024-08-13 21:18:59', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (11, 'apiDocument', 0, NULL, '/api/swagger-ui/index.html', 2, '接口文档', 1, 1, 'ChatLineSquare', 1, '2024-08-14 20:41:03', 'admin', '2024-08-14 20:41:03', NULL, 'admin', 1);
INSERT INTO `menu` VALUES (12, 'generator', 1, 'system/generator/index', '/system/generator', 8, '文档生成', 2, 1, 'Box', 1, '2024-08-17 18:25:42', 'admin', '2024-08-17 18:25:42', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (13, 'cache', 1, 'system/cache/index', '/system/cache', 7, '缓存管理', 2, 1, 'BellFilled', 1, '2024-08-19 17:59:30', 'admin', '2024-08-19 17:59:30', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (14, 'cacheInfo', 13, 'system/cache/info', '/system/cache/info/:key', 1, '缓存详细', 3, 2, 'User', 1, '2024-08-21 11:47:34', 'admin', '2024-08-21 11:47:34', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (15, 'schedule', 1, NULL, '/system/schedule', 10, '任务调度', 2, 0, 'Bicycle', 1, '2024-08-21 20:31:51', 'admin', '2024-08-21 20:31:51', '/system/schedule/job', 'admin', 0);
INSERT INTO `menu` VALUES (16, 'jobInfo', 15, 'system/schedule/job', '/system/schedule/job', 1, '任务管理', 3, 1, 'AlarmClock', 1, '2024-08-21 20:33:33', 'admin', '2024-08-21 20:33:33', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (17, 'scheduleLog', 15, 'system/schedule/log', '/system/schedule/log', 2, '调度日志', 3, 1, 'DocumentCopy', 1, '2024-08-21 20:35:35', 'admin', '2024-08-21 20:35:35', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (18, 'loginLog', 1, 'system/loginLog/index', '/system/loginLog', 9, '登录日志', 2, 1, 'ChatLineRound', 1, '2024-08-26 19:19:22', 'admin', '2024-08-26 19:19:22', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (19, 'statistics', 1, 'system/statistics/index', '/system/statistics', 1, '分类统计', 2, 1, 'Camera', 1, '2024-09-17 21:05:12', 'admin', '2024-09-17 21:17:18', NULL, 'admin', 0);

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint NOT NULL COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 1 COMMENT '业务类型 (1: 其它, 2: 新增, 3: 更改, 4: 删除, 5: 授权, 6: 导出, 7: 导入,8: 强退)',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 1 COMMENT '操作类别 (1: 后台用户, 2: 其他, 3: 手机端用户)',
  `operation_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `operation_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 1 COMMENT '操作状态 (1: 正常, 0: 异常)',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `operation_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间,单位ms',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_operation_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ct`(`operation_time` ASC) USING BTREE,
  INDEX `idx_sys_operation_log_s`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of operation_log
-- ----------------------------

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
INSERT INTO `permission` VALUES (1, 'system:cache:add', '缓存添加权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (2, 'system:cache:query', '缓存查询权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (3, 'system:cache:remove', '缓存删除权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (4, 'system:generator:query', '查询生成代码权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (5, 'system:generator:export', '导出生成代码权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (6, 'system:jobInfo:query', '查询任务权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (7, 'system:jobInfo:add', '添加任务权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (8, 'system:jobInfo:remove', '删除任务权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (9, 'system:jobInfo:edit', '编辑任务权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (10, 'system:jobLog:query', '查询任务日志权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (11, 'system:jobLog:remove', '删除任务日志权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (12, 'system:loginLog:query', '查询登录日志权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (13, 'system:loginLog:remove', '删除登录日志权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (14, 'system:menu:query', '查询菜单权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (15, 'system:menu:add', '新增菜单权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (16, 'system:menu:remove', '删除菜单权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (17, 'system:menu:edit', '编辑菜单权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (18, 'system:operationLog:query', '查询操作日志权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (19, 'system:operationLog:add', '新增操作日志权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (20, 'system:operationLog:remove', '删除操作日志权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (21, 'system:operationLog:edit', '编辑操作日志权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (22, 'system:permission:query', '查询权限权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (23, 'system:permission:add', '新增权限权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (24, 'system:permission:remove', '删除权限权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (25, 'system:permission:edit', '编辑权限权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (26, 'system:role:query', '查询角色权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (27, 'system:role:add', '新增角色权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (28, 'system:role:remove', '删除角色权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (29, 'system:role:assign', '分配角色权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (30, 'system:role:edit', '编辑角色权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (31, 'system:setting:query', '查询设置权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (32, 'system:setting:edit', '编辑用户模式', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (33, 'system:statistics:query', '查询统计权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (34, 'system:user:query', '查询用户权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (35, 'system:user:add', '新增用户权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (36, 'system:user:remove', '删除用户权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (37, 'system:user:export', '导出用户权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (38, 'system:user:import', '导入用户权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');
INSERT INTO `permission` VALUES (39, 'system:user:edit', '编辑用户权限', 'admin', '2024-09-19 18:07:16', 'admin', '2024-09-19 18:07:16');

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
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '系统管理员', 'admin', '2024-08-04 17:46:59', NULL, NULL);
INSERT INTO `role` VALUES (2, '普通员工', 'admin', '2024-08-04 17:46:59', 'admin', '2024-09-19 13:40:27');

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
INSERT INTO `role_menu` VALUES (1, 2, 1);
INSERT INTO `role_menu` VALUES (2, 2, 2);
INSERT INTO `role_menu` VALUES (3, 2, 3);
INSERT INTO `role_menu` VALUES (4, 2, 4);
INSERT INTO `role_menu` VALUES (5, 2, 5);
INSERT INTO `role_menu` VALUES (6, 2, 6);
INSERT INTO `role_menu` VALUES (7, 2, 7);
INSERT INTO `role_menu` VALUES (8, 2, 8);
INSERT INTO `role_menu` VALUES (9, 2, 9);
INSERT INTO `role_menu` VALUES (10, 2, 10);
INSERT INTO `role_menu` VALUES (11, 2, 11);
INSERT INTO `role_menu` VALUES (12, 2, 12);
INSERT INTO `role_menu` VALUES (13, 2, 13);
INSERT INTO `role_menu` VALUES (14, 2, 14);
INSERT INTO `role_menu` VALUES (15, 2, 15);
INSERT INTO `role_menu` VALUES (16, 2, 16);
INSERT INTO `role_menu` VALUES (17, 2, 17);
INSERT INTO `role_menu` VALUES (18, 2, 18);
INSERT INTO `role_menu` VALUES (19, 2, 19);

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
INSERT INTO `role_permission` VALUES (1, 2, 2);
INSERT INTO `role_permission` VALUES (2, 2, 4);
INSERT INTO `role_permission` VALUES (3, 2, 6);
INSERT INTO `role_permission` VALUES (4, 2, 10);
INSERT INTO `role_permission` VALUES (5, 2, 12);
INSERT INTO `role_permission` VALUES (6, 2, 14);
INSERT INTO `role_permission` VALUES (7, 2, 18);
INSERT INTO `role_permission` VALUES (8, 2, 22);
INSERT INTO `role_permission` VALUES (9, 2, 26);
INSERT INTO `role_permission` VALUES (10, 2, 31);
INSERT INTO `role_permission` VALUES (11, 2, 33);
INSERT INTO `role_permission` VALUES (12, 2, 34);

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
INSERT INTO `setting` VALUES (1, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '加密后的密码',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `gender` tinyint NULL DEFAULT NULL COMMENT '性别  (1: 男, 2: 女, 3: 其它)',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif' COMMENT '头像',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 (1: 正常, 0: 禁用)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$TIWVZl.wo9ZjaRAMgiN/FuOZZUsmGLZkxJ5F9syn0l47uFyTTPJaG', '13456789001', 1, 'chq_109@sina.com', '/minio/app/4823f861852d17ec03b15fa165416b36.avif', 1, '2024-07-30 18:32:36', '2024-09-19 15:08:17', 'admin', 'admin', '陈总');
INSERT INTO `user` VALUES (2, 'huawei', '$2a$10$WYFhttc9TUuADxN3TlA7xuLpcEDvZJSvStLjiLMZDkLi7SxF.ocDe', '13456789002', 2, 'hq@qq.com', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 1, '2024-07-30 20:48:27', '2024-08-15 14:01:24', 'admin', 'admin', '张飞');

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
INSERT INTO `user_role` VALUES (1826974920387665921, 1, 1);
INSERT INTO `user_role` VALUES (1836349151323897858, 2, 2);

SET FOREIGN_KEY_CHECKS = 1;
