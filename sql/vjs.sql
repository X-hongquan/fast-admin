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

 Date: 22/08/2024 21:41:38
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
INSERT INTO `job_info` VALUES (6, 'print', '测试', 2, 1724316963486, 2000, '0 * * * * ?', 0, '2024-08-22 21:30:15', NULL, '2024-08-22 16:44:37', '2024-08-22 16:44:37', 'admin', 'admin', NULL);
INSERT INTO `job_info` VALUES (7, 'print2', '打印2', 1, 1724332558960, 5, NULL, 0, '2024-08-22 21:30:15', NULL, '2024-08-22 21:15:59', '2024-08-22 21:15:59', 'admin', 'admin', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 221 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_log
-- ----------------------------
INSERT INTO `job_log` VALUES (29, 6, '2024-08-22 17:50:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (30, 6, '2024-08-22 17:51:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (31, 6, '2024-08-22 17:52:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (32, 6, '2024-08-22 17:53:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (33, 6, '2024-08-22 17:54:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (34, 6, '2024-08-22 17:55:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (35, 6, '2024-08-22 17:56:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (36, 6, '2024-08-22 17:57:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (37, 6, '2024-08-22 17:58:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (38, 6, '2024-08-22 18:00:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (39, 6, '2024-08-22 18:01:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (40, 6, '2024-08-22 18:02:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (41, 6, '2024-08-22 18:03:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (42, 6, '2024-08-22 18:04:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (43, 6, '2024-08-22 18:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (44, 6, '2024-08-22 18:06:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (45, 6, '2024-08-22 18:07:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (46, 6, '2024-08-22 18:08:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (47, 6, '2024-08-22 18:09:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (48, 6, '2024-08-22 18:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (49, 6, '2024-08-22 18:11:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (50, 6, '2024-08-22 18:12:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (51, 6, '2024-08-22 18:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (52, 6, '2024-08-22 18:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (53, 6, '2024-08-22 18:15:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (54, 6, '2024-08-22 18:16:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (55, 6, '2024-08-22 18:17:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (56, 6, '2024-08-22 18:18:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (57, 6, '2024-08-22 18:19:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (58, 6, '2024-08-22 18:20:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (59, 6, '2024-08-22 18:21:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (60, 6, '2024-08-22 18:22:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (61, 6, '2024-08-22 18:23:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (62, 6, '2024-08-22 18:24:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (63, 6, '2024-08-22 18:25:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (64, 6, '2024-08-22 18:26:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (65, 6, '2024-08-22 18:27:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (66, 6, '2024-08-22 18:28:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (67, 6, '2024-08-22 18:29:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (68, 6, '2024-08-22 18:30:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (69, 6, '2024-08-22 18:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (70, 6, '2024-08-22 18:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (71, 6, '2024-08-22 18:33:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (72, 6, '2024-08-22 18:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (73, 6, '2024-08-22 18:35:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (74, 6, '2024-08-22 18:36:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (75, 6, '2024-08-22 18:37:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (76, 6, '2024-08-22 18:38:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (77, 6, '2024-08-22 18:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (78, 6, '2024-08-22 18:40:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (79, 6, '2024-08-22 18:41:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (80, 6, '2024-08-22 18:42:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (81, 6, '2024-08-22 18:43:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (82, 6, '2024-08-22 18:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (83, 6, '2024-08-22 18:45:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (84, 6, '2024-08-22 18:46:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (85, 6, '2024-08-22 18:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (86, 6, '2024-08-22 18:48:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (87, 6, '2024-08-22 18:49:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (88, 6, '2024-08-22 18:50:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (89, 6, '2024-08-22 18:51:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (90, 6, '2024-08-22 18:52:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (91, 6, '2024-08-22 18:53:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (92, 6, '2024-08-22 18:54:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (93, 6, '2024-08-22 18:55:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (94, 6, '2024-08-22 18:56:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (95, 6, '2024-08-22 18:57:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (96, 6, '2024-08-22 18:58:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (97, 6, '2024-08-22 19:00:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (98, 6, '2024-08-22 19:01:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (99, 6, '2024-08-22 19:02:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (100, 6, '2024-08-22 19:03:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (101, 6, '2024-08-22 19:04:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (102, 6, '2024-08-22 19:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (103, 6, '2024-08-22 19:06:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (104, 6, '2024-08-22 19:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (105, 6, '2024-08-22 19:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (106, 6, '2024-08-22 19:10:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (107, 6, '2024-08-22 19:11:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (108, 6, '2024-08-22 19:12:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (109, 6, '2024-08-22 19:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (110, 6, '2024-08-22 19:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (111, 6, '2024-08-22 19:15:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (112, 6, '2024-08-22 19:16:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (113, 6, '2024-08-22 19:17:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (114, 6, '2024-08-22 19:18:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (115, 6, '2024-08-22 19:19:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (116, 6, '2024-08-22 19:20:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (117, 6, '2024-08-22 19:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (118, 6, '2024-08-22 19:22:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (119, 6, '2024-08-22 19:23:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (120, 6, '2024-08-22 19:24:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (121, 6, '2024-08-22 19:25:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (122, 6, '2024-08-22 19:26:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (123, 6, '2024-08-22 19:27:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (124, 6, '2024-08-22 19:28:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (125, 6, '2024-08-22 19:29:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (126, 6, '2024-08-22 19:30:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (127, 6, '2024-08-22 19:31:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (128, 6, '2024-08-22 19:32:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (129, 6, '2024-08-22 19:33:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (130, 6, '2024-08-22 19:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (131, 6, '2024-08-22 19:35:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (132, 6, '2024-08-22 19:36:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (133, 6, '2024-08-22 19:37:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (134, 6, '2024-08-22 19:38:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (135, 6, '2024-08-22 19:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (136, 6, '2024-08-22 20:07:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (137, 6, '2024-08-22 20:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (138, 6, '2024-08-22 20:09:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (139, 6, '2024-08-22 20:10:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (140, 6, '2024-08-22 20:11:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (141, 6, '2024-08-22 20:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (142, 6, '2024-08-22 20:13:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (143, 6, '2024-08-22 20:14:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (144, 6, '2024-08-22 20:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (145, 6, '2024-08-22 20:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (146, 6, '2024-08-22 20:17:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (147, 6, '2024-08-22 20:18:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (148, 6, '2024-08-22 20:19:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (149, 6, '2024-08-22 20:20:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (150, 6, '2024-08-22 20:21:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (151, 6, '2024-08-22 20:22:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (152, 6, '2024-08-22 20:23:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (153, 6, '2024-08-22 20:24:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (154, 6, '2024-08-22 20:25:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (155, 6, '2024-08-22 20:26:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (156, 6, '2024-08-22 20:27:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (157, 6, '2024-08-22 20:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (158, 6, '2024-08-22 20:30:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (159, 6, '2024-08-22 20:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (160, 6, '2024-08-22 20:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (161, 6, '2024-08-22 20:33:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (162, 6, '2024-08-22 20:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (163, 6, '2024-08-22 20:35:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (164, 6, '2024-08-22 20:36:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (165, 6, '2024-08-22 20:37:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (166, 6, '2024-08-22 20:38:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (167, 6, '2024-08-22 20:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (168, 6, '2024-08-22 20:40:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (169, 6, '2024-08-22 20:41:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (170, 6, '2024-08-22 20:42:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (171, 6, '2024-08-22 20:43:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (172, 6, '2024-08-22 20:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (173, 6, '2024-08-22 20:45:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (174, 6, '2024-08-22 20:46:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (175, 6, '2024-08-22 20:47:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (176, 6, '2024-08-22 20:48:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (177, 6, '2024-08-22 20:49:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (178, 6, '2024-08-22 20:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (179, 6, '2024-08-22 20:51:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (180, 6, '2024-08-22 20:52:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (181, 6, '2024-08-22 20:53:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (182, 6, '2024-08-22 20:54:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (183, 6, '2024-08-22 20:55:01', 11, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (184, 6, '2024-08-22 20:56:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (185, 6, '2024-08-22 20:57:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (186, 6, '2024-08-22 20:58:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (187, 6, '2024-08-22 21:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (188, 6, '2024-08-22 21:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (189, 6, '2024-08-22 21:17:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (190, 6, '2024-08-22 21:18:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (191, 6, '2024-08-22 21:19:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (192, 6, '2024-08-22 21:20:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (193, 6, '2024-08-22 21:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (194, 7, '2024-08-22 21:27:45', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (195, 7, '2024-08-22 21:27:50', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (196, 7, '2024-08-22 21:27:55', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (197, 7, '2024-08-22 21:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (198, 7, '2024-08-22 21:28:05', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (199, 7, '2024-08-22 21:28:10', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (200, 7, '2024-08-22 21:28:20', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (201, 7, '2024-08-22 21:28:25', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (202, 7, '2024-08-22 21:28:45', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (203, 7, '2024-08-22 21:28:50', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (204, 7, '2024-08-22 21:28:54', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (205, 7, '2024-08-22 21:28:59', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (206, 7, '2024-08-22 21:29:04', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (207, 7, '2024-08-22 21:29:09', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (208, 7, '2024-08-22 21:29:14', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (209, 7, '2024-08-22 21:29:19', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (210, 7, '2024-08-22 21:29:24', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (211, 7, '2024-08-22 21:29:29', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (212, 7, '2024-08-22 21:29:34', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (213, 7, '2024-08-22 21:29:40', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (214, 7, '2024-08-22 21:29:45', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (215, 7, '2024-08-22 21:29:50', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (216, 7, '2024-08-22 21:29:55', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (217, 7, '2024-08-22 21:30:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (218, 6, '2024-08-22 21:30:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (219, 7, '2024-08-22 21:30:05', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (220, 7, '2024-08-22 21:30:10', 0, 1, NULL, 'success');

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
INSERT INTO `menu` VALUES (2, 'user', 1, 'system/user/index', '/system/user', 2, '用户管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (3, 'role', 1, 'system/role/index', '/system/role', 6, '角色管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (4, 'menu', 1, 'system/menu/index', '/system/menu', 7, '菜单管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (5, 'permission', 1, 'system/permission/index', '/system/permission', 8, '权限管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (6, 'user-add', 1, 'system/user/detail/index', '/system/user/add', 3, '新增用户', 2, 2, 'User', 1, '2024-08-02 12:51:37', NULL, '2024-08-02 12:51:37', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (7, 'user-edit', 1, 'system/user/detail/index', '/system/user/edit/:userId', 4, '编辑用户', 2, 2, 'User', 1, '2024-08-02 13:14:49', NULL, '2024-08-02 13:14:49', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (8, 'user-detail', 1, 'system/user/detail/index', '/system/user/detail/:userId', 1, '用户详细', 2, 2, 'User', 1, '2024-08-02 13:14:49', 'admin', '2024-08-02 13:14:49', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1823348525811974145, 'log', 1, 'system/log/index', '/system/log', 6, '日志管理', 2, 1, 'Calendar', 1, '2024-08-13 21:18:59', NULL, '2024-08-13 21:18:59', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1823701366858686465, 'apiDocument', 0, NULL, 'http://localhost:8080/api/swagger-ui/index.html', 2, '接口文档', 1, 1, 'ChatLineSquare', 1, '2024-08-14 20:41:03', NULL, '2024-08-14 20:41:03', NULL, 'admin', 1);
INSERT INTO `menu` VALUES (1824754469368238082, 'generator', 1, 'system/generator/index', '/system/generator', 7, '文档生成', 2, 1, 'Box', 1, '2024-08-17 18:25:42', 'admin', '2024-08-17 18:25:42', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1825472650722430977, 'cache', 1, 'system/cache/index', '/system/cache', 9, '缓存管理', 2, 1, 'BellFilled', 1, '2024-08-19 17:59:30', 'admin', '2024-08-19 17:59:30', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1826103825019232257, 'cacheInfo', 1825472650722430977, 'system/cache/info', '/system/cache/info/:key', 1, '缓存详细', 3, 2, 'User', 1, '2024-08-21 11:47:34', 'admin', '2024-08-21 11:47:34', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1826235764657106945, 'schedule', 1, NULL, '/system/schedule', 10, '任务调度', 2, 0, 'Bicycle', 1, '2024-08-21 20:31:51', 'admin', '2024-08-21 20:31:51', '/system/schedule/job', 'admin', 0);
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
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$8rSmx1t3VoitB2krA.2uuOUwuTn6wJqxYpZ0SchTCDo9Z7ri1zdmG', '/minio/app/4823f861852d17ec03b15fa165416b36.avif', 1, '2024-07-30 18:32:36', '2024-08-02 10:13:56', NULL, 'admin', 'chq_109@sina.com');
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
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 3, 3);

SET FOREIGN_KEY_CHECKS = 1;
