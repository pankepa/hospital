
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for PDMAN_DB_VERSION
-- ----------------------------
DROP TABLE IF EXISTS `PDMAN_DB_VERSION`;
CREATE TABLE `PDMAN_DB_VERSION`  (
                                     `DB_VERSION` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `VERSION_DESC` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `CREATED_TIME` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospital_clinic
-- ----------------------------
DROP TABLE IF EXISTS `hospital_clinic`;
CREATE TABLE `hospital_clinic`  (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '诊室编号',
                                    `outpatient_id` bigint(20) NOT NULL COMMENT '所属门诊',
                                    `address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '诊室地址',
                                    `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                    `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10006 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '诊室信息表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospital_doctor
-- ----------------------------
DROP TABLE IF EXISTS `hospital_doctor`;
CREATE TABLE `hospital_doctor`  (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '医生编号',
                                    `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医生姓名',
                                    `gender` int(11) NOT NULL DEFAULT 1 COMMENT '性别：1，男；2，女',
                                    `job_title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医生职称',
                                    `specialty` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医生专长',
                                    `special_id` bigint(20) NOT NULL COMMENT '所属专科',
                                    `outpatient_id` bigint(20) NOT NULL COMMENT '所属门诊',
                                    `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
                                    `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `hospital_doctor_hospital_outpatient_id_fk`(`outpatient_id`) USING BTREE,
                                    INDEX `hospital_doctor_hospital_special_id_fk`(`special_id`) USING BTREE,
                                    CONSTRAINT `hospital_doctor_hospital_outpatient_id_fk` FOREIGN KEY (`outpatient_id`) REFERENCES `hospital_outpatient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `hospital_doctor_hospital_special_id_fk` FOREIGN KEY (`special_id`) REFERENCES `hospital_special` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10008 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医生信息表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospital_info
-- ----------------------------
DROP TABLE IF EXISTS `hospital_info`;
CREATE TABLE `hospital_info`  (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '医院编号 从1001开始',
                                  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医院名称',
                                  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医院电话',
                                  `address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医院地址',
                                  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医院简介',
                                  `picture` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医院图片',
                                  `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
                                  `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE INDEX `hospital_info_phone_uindex`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1008 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医院信息表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospital_outpatient
-- ----------------------------
DROP TABLE IF EXISTS `hospital_outpatient`;
CREATE TABLE `hospital_outpatient`  (
                                        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '门诊编号',
                                        `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '门诊名称',
                                        `special_id` bigint(20) NOT NULL COMMENT '所属专科',
                                        `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
                                        `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
                                        PRIMARY KEY (`id`) USING BTREE,
                                        INDEX `hospital_outpatient_hospital_special_id_fk`(`special_id`) USING BTREE,
                                        CONSTRAINT `hospital_outpatient_hospital_special_id_fk` FOREIGN KEY (`special_id`) REFERENCES `hospital_special` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10015 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医院门诊表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospital_outpatient_relation
-- ----------------------------
DROP TABLE IF EXISTS `hospital_outpatient_relation`;
CREATE TABLE `hospital_outpatient_relation`  (
                                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                                 `hospital_id` bigint(20) NOT NULL COMMENT '医院编号',
                                                 `outpatient_id` bigint(20) NOT NULL COMMENT '门诊编号',
                                                 `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                                 `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                                 PRIMARY KEY (`id`) USING BTREE,
                                                 INDEX `hospital_outpatient_relation_hospital_info_id_fk`(`hospital_id`) USING BTREE,
                                                 INDEX `hospital_outpatient_relation_hospital_outpatient_id_fk`(`outpatient_id`) USING BTREE,
                                                 CONSTRAINT `hospital_outpatient_relation_hospital_info_id_fk` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                 CONSTRAINT `hospital_outpatient_relation_hospital_outpatient_id_fk` FOREIGN KEY (`outpatient_id`) REFERENCES `hospital_outpatient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医院门诊关系表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospital_special
-- ----------------------------
DROP TABLE IF EXISTS `hospital_special`;
CREATE TABLE `hospital_special`  (
                                     `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '专科编号',
                                     `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专科名称',
                                     `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专科简介',
                                     `gmt_create` datetime(0) NOT NULL COMMENT '创建时间',
                                     `gmt_modified` datetime(0) NOT NULL COMMENT '更新时间',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `hospital_special_name_uindex`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10011 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '医院专科表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hospital_special_relation
-- ----------------------------
DROP TABLE IF EXISTS `hospital_special_relation`;
CREATE TABLE `hospital_special_relation`  (
                                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                              `hospital_id` bigint(20) NOT NULL COMMENT '医院编号',
                                              `special_id` bigint(20) NOT NULL COMMENT '专科编号',
                                              `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                              `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                              PRIMARY KEY (`id`) USING BTREE,
                                              INDEX `hospital_special_relation_hospital_info_id_fk`(`hospital_id`) USING BTREE,
                                              INDEX `hospital_special_relation_hospital_special_id_fk`(`special_id`) USING BTREE,
                                              CONSTRAINT `hospital_special_relation_hospital_info_id_fk` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                              CONSTRAINT `hospital_special_relation_hospital_special_id_fk` FOREIGN KEY (`special_id`) REFERENCES `hospital_special` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = ' ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_account_login
-- ----------------------------
DROP TABLE IF EXISTS `log_account_login`;
CREATE TABLE `log_account_login`  (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '登录记录编号',
                                      `account_id` bigint(20) NOT NULL COMMENT '账号编号',
                                      `account_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账号名称',
                                      `ip_address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
                                      `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                      `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `log_account_login_power_account_id_fk`(`account_id`) USING BTREE,
                                      CONSTRAINT `log_account_login_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10059 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账号登录记录表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_operation
-- ----------------------------
DROP TABLE IF EXISTS `log_operation`;
CREATE TABLE `log_operation`  (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                  `account_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账号名称',
                                  `start_time` bigint(20) NULL DEFAULT NULL COMMENT '开始时间',
                                  `spend_time` int(11) NULL DEFAULT NULL COMMENT '消耗时间',
                                  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
                                  `base_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '根路径',
                                  `uri` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'uri',
                                  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'url',
                                  `method` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法',
                                  `ip_address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
                                  `parameter` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
                                  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求结果',
                                  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  INDEX `log_operation_power_account_name_fk`(`account_name`) USING BTREE,
                                  CONSTRAINT `log_operation_power_account_name_fk` FOREIGN KEY (`account_name`) REFERENCES `power_account` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11924 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户操作记录表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for power_account
-- ----------------------------
DROP TABLE IF EXISTS `power_account`;
CREATE TABLE `power_account`  (
                                  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号 唯一',
                                  `password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码 使用md5加密',
                                  `status` int(11) NOT NULL DEFAULT 1 COMMENT '账号状态 1：正常，0：锁定',
                                  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
                                  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE INDEX `power_account_name_uindex`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10000004 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账号信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for power_account_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `power_account_role_relation`;
CREATE TABLE `power_account_role_relation`  (
                                                `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账号角色关系编号',
                                                `account_id` bigint(20) NOT NULL COMMENT '账号编号',
                                                `role_id` bigint(20) NOT NULL COMMENT '角色编号',
                                                `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                                `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                                PRIMARY KEY (`id`) USING BTREE,
                                                INDEX `power_account_role_relation_power_role_id_fk`(`role_id`) USING BTREE,
                                                INDEX `power_account_role_relation_power_account_id_fk`(`account_id`) USING BTREE,
                                                CONSTRAINT `power_account_role_relation_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                CONSTRAINT `power_account_role_relation_power_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `power_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账号角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for power_menu
-- ----------------------------
DROP TABLE IF EXISTS `power_menu`;
CREATE TABLE `power_menu`  (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
                               `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父级菜单',
                               `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
                               `level` int(11) NOT NULL COMMENT '菜单级数',
                               `sort` int(11) NOT NULL COMMENT '菜单排序',
                               `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前端路径',
                               `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前端图标',
                               `hidden` int(11) NOT NULL DEFAULT 1 COMMENT '前端隐藏 0：隐藏，1：显示',
                               `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                               `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `power_menu_name_uindex`(`name`) USING BTREE,
                               UNIQUE INDEX `power_menu_title_uindex`(`title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限菜单表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for power_resource
-- ----------------------------
DROP TABLE IF EXISTS `power_resource`;
CREATE TABLE `power_resource`  (
                                   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '资源编号',
                                   `category_id` bigint(20) NOT NULL COMMENT '资源分类编号',
                                   `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源名称',
                                   `url` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源URL',
                                   `description` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源描述',
                                   `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                   `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE INDEX `power_resource_url_uindex`(`url`) USING BTREE,
                                   UNIQUE INDEX `power_resource_name_uindex`(`name`) USING BTREE,
                                   INDEX `power_resource_power_resource_category_id_fk`(`category_id`) USING BTREE,
                                   CONSTRAINT `power_resource_power_resource_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `power_resource_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限资源表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for power_resource_category
-- ----------------------------
DROP TABLE IF EXISTS `power_resource_category`;
CREATE TABLE `power_resource_category`  (
                                            `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类编号',
                                            `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
                                            `sort` int(11) NOT NULL DEFAULT 1 COMMENT '分类排序 数值越小，越靠前',
                                            `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                            `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                            PRIMARY KEY (`id`) USING BTREE,
                                            UNIQUE INDEX `power_resource_category_name_uindex`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限资源分类表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for power_role
-- ----------------------------
DROP TABLE IF EXISTS `power_role`;
CREATE TABLE `power_role`  (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
                               `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '英文名称',
                               `chinese_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '中文名称',
                               `admin_count` int(11) NOT NULL DEFAULT 0 COMMENT '用户数目',
                               `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序 越小越靠前',
                               `status` int(11) NOT NULL DEFAULT 1 COMMENT '角色状态 1：启用，0：禁用',
                               `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                               `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE INDEX `power_role_name_uindex`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for power_role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `power_role_menu_relation`;
CREATE TABLE `power_role_menu_relation`  (
                                             `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                             `role_id` bigint(20) NOT NULL COMMENT '角色编号',
                                             `menu_id` bigint(20) NOT NULL COMMENT '菜单编号',
                                             `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                             `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                             PRIMARY KEY (`id`) USING BTREE,
                                             INDEX `power_role_menu_relation_power_menu_id_fk`(`menu_id`) USING BTREE,
                                             INDEX `power_role_menu_relation_power_role_id_fk`(`role_id`) USING BTREE,
                                             CONSTRAINT `power_role_menu_relation_power_menu_id_fk` FOREIGN KEY (`menu_id`) REFERENCES `power_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                             CONSTRAINT `power_role_menu_relation_power_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `power_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关系表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for power_role_resource_relation
-- ----------------------------
DROP TABLE IF EXISTS `power_role_resource_relation`;
CREATE TABLE `power_role_resource_relation`  (
                                                 `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                                 `role_id` bigint(20) NOT NULL COMMENT '角色编号',
                                                 `resource_id` bigint(20) NOT NULL COMMENT '资源编号',
                                                 `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                                 `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                                 PRIMARY KEY (`id`) USING BTREE,
                                                 INDEX `power_role_resource_relation_power_resource_id_fk`(`resource_id`) USING BTREE,
                                                 INDEX `power_role_resource_relation_power_role_id_fk`(`role_id`) USING BTREE,
                                                 CONSTRAINT `power_role_resource_relation_power_resource_id_fk` FOREIGN KEY (`resource_id`) REFERENCES `power_resource` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                                 CONSTRAINT `power_role_resource_relation_power_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `power_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色资源关系表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `user_basic_info`;
CREATE TABLE `user_basic_info`  (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                    `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
                                    `avatar_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户头像',
                                    `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
                                    `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                    `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `user_basic_info_phone_uindex`(`phone`) USING BTREE,
                                    CONSTRAINT `user_basic_info_power_account_name_fk` FOREIGN KEY (`phone`) REFERENCES `power_account` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户基础信息表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_case
-- ----------------------------
DROP TABLE IF EXISTS `user_case`;
CREATE TABLE `user_case`  (
                              `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
                              `account_id` bigint(20) NOT NULL COMMENT '账号编号',
                              `order_id` bigint(20) NOT NULL COMMENT '预约编号',
                              `doctor_id` bigint(20) NOT NULL COMMENT '医生编号',
                              `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '病例详情',
                              `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                              `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                              PRIMARY KEY (`id`) USING BTREE,
                              INDEX `user_case_hospital_doctor_id_fk`(`doctor_id`) USING BTREE,
                              INDEX `user_case_power_account_id_fk`(`account_id`) USING BTREE,
                              CONSTRAINT `user_case_hospital_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `hospital_doctor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `user_case_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户病例表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_medical_card
-- ----------------------------
DROP TABLE IF EXISTS `user_medical_card`;
CREATE TABLE `user_medical_card`  (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '就诊卡号',
                                      `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
                                      `gender` int(11) NOT NULL DEFAULT 1 COMMENT '性别 男：1，女：2',
                                      `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
                                      `identification_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '证件号',
                                      `birth_date` datetime(0) NOT NULL COMMENT '出生日期',
                                      `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                      `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      UNIQUE INDEX `user_medical_card_identification_number_uindex`(`identification_number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7000003 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户就诊卡信息表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_medical_card_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_medical_card_relation`;
CREATE TABLE `user_medical_card_relation`  (
                                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                               `type` int(11) NOT NULL COMMENT '关系类型 0：本人，1：父母，2：兄弟/姐妹，3：伴侣，4：子女，5：同事/朋友，6：其他',
                                               `account_id` bigint(20) NOT NULL COMMENT '账号编号',
                                               `card_id` bigint(20) NOT NULL COMMENT '就诊卡编号',
                                               `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                               `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                               PRIMARY KEY (`id`) USING BTREE,
                                               INDEX `user_medical_card_relation_power_account_id_fk`(`account_id`) USING BTREE,
                                               INDEX `user_medical_card_relation_user_medical_card_id_fk`(`card_id`) USING BTREE,
                                               CONSTRAINT `user_medical_card_relation_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                               CONSTRAINT `user_medical_card_relation_user_medical_card_id_fk` FOREIGN KEY (`card_id`) REFERENCES `user_medical_card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户就诊卡关系表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for visit_appointment
-- ----------------------------
DROP TABLE IF EXISTS `visit_appointment`;
CREATE TABLE `visit_appointment`  (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '预约编号',
                                      `plan_id` bigint(20) NOT NULL COMMENT '出诊编号',
                                      `card_id` bigint(20) NOT NULL COMMENT '就诊卡号',
                                      `account_id` bigint(20) NOT NULL COMMENT '账号编号',
                                      `time_period` int(11) NOT NULL COMMENT '1： 8点半~9点，2： 9点~9点半，3： 9点半~10点，4： 10点~10点半，5： 11点~11点半，6： 11点半~12点，7：2点~2点半，8： 2点半~3点，9： 3点~3点半，10： 3点半~4点，11： 4点~4点半，12： 4点半~5点，13： 5点~5点半，14：5点半~6点',
                                      `status` int(11) NOT NULL DEFAULT 0 COMMENT '预约状态 0：未开始，1：未按时就诊，2：取消预约挂号，3：已完成',
                                      `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                      `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      INDEX `visit_order_user_medical_card_id_fk`(`card_id`) USING BTREE,
                                      INDEX `visit_order_visit_plan_id_fk`(`plan_id`) USING BTREE,
                                      INDEX `visit_order_power_account_id_fk`(`account_id`) USING BTREE,
                                      CONSTRAINT `visit_order_power_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `power_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `visit_order_user_medical_card_id_fk` FOREIGN KEY (`card_id`) REFERENCES `user_medical_card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `visit_order_visit_plan_id_fk` FOREIGN KEY (`plan_id`) REFERENCES `visit_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出诊预约表 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for visit_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `visit_blacklist`;
CREATE TABLE `visit_blacklist`  (
                                    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '名单编号',
                                    `card_id` bigint(20) NOT NULL COMMENT '就诊卡号',
                                    `status` int(11) NOT NULL DEFAULT 1 COMMENT '禁封状态 1：生效，2：已解封',
                                    `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                    `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    INDEX `visit_blacklist_user_medical_card_id_fk`(`card_id`) USING BTREE,
                                    CONSTRAINT `visit_blacklist_user_medical_card_id_fk` FOREIGN KEY (`card_id`) REFERENCES `user_medical_card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出诊黑名单 ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for visit_plan
-- ----------------------------
DROP TABLE IF EXISTS `visit_plan`;
CREATE TABLE `visit_plan`  (
                               `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '出诊编号',
                               `hospital_id` bigint(20) NOT NULL COMMENT '医院编号',
                               `special_id` bigint(20) NOT NULL COMMENT '专科编号',
                               `outpatient_id` bigint(20) NOT NULL COMMENT '门诊编号',
                               `clinic_id` bigint(20) NOT NULL COMMENT '诊室编号',
                               `doctor_id` bigint(20) NOT NULL COMMENT '医生编号',
                               `time` int(11) NOT NULL DEFAULT 1 COMMENT '时间段 1：上午，2：下午',
                               `day` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '出诊日期',
                               `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                               `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
                               PRIMARY KEY (`id`) USING BTREE,
                               INDEX `visit_plan_hospital_clinic_id_fk`(`clinic_id`) USING BTREE,
                               INDEX `visit_plan_hospital_doctor_id_fk`(`doctor_id`) USING BTREE,
                               INDEX `visit_plan_hospital_info_id_fk`(`hospital_id`) USING BTREE,
                               INDEX `visit_plan_hospital_special_id_fk`(`special_id`) USING BTREE,
                               INDEX `visit_plan_hospital_outpatient_id_fk`(`outpatient_id`) USING BTREE,
                               CONSTRAINT `visit_plan_hospital_clinic_id_fk` FOREIGN KEY (`clinic_id`) REFERENCES `hospital_clinic` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `visit_plan_hospital_doctor_id_fk` FOREIGN KEY (`doctor_id`) REFERENCES `hospital_doctor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `visit_plan_hospital_info_id_fk` FOREIGN KEY (`hospital_id`) REFERENCES `hospital_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `visit_plan_hospital_outpatient_id_fk` FOREIGN KEY (`outpatient_id`) REFERENCES `hospital_outpatient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `visit_plan_hospital_special_id_fk` FOREIGN KEY (`special_id`) REFERENCES `hospital_special` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10042 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出诊信息表 ' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
