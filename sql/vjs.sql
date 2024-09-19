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

 Date: 19/09/2024 18:13:37
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
  `job_type` tinyint NOT NULL COMMENT ' 工作方式 (1fixed_rate 2cron)',
  `job_next_time` bigint NULL DEFAULT NULL COMMENT '下次执行时间',
  `job_rate` bigint NULL DEFAULT NULL COMMENT '周期单位s',
  `job_cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `trigger_status` tinyint NULL DEFAULT 0 COMMENT '触发状态 (1运行 0停止)',
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
  `handle_status` tinyint NULL DEFAULT NULL COMMENT '处理状态  (1成功 0失败)',
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
INSERT INTO `login_log` VALUES (1835974735452819458, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 17:31:02', 'admin', '35051eb9e08edae0d3b10789872f31e1');
INSERT INTO `login_log` VALUES (1835980946080301057, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 17:55:43', 'admin', '8b2495a89c9d63e85520292f94b4b80b');
INSERT INTO `login_log` VALUES (1835986195050438657, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 18:16:35', 'admin', '150ffa19b8146eed8841cfa8dd462901');
INSERT INTO `login_log` VALUES (1835986984397512705, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 18:19:43', 'admin', '424f1c2788fd9c3a88dd3aa6c17e129d');
INSERT INTO `login_log` VALUES (1835991501113466882, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 18:37:40', 'admin', '646f4c31672b9373a84ec83014d1b090');
INSERT INTO `login_log` VALUES (1835995351140605953, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 18:52:58', 'admin', '7e0e5d9fc68dea61a34e561a879ed230');
INSERT INTO `login_log` VALUES (1835996228274429954, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 18:56:27', 'admin', 'a2af9cd8a79cff7ce7d6207e1266b178');
INSERT INTO `login_log` VALUES (1835996566830260226, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 18:57:47', 'admin', '865e231b8839dd4e797eb4a25211d4fc');
INSERT INTO `login_log` VALUES (1836027643552669697, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 21:01:17', 'admin', '67d5514598e19bbe29ad2973bc623520');
INSERT INTO `login_log` VALUES (1836053657238405122, '0:0:0:0:0:0:0:1', '内网', '2024-09-17 22:44:39', 'admin', 'f7772d72ae4710e6ee7bd8d72b47918a');
INSERT INTO `login_log` VALUES (1836228925122953218, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:21:06', 'admin', 'c97895a0ceac22ae2935cf6b4c081810');
INSERT INTO `login_log` VALUES (1836234874688696321, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:44:44', 'admin', '9e970f0395e4dcde78fd530a42d15118');
INSERT INTO `login_log` VALUES (1836235003692904450, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:45:15', 'admin', '2058607e536ec9a39ff7fd574fd68d51');
INSERT INTO `login_log` VALUES (1836235631836065793, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:47:45', 'admin', '785a40c8ca506b171c44875e90793bfb');
INSERT INTO `login_log` VALUES (1836235868075986945, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:48:41', 'admin', '4e415461455ffe3dd345c1c7fb80bb3a');
INSERT INTO `login_log` VALUES (1836236971719004162, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:53:04', 'admin', '0b371e73f78fa3b0f59c7b88cfe30128');
INSERT INTO `login_log` VALUES (1836237225268875265, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:54:05', 'admin', '61dc75b8ed616a0496b3c9b063aa57f0');
INSERT INTO `login_log` VALUES (1836237628899332098, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:55:41', 'admin', '1d2fc3e4cfd7044e98c056f5860acda5');
INSERT INTO `login_log` VALUES (1836238031409930242, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 10:57:17', 'admin', '64b144c2826a4e8cf2ba69260b5215ea');
INSERT INTO `login_log` VALUES (1836238743732772866, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 11:00:07', 'admin', '53d086c2a2bd678d9d2b17a679a225ff');
INSERT INTO `login_log` VALUES (1836264550094102530, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 12:42:40', 'admin', '42e27c44c13ee74440f207ad5b7dc75e');
INSERT INTO `login_log` VALUES (1836265801418563585, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 12:47:38', 'admin', '7b9d23100a2db3b3ff3616e5fa2bb618');
INSERT INTO `login_log` VALUES (1836265863230021633, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 12:47:53', 'admin', 'ecdfe1118d258a7e5990c12f4f6bcdab');
INSERT INTO `login_log` VALUES (1836267578410987522, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 12:54:42', 'admin', 'cef8849675292fadd448f42ddb915437');
INSERT INTO `login_log` VALUES (1836267704948944897, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 12:55:12', 'admin', '308063b1a16d714c19c26b7b65805591');
INSERT INTO `login_log` VALUES (1836289059610267649, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 14:20:03', 'admin', '46662e80f743051509a9a7f5ce4f93f8');
INSERT INTO `login_log` VALUES (1836289213285371905, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 14:20:40', 'admin', '9177e236580c62e1691bd7528c4a079c');
INSERT INTO `login_log` VALUES (1836316373442203649, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 16:08:35', 'admin', 'b2efbc176b132488ac9d9bfeb1e2ebec');
INSERT INTO `login_log` VALUES (1836331278920581122, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 17:07:49', 'admin', '823fb47a146360a8bc98145cd2980e47');
INSERT INTO `login_log` VALUES (1836349254612828161, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 18:19:15', 'admin', 'b1a3699e4197d426c0fce42523ed384d');
INSERT INTO `login_log` VALUES (1836349295305965570, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 18:19:24', 'huawei', 'e71a5b4771e1ed70b2c2ffe76122fc05');
INSERT INTO `login_log` VALUES (1836407194245988353, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 22:09:29', 'admin', '0764fbcd073e47a8c5525ee5a1c3615e');
INSERT INTO `login_log` VALUES (1836421098271449089, '0:0:0:0:0:0:0:1', '内网', '2024-09-18 23:04:44', 'admin', '0f211df505072198d91c297932c7d786');
INSERT INTO `login_log` VALUES (1836580075298918402, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 09:36:27', 'admin', '063e1c1f61a6fe8929ba4d34b3e5c30a');
INSERT INTO `login_log` VALUES (1836580966118772738, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 09:39:59', 'admin', '26c92b5f6afee2e1a7ced010c071c951');
INSERT INTO `login_log` VALUES (1836635617195225089, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 13:17:09', 'admin', '7fb028738aa78931988309e355dc8334');
INSERT INTO `login_log` VALUES (1836635671901532161, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 13:17:22', 'admin', '73b013b7a860d5e2524786aaa0bb3eb2');
INSERT INTO `login_log` VALUES (1836642310151020545, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 13:43:45', 'admin', '786c1f7b008a598e38414fd80a3b4b9f');
INSERT INTO `login_log` VALUES (1836652670350299137, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 14:24:55', 'admin', 'd49546e332bffa13f956eddbfb2fbdf4');
INSERT INTO `login_log` VALUES (1836653259540959234, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 14:27:15', 'admin', 'fd8672bab62133b3efc89d89bb311de6');
INSERT INTO `login_log` VALUES (1836658421718355970, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 14:47:46', 'admin', '1e10bee7e497358a09140fad21270531');
INSERT INTO `login_log` VALUES (1836658495332585473, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 14:48:03', 'admin', '535989b3bfe7338d2ad2f861d8099eca');
INSERT INTO `login_log` VALUES (1836658893162319874, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 14:49:38', 'admin', 'b4e9e1c16ed2bac615a93f39c83eedf5');
INSERT INTO `login_log` VALUES (1836662730711404546, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 15:04:53', 'admin', 'af956f7d312d19be31a1e23e3f5acdaf');
INSERT INTO `login_log` VALUES (1836663607237054466, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 15:08:22', 'admin', 'ebd332842bfd255dcf69f7c2dcf5b29a');
INSERT INTO `login_log` VALUES (1836688712075874305, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 16:48:08', 'admin', '2b75415f08fdfdd2e6440fb206caa18b');
INSERT INTO `login_log` VALUES (1836688762457853954, '0:0:0:0:0:0:0:1', '内网', '2024-09-19 16:48:20', 'admin', '76aaccfe73da98d384fad6b11a20e921');

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
  `type` tinyint NULL DEFAULT 0 COMMENT '菜单类型 (0目录 1菜单 2其他)',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 (1正常 0禁用)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `redirect` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '重定向',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'admin' COMMENT '创建人',
  `link` tinyint NULL DEFAULT 0 COMMENT '是否外链 (0非外链 1外链)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 'system', 0, 'layout/index', '/system', 8, '系统管理', 1, 0, 'Setting', 1, '2024-07-31 05:49:29', 'admin', '2024-07-31 05:49:29', '/system/statistics', 'admin', 0);
INSERT INTO `menu` VALUES (2, 'user', 1, '', '/system/user', 7, '用户管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', 'admin', '2024-09-18 18:30:48', '/system/user/index', 'admin', 0);
INSERT INTO `menu` VALUES (3, 'role', 1, 'system/role/index', '/system/role', 10, '角色管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (4, 'menu', 1, 'system/menu/index', '/system/menu', 12, '菜单管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (5, 'permission', 1, 'system/permission/index', '/system/permission', 14, '权限管理', 2, 1, 'User', 1, '2024-07-31 05:49:29', NULL, '2024-07-31 05:49:29', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (6, 'user-add', 2, 'system/user/add', '/system/user/add', 4, '新增用户', 3, 2, 'User', 1, '2024-08-02 12:51:37', 'admin', '2024-09-18 18:28:56', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (7, 'user-edit', 2, 'system/user/edit', '/system/user/edit/:userId', 2, '编辑用户', 3, 2, 'User', 1, '2024-08-02 13:14:49', 'admin', '2024-09-18 18:27:41', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (8, 'user-detail', 2, 'system/user/detail', '/system/user/detail/:userId', 3, '用户详细', 3, 2, 'User', 1, '2024-08-02 13:14:49', 'admin', '2024-09-18 18:27:26', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1823348525811974145, 'operationLog', 1, 'system/operationLog/index', '/system/operationLog', 11, '日志管理', 2, 1, 'Calendar', 1, '2024-08-13 21:18:59', 'admin', '2024-08-13 21:18:59', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1823701366858686465, 'apiDocument', 0, NULL, '/api/swagger-ui/index.html', 17, '接口文档', 1, 1, 'ChatLineSquare', 1, '2024-08-14 20:41:03', 'admin', '2024-08-14 20:41:03', NULL, 'admin', 1);
INSERT INTO `menu` VALUES (1824754469368238082, 'generator', 1, 'system/generator/index', '/system/generator', 13, '文档生成', 2, 1, 'Box', 1, '2024-08-17 18:25:42', 'admin', '2024-08-17 18:25:42', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1825472650722430977, 'cache', 1, 'system/cache/index', '/system/cache', 15, '缓存管理', 2, 1, 'BellFilled', 1, '2024-08-19 17:59:30', 'admin', '2024-08-19 17:59:30', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1826103825019232257, 'cacheInfo', 1825472650722430977, 'system/cache/info', '/system/cache/info/:key', 1, '缓存详细', 3, 2, 'User', 1, '2024-08-21 11:47:34', 'admin', '2024-08-21 11:47:34', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1826235764657106945, 'schedule', 1, NULL, '/system/schedule', 16, '任务调度', 2, 0, 'Bicycle', 1, '2024-08-21 20:31:51', 'admin', '2024-08-21 20:31:51', '/system/schedule/job', 'admin', 0);
INSERT INTO `menu` VALUES (1826236194250305537, 'job', 1826235764657106945, 'system/schedule/job', '/system/schedule/job', 2, '任务管理', 3, 1, 'AlarmClock', 1, '2024-08-21 20:33:33', 'admin', '2024-08-21 20:33:33', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1826236706106388481, 'scheduleLog', 1826235764657106945, 'system/schedule/log', '/system/schedule/log', 3, '调度日志', 3, 1, 'DocumentCopy', 1, '2024-08-21 20:35:35', 'admin', '2024-08-21 20:35:35', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1828029462176948226, 'loginLog', 1, 'system/loginLog/index', '/system/loginLog', 17, '登录日志', 2, 1, 'ChatLineRound', 1, '2024-08-26 19:19:22', 'admin', '2024-08-26 19:19:22', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1836028630535315458, 'statistics', 1, 'system/statistics/index', '/system/statistics', 3, '分类统计', 2, 1, 'Camera', 1, '2024-09-17 21:05:12', 'admin', '2024-09-17 21:17:18', NULL, 'admin', 0);
INSERT INTO `menu` VALUES (1836352430179106817, 'user-list', 2, 'system/user/index', '/system/user/index', 1, '用户列表', 3, 2, 'AlarmClock', 1, '2024-09-18 18:31:52', 'admin', '2024-09-18 18:32:55', NULL, 'admin', 0);

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint NOT NULL COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 1 COMMENT '业务类型 (1其它 2新增 3更改 4删除 5授权 6导出 7导入 8强退)',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 1 COMMENT '操作类别 (1后台用户 2其他 3手机端用户)',
  `operation_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `operation_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 1 COMMENT '操作状态 (1正常 0异常)',
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
INSERT INTO `operation_log` VALUES (1836589541763371011, '用户管理', 2, 'com.chq.app.controller.UserController.add()', 'POST', 1, 'admin', '{\"avatar\":\"/minio/app/4823f861852d17ec03b15fa165416b36.avif\",\"createBy\":\"admin\",\"createTime\":\"2024-09-19 10:14:03.595710800\",\"email\":\"123456\",\"id\":\"1836589541696262145\",\"roles\":[{\"id\":\"2\"}],\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2024-09-19 10:14:03.595710800\",\"username\":\"aweoqu\"}', '{\"code\":200,\"data\":1}', 1, '', '2024-09-19 10:14:04', 89);
INSERT INTO `operation_log` VALUES (1836596315681726466, '用户管理', 2, 'com.chq.app.controller.UserController.add()', 'POST', 1, 'admin', '{\"avatar\":\"/minio/app/4823f861852d17ec03b15fa165416b36.avif\",\"createBy\":\"admin\",\"createTime\":\"2024-09-19 10:40:58.623675\",\"id\":\"1836596315618811906\",\"roles\":[{\"id\":\"2\"}],\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2024-09-19 10:40:58.623675\",\"username\":\"weqe5\"}', '{\"code\":200,\"data\":1}', 1, '', '2024-09-19 10:40:59', 106);
INSERT INTO `operation_log` VALUES (1836596373340823554, '删除用户', 4, 'com.chq.app.controller.UserController.delete()', 'DELETE', 1, 'admin', '[\"1836596315618811906\"]', '{\"code\":200,\"data\":1}', 1, '', '2024-09-19 10:41:12', 22);
INSERT INTO `operation_log` VALUES (1836596483462275074, '用户管理', 2, 'com.chq.app.controller.UserController.add()', 'POST', 1, 'admin', '{\"avatar\":\"/minio/app/4823f861852d17ec03b15fa165416b36.avif\",\"createBy\":\"admin\",\"createTime\":\"2024-09-19 10:41:38.623397500\",\"email\":\"weqweqwe\",\"id\":\"1836596483395166209\",\"roles\":[{\"id\":\"2\"}],\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2024-09-19 10:41:38.623397500\",\"username\":\"qweqwe\"}', '{\"code\":200,\"data\":1}', 1, '', '2024-09-19 10:41:39', 73);
INSERT INTO `operation_log` VALUES (1836596520053383170, '用户管理', 2, 'com.chq.app.controller.UserController.add()', 'POST', 1, 'admin', '{\"createBy\":\"admin\",\"createTime\":\"2024-09-19 10:41:47.350572600\",\"email\":\"ewqeqweqweqw\",\"id\":\"1836596519990468609\",\"roles\":[{\"id\":\"2\"}],\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2024-09-19 10:41:47.350572600\",\"username\":\"weqweqwe\"}', '{\"code\":200,\"data\":1}', 1, '', '2024-09-19 10:41:47', 72);
INSERT INTO `operation_log` VALUES (1836596560859766786, '删除用户', 4, 'com.chq.app.controller.UserController.delete()', 'DELETE', 1, 'admin', '[\"1836596483395166209\",\"1836596519990468609\"]', '{\"code\":200,\"data\":2}', 1, '', '2024-09-19 10:41:57', 8);
INSERT INTO `operation_log` VALUES (1836641423475204098, '用户管理', 2, 'com.chq.app.controller.UserController.add()', 'POST', 1, 'admin', '{\"avatar\":\"/minio/app/4823f861852d17ec03b15fa165416b36.avif\",\"createBy\":\"admin\",\"createTime\":\"2024-09-19 13:40:13.140485700\",\"email\":\"1340592570@qq.com\",\"gender\":2,\"id\":\"1836641423382929410\",\"phone\":\"13456789009\",\"roles\":[{\"id\":\"2\"}],\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2024-09-19 13:40:13.140485700\",\"username\":\"wqeoqwu\"}', '{\"code\":200,\"data\":1}', 1, '', '2024-09-19 13:40:13', 111);
INSERT INTO `operation_log` VALUES (1836693841135128578, '分配角色菜单操作', 5, 'com.chq.app.controller.RoleController.assignMenu()', 'PUT', 1, 'admin', '{\"menuIds\":[\"1\",\"1836028630535315458\",\"2\",\"1836352430179106817\",\"7\",\"8\",\"6\",\"3\",\"1823348525811974145\",\"4\",\"1824754469368238082\",\"5\",\"1825472650722430977\",\"1826103825019232257\",\"1826235764657106945\",\"1826236194250305537\",\"1828029462176948226\",\"1823701366858686465\"],\"roleId\":\"2\"}', '{\"code\":200,\"data\":18}', 1, '', '2024-09-19 17:08:31', 45);
INSERT INTO `operation_log` VALUES (1836693861825630224, '分配角色菜单操作', 5, 'com.chq.app.controller.RoleController.assignMenu()', 'PUT', 1, 'admin', '{\"menuIds\":[\"1\",\"1823701366858686465\",\"1836028630535315458\",\"2\",\"3\",\"1823348525811974145\",\"4\",\"1824754469368238082\",\"5\",\"1825472650722430977\",\"1826235764657106945\",\"1828029462176948226\",\"1836352430179106817\",\"1826103825019232257\",\"7\",\"1826236194250305537\",\"8\",\"6\",\"1826236706106388481\"],\"roleId\":\"2\"}', '{\"code\":200,\"data\":19}', 1, '', '2024-09-19 17:08:35', 13);
INSERT INTO `operation_log` VALUES (1836698078682411009, '分配角色菜单操作', 5, 'com.chq.app.controller.RoleController.assignMenu()', 'PUT', 1, 'admin', '{\"menuIds\":[\"1\",\"1836028630535315458\",\"2\",\"1836352430179106817\",\"7\",\"8\",\"6\",\"3\",\"1823348525811974145\",\"4\",\"1824754469368238082\",\"5\",\"1825472650722430977\",\"1826235764657106945\",\"1826236194250305537\",\"1826236706106388481\",\"1828029462176948226\",\"1823701366858686465\"],\"roleId\":\"2\"}', '{\"code\":200,\"data\":18}', 1, '', '2024-09-19 17:25:21', 40);
INSERT INTO `operation_log` VALUES (1836698142687490050, '分配角色菜单操作', 5, 'com.chq.app.controller.RoleController.assignMenu()', 'PUT', 1, 'admin', '{\"menuIds\":[\"1\",\"1823701366858686465\",\"1836028630535315458\",\"2\",\"3\",\"1823348525811974145\",\"4\",\"1824754469368238082\",\"5\",\"1825472650722430977\",\"1826235764657106945\",\"1828029462176948226\",\"1836352430179106817\",\"7\",\"1826236194250305537\",\"8\",\"1826236706106388481\",\"6\",\"1826103825019232257\"],\"roleId\":\"2\"}', '{\"code\":200,\"data\":19}', 1, '', '2024-09-19 17:25:36', 12);
INSERT INTO `operation_log` VALUES (1836708402609385474, '分配角色菜单操作', 5, 'com.chq.app.controller.RoleController.assignPermission()', 'PUT', 1, 'admin', '{\"permissionIds\":[\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"22\",\"23\",\"24\",\"25\",\"31\",\"32\",\"33\",\"34\",\"35\",\"36\",\"37\",\"38\",\"39\",\"1\",\"2\",\"3\",\"26\",\"27\",\"28\",\"29\",\"30\",\"19\",\"20\",\"21\",\"18\"],\"roleId\":\"2\"}', '{\"code\":200,\"data\":38}', 1, '', '2024-09-19 18:06:22', 20);
INSERT INTO `operation_log` VALUES (1836708416253456385, '分配角色菜单操作', 5, 'com.chq.app.controller.RoleController.assignPermission()', 'PUT', 1, 'admin', '{\"permissionIds\":[\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"22\",\"23\",\"24\",\"25\",\"31\",\"32\",\"33\",\"34\",\"35\",\"36\",\"37\",\"38\",\"39\",\"1\",\"2\",\"3\",\"26\",\"27\",\"28\",\"29\",\"30\",\"19\",\"20\",\"21\",\"18\",\"4\"],\"roleId\":\"2\"}', '{\"code\":200,\"data\":39}', 1, '', '2024-09-19 18:06:25', 17);
INSERT INTO `operation_log` VALUES (1836709710967881730, '删除用户', 4, 'com.chq.app.controller.UserController.delete()', 'DELETE', 1, 'admin', '[\"1836641423382929410\"]', '{\"code\":200,\"data\":1}', 1, '', '2024-09-19 18:11:34', 25);

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
INSERT INTO `role_menu` VALUES (1836698142653935618, 2, 1);
INSERT INTO `role_menu` VALUES (1836698142658129922, 2, 1823701366858686465);
INSERT INTO `role_menu` VALUES (1836698142658129923, 2, 1836028630535315458);
INSERT INTO `role_menu` VALUES (1836698142658129924, 2, 2);
INSERT INTO `role_menu` VALUES (1836698142658129925, 2, 3);
INSERT INTO `role_menu` VALUES (1836698142658129926, 2, 1823348525811974145);
INSERT INTO `role_menu` VALUES (1836698142658129927, 2, 4);
INSERT INTO `role_menu` VALUES (1836698142662324225, 2, 1824754469368238082);
INSERT INTO `role_menu` VALUES (1836698142662324226, 2, 5);
INSERT INTO `role_menu` VALUES (1836698142662324227, 2, 1825472650722430977);
INSERT INTO `role_menu` VALUES (1836698142662324228, 2, 1826235764657106945);
INSERT INTO `role_menu` VALUES (1836698142662324229, 2, 1828029462176948226);
INSERT INTO `role_menu` VALUES (1836698142662324230, 2, 1836352430179106817);
INSERT INTO `role_menu` VALUES (1836698142662324231, 2, 7);
INSERT INTO `role_menu` VALUES (1836698142662324232, 2, 1826236194250305537);
INSERT INTO `role_menu` VALUES (1836698142662324233, 2, 8);
INSERT INTO `role_menu` VALUES (1836698142666518530, 2, 1826236706106388481);
INSERT INTO `role_menu` VALUES (1836698142666518531, 2, 6);
INSERT INTO `role_menu` VALUES (1836698142666518532, 2, 1826103825019232257);

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
INSERT INTO `role_permission` VALUES (1, 2, 1);
INSERT INTO `role_permission` VALUES (2, 2, 2);
INSERT INTO `role_permission` VALUES (3, 2, 3);
INSERT INTO `role_permission` VALUES (4, 2, 4);
INSERT INTO `role_permission` VALUES (5, 2, 5);
INSERT INTO `role_permission` VALUES (6, 2, 6);
INSERT INTO `role_permission` VALUES (7, 2, 7);
INSERT INTO `role_permission` VALUES (8, 2, 8);
INSERT INTO `role_permission` VALUES (9, 2, 9);
INSERT INTO `role_permission` VALUES (10, 2, 10);
INSERT INTO `role_permission` VALUES (11, 2, 11);
INSERT INTO `role_permission` VALUES (12, 2, 12);
INSERT INTO `role_permission` VALUES (13, 2, 13);
INSERT INTO `role_permission` VALUES (14, 2, 14);
INSERT INTO `role_permission` VALUES (15, 2, 15);
INSERT INTO `role_permission` VALUES (16, 2, 16);
INSERT INTO `role_permission` VALUES (17, 2, 17);
INSERT INTO `role_permission` VALUES (18, 2, 18);
INSERT INTO `role_permission` VALUES (19, 2, 19);
INSERT INTO `role_permission` VALUES (20, 2, 20);
INSERT INTO `role_permission` VALUES (21, 2, 21);
INSERT INTO `role_permission` VALUES (22, 2, 22);
INSERT INTO `role_permission` VALUES (23, 2, 23);
INSERT INTO `role_permission` VALUES (24, 2, 24);
INSERT INTO `role_permission` VALUES (25, 2, 25);
INSERT INTO `role_permission` VALUES (26, 2, 26);
INSERT INTO `role_permission` VALUES (27, 2, 27);
INSERT INTO `role_permission` VALUES (28, 2, 28);
INSERT INTO `role_permission` VALUES (29, 2, 29);
INSERT INTO `role_permission` VALUES (30, 2, 30);
INSERT INTO `role_permission` VALUES (31, 2, 31);
INSERT INTO `role_permission` VALUES (32, 2, 32);
INSERT INTO `role_permission` VALUES (33, 2, 33);
INSERT INTO `role_permission` VALUES (34, 2, 34);
INSERT INTO `role_permission` VALUES (35, 2, 35);
INSERT INTO `role_permission` VALUES (36, 2, 36);
INSERT INTO `role_permission` VALUES (37, 2, 37);
INSERT INTO `role_permission` VALUES (38, 2, 38);
INSERT INTO `role_permission` VALUES (39, 2, 39);

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
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '加密后的密码',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `gender` tinyint NULL DEFAULT NULL COMMENT '性别  (1男 2女 3其它)',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif' COMMENT '头像',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 (1正常 0禁用)',
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
