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

 Date: 26/08/2024 18:20:55
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
INSERT INTO `job_info` VALUES (6, 'print', '测试', 2, 1724316963486, NULL, '0 * * * * ?', 0, '2024-08-26 17:13:26', NULL, '2024-08-22 16:44:37', '2024-08-22 16:44:37', 'admin', 'admin', NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 7700 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务日志表' ROW_FORMAT = Dynamic;

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
INSERT INTO `job_log` VALUES (7128, 6, '2024-08-25 13:54:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7129, 6, '2024-08-25 13:55:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7130, 6, '2024-08-25 13:56:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7131, 6, '2024-08-25 13:57:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7132, 6, '2024-08-25 13:58:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7133, 6, '2024-08-25 13:59:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7134, 6, '2024-08-25 14:00:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7135, 6, '2024-08-25 14:01:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7136, 6, '2024-08-25 14:02:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7137, 6, '2024-08-25 14:03:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7138, 6, '2024-08-25 14:04:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7139, 6, '2024-08-25 14:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7140, 6, '2024-08-25 14:06:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7141, 6, '2024-08-25 14:07:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7142, 6, '2024-08-25 14:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7143, 6, '2024-08-25 14:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7144, 6, '2024-08-25 14:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7145, 6, '2024-08-25 14:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7146, 6, '2024-08-25 14:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7147, 6, '2024-08-25 14:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7148, 6, '2024-08-25 14:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7149, 6, '2024-08-25 14:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7150, 6, '2024-08-25 14:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7151, 6, '2024-08-25 14:17:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7152, 6, '2024-08-25 14:18:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7153, 6, '2024-08-25 14:19:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7154, 6, '2024-08-25 14:20:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7155, 6, '2024-08-25 14:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7156, 6, '2024-08-25 14:22:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7157, 6, '2024-08-25 14:23:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7158, 6, '2024-08-25 14:24:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7159, 6, '2024-08-25 14:25:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7160, 6, '2024-08-25 14:26:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7161, 6, '2024-08-25 14:27:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7162, 6, '2024-08-25 14:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7163, 6, '2024-08-25 14:29:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7164, 6, '2024-08-25 14:30:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7165, 6, '2024-08-25 14:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7166, 6, '2024-08-25 14:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7167, 6, '2024-08-25 14:33:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7168, 6, '2024-08-25 14:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7169, 6, '2024-08-25 14:35:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7170, 6, '2024-08-25 14:36:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7171, 6, '2024-08-25 14:37:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7172, 6, '2024-08-25 14:38:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7173, 6, '2024-08-25 14:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7174, 6, '2024-08-25 14:40:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7175, 6, '2024-08-25 14:41:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7176, 6, '2024-08-25 14:42:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7177, 6, '2024-08-25 14:43:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7178, 6, '2024-08-25 14:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7179, 6, '2024-08-25 14:45:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7180, 6, '2024-08-25 14:46:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7181, 6, '2024-08-25 14:47:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7182, 6, '2024-08-25 14:48:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7183, 6, '2024-08-25 14:49:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7184, 6, '2024-08-25 14:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7185, 6, '2024-08-25 14:51:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7186, 6, '2024-08-25 14:52:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7187, 6, '2024-08-25 14:53:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7188, 6, '2024-08-25 14:54:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7189, 6, '2024-08-25 14:55:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7190, 6, '2024-08-25 14:56:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7191, 6, '2024-08-25 14:57:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7192, 6, '2024-08-25 14:58:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7193, 6, '2024-08-25 14:59:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7194, 6, '2024-08-25 15:00:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7195, 6, '2024-08-25 15:01:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7196, 6, '2024-08-25 15:02:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7197, 6, '2024-08-25 15:03:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7198, 6, '2024-08-25 15:04:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7199, 6, '2024-08-25 15:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7200, 6, '2024-08-25 15:06:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7201, 6, '2024-08-25 15:07:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7202, 6, '2024-08-25 15:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7203, 6, '2024-08-25 15:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7204, 6, '2024-08-25 15:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7205, 6, '2024-08-25 15:11:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7206, 6, '2024-08-25 15:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7207, 6, '2024-08-25 15:13:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7208, 6, '2024-08-25 15:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7209, 6, '2024-08-25 15:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7210, 6, '2024-08-25 15:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7211, 6, '2024-08-25 15:17:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7212, 6, '2024-08-25 15:18:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7213, 6, '2024-08-25 15:19:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7214, 6, '2024-08-25 15:20:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7215, 6, '2024-08-25 15:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7216, 6, '2024-08-25 15:22:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7217, 6, '2024-08-25 15:23:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7218, 6, '2024-08-25 15:24:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7219, 6, '2024-08-25 15:25:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7220, 6, '2024-08-25 15:26:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7221, 6, '2024-08-25 15:27:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7222, 6, '2024-08-25 15:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7223, 6, '2024-08-25 15:29:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7224, 6, '2024-08-25 15:30:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7225, 6, '2024-08-25 15:31:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7226, 6, '2024-08-25 15:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7227, 6, '2024-08-25 15:33:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7228, 6, '2024-08-25 15:34:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7229, 6, '2024-08-25 15:35:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7230, 6, '2024-08-25 15:36:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7231, 6, '2024-08-25 15:37:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7232, 6, '2024-08-25 15:38:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7233, 6, '2024-08-25 15:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7234, 6, '2024-08-25 15:40:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7235, 6, '2024-08-25 15:41:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7236, 6, '2024-08-25 15:42:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7237, 6, '2024-08-25 15:43:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7238, 6, '2024-08-25 15:44:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7239, 6, '2024-08-25 15:45:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7240, 6, '2024-08-25 15:46:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7241, 6, '2024-08-25 15:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7242, 6, '2024-08-25 15:48:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7243, 6, '2024-08-25 15:49:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7244, 6, '2024-08-25 15:50:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7245, 6, '2024-08-25 15:51:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7246, 6, '2024-08-25 15:52:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7247, 6, '2024-08-25 15:53:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7248, 6, '2024-08-25 15:54:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7249, 6, '2024-08-25 15:55:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7250, 6, '2024-08-25 15:56:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7251, 6, '2024-08-25 15:57:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7252, 6, '2024-08-25 15:58:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7253, 6, '2024-08-25 15:59:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7254, 6, '2024-08-25 16:00:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7255, 6, '2024-08-25 16:01:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7256, 6, '2024-08-25 16:02:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7257, 6, '2024-08-25 16:03:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7258, 6, '2024-08-25 16:04:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7259, 6, '2024-08-25 16:05:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7260, 6, '2024-08-25 16:06:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7261, 6, '2024-08-25 16:07:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7262, 6, '2024-08-25 16:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7263, 6, '2024-08-25 16:09:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7264, 6, '2024-08-25 16:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7265, 6, '2024-08-25 16:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7266, 6, '2024-08-25 16:12:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7267, 6, '2024-08-25 16:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7268, 6, '2024-08-25 16:14:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7269, 6, '2024-08-25 16:15:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7270, 6, '2024-08-25 16:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7271, 6, '2024-08-25 16:17:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7272, 6, '2024-08-25 16:18:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7273, 6, '2024-08-25 17:41:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7274, 6, '2024-08-25 17:42:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7275, 6, '2024-08-25 17:43:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7276, 6, '2024-08-25 17:44:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7277, 6, '2024-08-25 17:45:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7278, 6, '2024-08-25 17:46:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7279, 6, '2024-08-25 17:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7280, 6, '2024-08-25 17:48:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7281, 6, '2024-08-25 17:49:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7282, 6, '2024-08-25 17:50:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7283, 6, '2024-08-25 17:51:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7284, 6, '2024-08-25 17:52:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7285, 6, '2024-08-25 17:53:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7286, 6, '2024-08-25 17:54:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7287, 6, '2024-08-25 17:55:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7288, 6, '2024-08-25 17:56:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7289, 6, '2024-08-25 17:57:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7290, 6, '2024-08-25 17:58:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7291, 6, '2024-08-25 17:59:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7292, 6, '2024-08-25 18:00:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7293, 6, '2024-08-25 18:01:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7294, 6, '2024-08-25 18:02:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7295, 6, '2024-08-25 18:03:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7296, 6, '2024-08-25 18:04:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7297, 6, '2024-08-25 18:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7298, 6, '2024-08-25 18:06:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7299, 6, '2024-08-25 18:07:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7300, 6, '2024-08-25 18:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7301, 6, '2024-08-25 18:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7302, 6, '2024-08-25 18:10:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7303, 6, '2024-08-25 18:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7304, 6, '2024-08-25 18:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7305, 6, '2024-08-25 18:13:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7306, 6, '2024-08-25 18:14:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7307, 6, '2024-08-25 18:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7308, 6, '2024-08-25 18:16:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7309, 6, '2024-08-25 18:17:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7310, 6, '2024-08-25 18:18:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7311, 6, '2024-08-25 18:19:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7312, 6, '2024-08-25 18:20:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7313, 6, '2024-08-25 18:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7314, 6, '2024-08-25 18:22:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7315, 6, '2024-08-25 18:23:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7316, 6, '2024-08-25 18:24:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7317, 6, '2024-08-25 18:25:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7318, 6, '2024-08-25 18:26:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7319, 6, '2024-08-25 18:27:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7320, 6, '2024-08-25 18:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7321, 6, '2024-08-25 18:29:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7322, 6, '2024-08-25 18:30:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7323, 6, '2024-08-25 18:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7324, 6, '2024-08-25 18:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7325, 6, '2024-08-25 18:33:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7326, 6, '2024-08-25 18:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7327, 6, '2024-08-25 18:35:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7328, 6, '2024-08-25 18:36:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7329, 6, '2024-08-25 18:37:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7330, 6, '2024-08-25 18:38:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7331, 6, '2024-08-25 18:39:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7332, 6, '2024-08-25 18:40:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7333, 6, '2024-08-25 18:41:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7334, 6, '2024-08-25 18:42:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7335, 6, '2024-08-25 18:43:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7336, 6, '2024-08-25 18:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7337, 6, '2024-08-25 18:45:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7338, 6, '2024-08-25 18:46:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7339, 6, '2024-08-25 18:47:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7340, 6, '2024-08-25 18:48:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7341, 6, '2024-08-25 18:49:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7342, 6, '2024-08-25 18:50:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7343, 6, '2024-08-25 18:51:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7344, 6, '2024-08-25 18:52:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7345, 6, '2024-08-25 18:53:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7346, 6, '2024-08-25 18:54:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7347, 6, '2024-08-25 18:55:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7348, 6, '2024-08-25 18:56:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7349, 6, '2024-08-25 18:57:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7350, 6, '2024-08-25 18:58:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7351, 6, '2024-08-25 18:59:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7352, 6, '2024-08-25 19:00:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7353, 6, '2024-08-25 19:01:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7354, 6, '2024-08-25 19:02:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7355, 6, '2024-08-25 19:03:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7356, 6, '2024-08-25 19:04:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7357, 6, '2024-08-25 19:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7358, 6, '2024-08-25 19:06:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7359, 6, '2024-08-25 19:07:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7360, 6, '2024-08-25 19:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7361, 6, '2024-08-25 19:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7362, 6, '2024-08-25 19:10:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7363, 6, '2024-08-25 19:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7364, 6, '2024-08-25 19:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7365, 6, '2024-08-25 19:13:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7366, 6, '2024-08-25 19:14:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7367, 6, '2024-08-25 19:15:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7368, 6, '2024-08-25 19:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7369, 6, '2024-08-25 19:17:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7370, 6, '2024-08-25 19:18:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7371, 6, '2024-08-25 19:19:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7372, 6, '2024-08-25 19:20:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7373, 6, '2024-08-25 19:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7374, 6, '2024-08-25 19:22:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7375, 6, '2024-08-25 19:23:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7376, 6, '2024-08-25 19:24:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7377, 6, '2024-08-25 19:25:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7378, 6, '2024-08-25 19:26:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7379, 6, '2024-08-25 19:27:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7380, 6, '2024-08-25 19:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7381, 6, '2024-08-25 19:29:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7382, 6, '2024-08-25 19:30:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7383, 6, '2024-08-25 19:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7384, 6, '2024-08-25 19:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7385, 6, '2024-08-25 19:33:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7386, 6, '2024-08-25 19:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7387, 6, '2024-08-25 19:35:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7388, 6, '2024-08-25 19:36:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7389, 6, '2024-08-25 19:37:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7390, 6, '2024-08-25 19:38:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7391, 6, '2024-08-25 19:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7392, 6, '2024-08-25 19:40:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7393, 6, '2024-08-25 19:41:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7394, 6, '2024-08-25 19:42:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7395, 6, '2024-08-25 19:43:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7396, 6, '2024-08-25 19:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7397, 6, '2024-08-25 19:45:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7398, 6, '2024-08-25 19:46:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7399, 6, '2024-08-25 19:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7400, 6, '2024-08-25 19:48:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7401, 6, '2024-08-25 19:49:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7402, 6, '2024-08-25 19:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7403, 6, '2024-08-25 19:51:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7404, 6, '2024-08-25 19:52:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7405, 6, '2024-08-25 19:53:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7406, 6, '2024-08-25 19:54:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7407, 6, '2024-08-25 19:55:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7408, 6, '2024-08-25 19:56:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7409, 6, '2024-08-25 19:57:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7410, 6, '2024-08-25 19:58:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7411, 6, '2024-08-25 19:59:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7412, 6, '2024-08-25 20:00:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7413, 6, '2024-08-25 20:01:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7414, 6, '2024-08-25 20:02:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7415, 6, '2024-08-25 20:03:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7416, 6, '2024-08-25 20:04:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7417, 6, '2024-08-25 20:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7418, 6, '2024-08-25 20:06:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7419, 6, '2024-08-25 20:07:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7420, 6, '2024-08-25 20:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7421, 6, '2024-08-25 20:09:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7422, 6, '2024-08-25 20:10:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7423, 6, '2024-08-25 20:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7424, 6, '2024-08-25 20:12:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7425, 6, '2024-08-25 20:13:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7426, 6, '2024-08-25 20:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7427, 6, '2024-08-25 20:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7428, 6, '2024-08-25 20:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7429, 6, '2024-08-25 20:17:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7430, 6, '2024-08-25 20:18:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7431, 6, '2024-08-25 20:19:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7432, 6, '2024-08-25 20:20:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7433, 6, '2024-08-25 20:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7434, 6, '2024-08-25 20:22:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7435, 6, '2024-08-25 20:23:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7436, 6, '2024-08-25 20:24:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7437, 6, '2024-08-25 20:25:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7438, 6, '2024-08-25 20:26:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7439, 6, '2024-08-25 20:27:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7440, 6, '2024-08-25 20:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7441, 6, '2024-08-25 20:29:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7442, 6, '2024-08-25 20:30:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7443, 6, '2024-08-25 20:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7444, 6, '2024-08-25 20:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7445, 6, '2024-08-25 20:33:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7446, 6, '2024-08-25 20:34:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7447, 6, '2024-08-25 20:35:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7448, 6, '2024-08-25 20:36:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7449, 6, '2024-08-25 20:37:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7450, 6, '2024-08-25 20:38:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7451, 6, '2024-08-25 20:39:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7452, 6, '2024-08-25 20:40:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7453, 6, '2024-08-25 20:41:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7454, 6, '2024-08-25 20:42:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7455, 6, '2024-08-25 20:43:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7456, 6, '2024-08-25 20:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7457, 6, '2024-08-25 20:45:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7458, 6, '2024-08-25 20:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7459, 6, '2024-08-25 20:48:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7460, 6, '2024-08-25 20:49:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7461, 6, '2024-08-25 20:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7462, 6, '2024-08-25 20:51:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7463, 6, '2024-08-25 20:52:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7464, 6, '2024-08-25 20:53:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7465, 6, '2024-08-25 21:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7466, 6, '2024-08-25 21:51:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7467, 6, '2024-08-25 21:52:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7468, 6, '2024-08-25 21:53:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7469, 6, '2024-08-25 21:54:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7470, 6, '2024-08-25 21:55:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7471, 6, '2024-08-25 21:56:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7472, 6, '2024-08-25 21:57:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7473, 6, '2024-08-25 21:58:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7474, 6, '2024-08-25 21:59:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7475, 6, '2024-08-25 22:00:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7476, 6, '2024-08-25 22:09:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7477, 6, '2024-08-25 22:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7478, 6, '2024-08-25 22:11:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7479, 6, '2024-08-25 22:12:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7480, 6, '2024-08-25 22:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7481, 6, '2024-08-25 22:14:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7482, 6, '2024-08-25 22:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7483, 6, '2024-08-25 22:16:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7484, 6, '2024-08-26 00:08:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7485, 6, '2024-08-26 00:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7486, 6, '2024-08-26 00:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7487, 6, '2024-08-26 00:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7488, 6, '2024-08-26 00:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7489, 6, '2024-08-26 00:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7490, 6, '2024-08-26 00:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7491, 6, '2024-08-26 00:15:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7492, 6, '2024-08-26 00:16:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7493, 6, '2024-08-26 00:17:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7494, 6, '2024-08-26 00:18:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7495, 6, '2024-08-26 00:19:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7496, 6, '2024-08-26 13:31:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7497, 6, '2024-08-26 13:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7498, 6, '2024-08-26 13:33:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7499, 6, '2024-08-26 13:34:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7500, 6, '2024-08-26 13:35:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7501, 6, '2024-08-26 13:36:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7502, 6, '2024-08-26 13:37:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7503, 6, '2024-08-26 13:38:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7504, 6, '2024-08-26 13:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7505, 6, '2024-08-26 13:40:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7506, 6, '2024-08-26 13:41:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7507, 6, '2024-08-26 13:42:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7508, 6, '2024-08-26 13:43:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7509, 6, '2024-08-26 13:44:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7510, 6, '2024-08-26 13:45:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7511, 6, '2024-08-26 13:46:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7512, 6, '2024-08-26 13:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7513, 6, '2024-08-26 13:48:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7514, 6, '2024-08-26 13:49:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7515, 6, '2024-08-26 13:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7516, 6, '2024-08-26 13:51:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7517, 6, '2024-08-26 13:52:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7518, 6, '2024-08-26 13:53:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7519, 6, '2024-08-26 13:54:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7520, 6, '2024-08-26 13:55:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7521, 6, '2024-08-26 13:56:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7522, 6, '2024-08-26 13:57:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7523, 6, '2024-08-26 13:58:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7524, 6, '2024-08-26 13:59:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7525, 6, '2024-08-26 14:00:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7526, 6, '2024-08-26 14:02:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7527, 6, '2024-08-26 14:03:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7528, 6, '2024-08-26 14:04:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7529, 6, '2024-08-26 14:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7530, 6, '2024-08-26 14:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7531, 6, '2024-08-26 14:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7532, 6, '2024-08-26 14:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7533, 6, '2024-08-26 14:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7534, 6, '2024-08-26 14:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7535, 6, '2024-08-26 14:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7536, 6, '2024-08-26 14:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7537, 6, '2024-08-26 14:17:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7538, 6, '2024-08-26 14:19:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7539, 6, '2024-08-26 14:20:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7540, 6, '2024-08-26 14:21:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7541, 6, '2024-08-26 14:22:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7542, 6, '2024-08-26 14:24:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7543, 6, '2024-08-26 14:25:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7544, 6, '2024-08-26 14:26:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7545, 6, '2024-08-26 14:27:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7546, 6, '2024-08-26 14:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7547, 6, '2024-08-26 14:29:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7548, 6, '2024-08-26 14:30:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7549, 6, '2024-08-26 14:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7550, 6, '2024-08-26 14:32:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7551, 6, '2024-08-26 14:33:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7552, 6, '2024-08-26 14:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7553, 6, '2024-08-26 14:35:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7554, 6, '2024-08-26 14:36:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7555, 6, '2024-08-26 14:37:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7556, 6, '2024-08-26 14:39:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7557, 6, '2024-08-26 14:40:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7558, 6, '2024-08-26 14:41:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7559, 6, '2024-08-26 14:42:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7560, 6, '2024-08-26 14:43:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7561, 6, '2024-08-26 14:44:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7562, 6, '2024-08-26 14:46:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7563, 6, '2024-08-26 14:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7564, 6, '2024-08-26 14:48:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7565, 6, '2024-08-26 14:49:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7566, 6, '2024-08-26 14:50:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7567, 6, '2024-08-26 14:51:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7568, 6, '2024-08-26 14:52:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7569, 6, '2024-08-26 14:53:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7570, 6, '2024-08-26 14:54:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7571, 6, '2024-08-26 14:55:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7572, 6, '2024-08-26 14:56:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7573, 6, '2024-08-26 14:57:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7574, 6, '2024-08-26 14:58:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7575, 6, '2024-08-26 14:59:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7576, 6, '2024-08-26 15:00:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7577, 6, '2024-08-26 15:01:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7578, 6, '2024-08-26 15:02:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7579, 6, '2024-08-26 15:03:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7580, 6, '2024-08-26 15:04:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7581, 6, '2024-08-26 15:05:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7582, 6, '2024-08-26 15:06:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7583, 6, '2024-08-26 15:07:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7584, 6, '2024-08-26 15:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7585, 6, '2024-08-26 15:09:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7586, 6, '2024-08-26 15:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7587, 6, '2024-08-26 15:11:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7588, 6, '2024-08-26 15:12:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7589, 6, '2024-08-26 15:13:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7590, 6, '2024-08-26 15:14:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7591, 6, '2024-08-26 15:15:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7592, 6, '2024-08-26 15:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7593, 6, '2024-08-26 15:17:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7594, 6, '2024-08-26 15:18:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7595, 6, '2024-08-26 15:19:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7596, 6, '2024-08-26 15:20:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7597, 6, '2024-08-26 15:21:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7598, 6, '2024-08-26 15:22:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7599, 6, '2024-08-26 15:23:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7600, 6, '2024-08-26 15:24:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7601, 6, '2024-08-26 15:25:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7602, 6, '2024-08-26 15:26:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7603, 6, '2024-08-26 15:27:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7604, 6, '2024-08-26 15:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7605, 6, '2024-08-26 15:29:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7606, 6, '2024-08-26 15:30:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7607, 6, '2024-08-26 15:31:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7608, 6, '2024-08-26 15:32:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7609, 6, '2024-08-26 15:33:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7610, 6, '2024-08-26 15:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7611, 6, '2024-08-26 15:35:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7612, 6, '2024-08-26 15:36:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7613, 6, '2024-08-26 15:37:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7614, 6, '2024-08-26 15:38:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7615, 6, '2024-08-26 15:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7616, 6, '2024-08-26 15:40:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7617, 6, '2024-08-26 15:41:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7618, 6, '2024-08-26 15:42:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7619, 6, '2024-08-26 15:43:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7620, 6, '2024-08-26 15:44:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7621, 6, '2024-08-26 15:45:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7622, 6, '2024-08-26 15:46:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7623, 6, '2024-08-26 15:47:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7624, 6, '2024-08-26 15:48:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7625, 6, '2024-08-26 15:49:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7626, 6, '2024-08-26 15:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7627, 6, '2024-08-26 15:51:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7628, 6, '2024-08-26 15:52:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7629, 6, '2024-08-26 15:53:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7630, 6, '2024-08-26 15:54:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7631, 6, '2024-08-26 15:55:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7632, 6, '2024-08-26 15:56:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7633, 6, '2024-08-26 15:57:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7634, 6, '2024-08-26 15:58:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7635, 6, '2024-08-26 15:59:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7636, 6, '2024-08-26 16:00:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7637, 6, '2024-08-26 16:01:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7638, 6, '2024-08-26 16:02:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7639, 6, '2024-08-26 16:03:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7640, 6, '2024-08-26 16:04:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7641, 6, '2024-08-26 16:05:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7642, 6, '2024-08-26 16:06:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7643, 6, '2024-08-26 16:07:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7644, 6, '2024-08-26 16:08:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7645, 6, '2024-08-26 16:09:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7646, 6, '2024-08-26 16:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7647, 6, '2024-08-26 16:11:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7648, 6, '2024-08-26 16:12:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7649, 6, '2024-08-26 16:13:00', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7650, 6, '2024-08-26 16:14:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7651, 6, '2024-08-26 16:15:01', 1, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7652, 6, '2024-08-26 16:16:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7653, 6, '2024-08-26 16:17:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7654, 6, '2024-08-26 16:18:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7655, 6, '2024-08-26 16:19:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7656, 6, '2024-08-26 16:20:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7657, 6, '2024-08-26 16:21:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7658, 6, '2024-08-26 16:22:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7659, 6, '2024-08-26 16:23:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7660, 6, '2024-08-26 16:24:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7661, 6, '2024-08-26 16:25:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7662, 6, '2024-08-26 16:26:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7663, 6, '2024-08-26 16:27:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7664, 6, '2024-08-26 16:28:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7665, 6, '2024-08-26 16:29:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7666, 6, '2024-08-26 16:30:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7667, 6, '2024-08-26 16:31:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7668, 6, '2024-08-26 16:32:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7669, 6, '2024-08-26 16:33:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7670, 6, '2024-08-26 16:34:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7671, 6, '2024-08-26 16:35:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7672, 6, '2024-08-26 16:36:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7673, 6, '2024-08-26 16:37:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7674, 6, '2024-08-26 16:38:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7675, 6, '2024-08-26 16:39:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7676, 6, '2024-08-26 16:40:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7677, 6, '2024-08-26 16:41:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7678, 6, '2024-08-26 16:42:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7679, 6, '2024-08-26 16:43:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7680, 6, '2024-08-26 16:44:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7681, 6, '2024-08-26 16:45:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7682, 6, '2024-08-26 16:46:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7683, 6, '2024-08-26 16:47:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7684, 6, '2024-08-26 16:48:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7685, 6, '2024-08-26 16:49:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7686, 6, '2024-08-26 16:50:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7687, 6, '2024-08-26 16:51:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7688, 6, '2024-08-26 16:52:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7689, 6, '2024-08-26 16:53:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7690, 6, '2024-08-26 16:54:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7691, 6, '2024-08-26 16:55:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7692, 6, '2024-08-26 16:56:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7693, 6, '2024-08-26 16:57:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7694, 6, '2024-08-26 17:08:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7695, 6, '2024-08-26 17:09:01', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7696, 6, '2024-08-26 17:10:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7697, 6, '2024-08-26 17:11:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7698, 6, '2024-08-26 17:12:00', 0, 1, NULL, 'success');
INSERT INTO `job_log` VALUES (7699, 6, '2024-08-26 17:13:00', 0, 1, NULL, 'success');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES (1828010106730586114, '127.0.0.1', '内网', '2024-08-26 18:02:27', 'admin', 'ba220f73ca494aef95c6acbbde1eb9fc');

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
