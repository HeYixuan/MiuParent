/*
Navicat MySQL Data Transfer

Source Server         : test@jiyue
Source Server Version : 50718
Source Host           : rm-2ze1oz4pi4woc067syo.mysql.rds.aliyuncs.com:3306
Source Database       : pig

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-10-16 15:12:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for job_execution_log
-- ----------------------------
DROP TABLE IF EXISTS `job_execution_log`;
CREATE TABLE `job_execution_log` (
  `id` varchar(40) NOT NULL,
  `job_name` varchar(100) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `sharding_item` int(11) NOT NULL,
  `execution_source` varchar(20) NOT NULL,
  `failure_cause` varchar(4000) DEFAULT NULL,
  `is_success` int(11) NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `complete_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of job_execution_log
-- ----------------------------

-- ----------------------------
-- Table structure for job_status_trace_log
-- ----------------------------
DROP TABLE IF EXISTS `job_status_trace_log`;
CREATE TABLE `job_status_trace_log` (
  `id` varchar(40) NOT NULL,
  `job_name` varchar(100) NOT NULL,
  `original_task_id` varchar(255) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `slave_id` varchar(50) NOT NULL,
  `source` varchar(50) NOT NULL,
  `execution_type` varchar(20) NOT NULL,
  `sharding_item` varchar(100) NOT NULL,
  `state` varchar(20) NOT NULL,
  `message` varchar(4000) DEFAULT NULL,
  `creation_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of job_status_trace_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('2', '广东分部', null, '2018-01-22 19:00:38', '2018-09-04 11:39:54', '0', '0');
INSERT INTO `sys_dept` VALUES ('8', '南山软产基地', null, '2018-01-22 19:02:03', '2018-09-04 11:40:47', '0', '7');
INSERT INTO `sys_dept` VALUES ('10', '北京总部', null, '2018-09-04 11:42:53', null, '0', '0');
INSERT INTO `sys_dept` VALUES ('11', '深圳子公司', null, '2018-09-04 11:47:04', null, '0', '2');

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation` (
  `ancestor` int(11) NOT NULL COMMENT '祖先节点',
  `descendant` int(11) NOT NULL COMMENT '后代节点',
  PRIMARY KEY (`ancestor`,`descendant`),
  KEY `idx1` (`ancestor`),
  KEY `idx2` (`descendant`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
INSERT INTO `sys_dept_relation` VALUES ('11', '11');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('2', '9', '异常', 'log_type', '日志异常', '1', '2017-12-28 13:06:39', '2018-01-06 10:54:41', null, '0');
INSERT INTO `sys_dict` VALUES ('3', '0', '正常', 'log_type', '正常', '1', '2018-05-11 23:52:57', '2018-05-11 23:52:57', '123', '0');

-- ----------------------------
-- Table structure for sys_log_0
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_0`;
CREATE TABLE `sys_log_0` (
  `id` bigint(64) NOT NULL COMMENT '编号',
  `type` char(1) DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) DEFAULT '' COMMENT '日志标题',
  `service_id` varchar(32) DEFAULT NULL COMMENT '服务ID',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remote_addr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(1000) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(10) DEFAULT NULL COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `time` mediumtext COMMENT '执行时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  `exception` text COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='日志表';

-- ----------------------------
-- Records of sys_log_0
-- ----------------------------
INSERT INTO `sys_log_0` VALUES ('1036815975231160322', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:19:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/79511536031161267', 'GET', '', '2920', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036815979702288386', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:19:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/98431536031165566', 'GET', '', '576', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036816094512971778', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:19:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '179', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036816146341986306', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:20:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '225', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036816147365396482', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:20:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '21', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036819049622437890', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:31:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '270', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036819191008231426', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:32:11', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/1', 'GET', '', '52', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036819210432053250', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:32:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/1', 'GET', '', '50', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036819629963116546', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:33:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '224', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036819638922149890', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:33:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '135', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036819648309002242', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:34:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '135', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036819682341584898', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:34:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '221', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820373470609410', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:36:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '222', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820376394039298', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:36:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820389387993090', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:36:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/2', 'GET', '', '113', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820396040159234', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:36:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/21', 'GET', '', '96', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820403313082370', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '219', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820456635269122', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/1', 'GET', '', '102', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820458224910338', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/1', 'GET', '', '49', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820472191942658', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/1', 'GET', '', '112', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820501187166210', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '187', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820521827336194', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:28', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '139', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820535463018498', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '112', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820655113928706', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '103', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820848454565890', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/', 'PUT', '', '538', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820849599610882', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '152', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820868088102914', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '93', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820876342493186', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '271', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820886043918338', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820961709162498', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '222', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036820972106842114', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '139', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821061579735042', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '93', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821070555545602', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/7', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821072346513410', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/7', 'GET', '', '49', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821090444935170', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:44', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821124540432386', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/', 'PUT', '', '373', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821129108029442', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/7', 'GET', '', '95', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821222250938370', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/8', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821223488258050', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/8', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821238252208130', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/9', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821281004748802', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:29', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/8', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821291154964482', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/8', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821348830838786', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/', 'PUT', '', '555', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821370767048706', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '134', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821393542119426', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/1', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821403499397122', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821437318070274', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/', 'PUT', '', '454', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821438345674754', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '130', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821490195660802', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/6', 'GET', '', '92', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821497149816834', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:21', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/4', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821504858947586', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/1', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821517957758978', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/1', 'DELETE', '', '252', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821519178301442', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '48', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821536651771906', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '223', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821630369300482', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '133', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821671783858178', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821725475143682', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '95', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821805288554498', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821814201450498', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '48', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821846560505858', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:44', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821851425898498', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '93', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821853875372034', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821888096698370', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/', 'POST', '', '287', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821889136885762', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '84', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821898666344450', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '94', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821922179612674', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821994208395266', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '219', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036821999942008834', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:20', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '97', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822023425916930', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/7', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822036252098562', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:29', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user', 'PUT', '', '509', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822050319794178', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822058838425602', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/10', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822067122176002', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '184', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822087619739650', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '220', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822107404271618', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '93', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822215504068610', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:44:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '224', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822293471985666', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:44:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822706107613186', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '141', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822711115612162', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '216', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822712155799554', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '11', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822725887950850', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822845597581314', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '92', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822851297640450', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822883048521730', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822939952644098', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/', 'POST', '', '252', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822941680697346', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '83', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036822949821841410', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823029513617410', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823059087654914', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823063068049410', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '135', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823119837954050', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/', 'PUT', '', '479', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823133108731906', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823147977539586', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '131', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823163567767554', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '218', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823173495685122', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823181724909570', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823208430043138', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823252851916802', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '134', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823268735746050', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823390370562050', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '92', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823414970155010', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/10', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823512730992642', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:21', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823569161158658', '0', '', 'pig-auth', 'admin', '2018-09-04 11:49:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1MzYwNzQzNzUsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiI4OGQ0NzNmMi1lYzZiLTQ4MzUtODA0Ni1kYmEwYTcyMzlkMmYiLCJjbGllbnRfaWQiOiJwaWcifQ.4BK2g8K-prrDoD_0v0CbaSuQGQfHs_XwtJsTVKNqiuo%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJhdGkiOiI4OGQ0NzNmMi1lYzZiLTQ4MzUtODA0Ni1kYmEwYTcyMzlkMmYiLCJleHAiOjE1Mzg2MjMxNzUsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiIzODkyMTZhZi0yNzg4LTRlODItYmQ5NS1iOTZjMWY2ZTU0MDkiLCJjbGllbnRfaWQiOiJwaWcifQ.Imdl1BUNdfLN_qv17V1NlSUsMXxS4tnbRKeJ_2p6070%5D', '328', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823570767577090', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:49:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/96901536032976821', 'GET', '', '20', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823621757730818', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '102', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823640447549442', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '175', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823648928432130', '9', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:54', '2018-09-04 11:50:39', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/null', 'GET', '', '11', '1', '{\"msg\":\"Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \\\"null\\\"\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_0` VALUES ('1036823677885906946', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823690338795522', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/roleTree/ROLE_DEMO', 'GET', '', '99', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823691420925954', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '96', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823742004232194', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823767929225218', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '23', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823769103630338', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '219', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823830730539010', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/1036823648928432130', 'DELETE', '', '153', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823984833462274', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823986704121858', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '46', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036823992832000002', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '92', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824008162181122', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824110926823426', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:44', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824320600080386', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '84', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824332738396162', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/', 'POST', '', '249', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824367337209858', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824368360620034', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '214', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824378066239490', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824414816731138', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '214', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824423079510018', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824443321221122', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:53:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '177', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824491501191170', '0', '', 'pig-auth', 'admin', '2018-09-04 11:53:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1MzYwNzYxODgsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiI2NmZiMTU0Yi01MmZkLTQ4ZjgtODcxZi1jZTQ5YzI2YzhlODUiLCJjbGllbnRfaWQiOiJwaWcifQ.PQnSvhjlGnYz8nXSdDfTleHVjO9ACoKz1PiYpaePbeM%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJhdGkiOiI2NmZiMTU0Yi01MmZkLTQ4ZjgtODcxZi1jZTQ5YzI2YzhlODUiLCJleHAiOjE1Mzg2MjQ5ODgsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiIzOTIxNDE3MC03YzllLTQ4YjItYjYxMC0wYzA1NTBlNjA5MzgiLCJjbGllbnRfaWQiOiJwaWcifQ.Jsx0vvA6DgySFdyw_XhtX87TmrYtINMzySIq3P2JO0s%5D', '17', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824492805619714', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:53:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/52651536033196713', 'GET', '', '14', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824535235198978', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:53:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B52651536033196713%5D&code=%5B56a4%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Bpig%5D', '766', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824537219104770', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:53:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '155', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824538355761154', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:53:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '8', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824595276660738', '0', '', 'pig-auth', 'pig', '2018-09-04 11:53:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJwaWciLCJzY29wZSI6WyJzZXJ2ZXIiXSwiZXhwIjoxNTM2MDc2NDA2LCJ1c2VySWQiOjIsImF1dGhvcml0aWVzIjpbIlJPTEVfREVWIiwiUk9MRV9VU0VSIl0sImp0aSI6IjUwYTE0YmY0LWUyZGMtNDcxZS04ODJhLWJjYWI2NjJmZGIwMCIsImNsaWVudF9pZCI6InBpZyJ9.qanzFdkayo0yJ2gCji66AubU_1EUzlTEpDreTxdxDZ8%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJwaWciLCJzY29wZSI6WyJzZXJ2ZXIiXSwiYXRpIjoiNTBhMTRiZjQtZTJkYy00NzFlLTg4MmEtYmNhYjY2MmZkYjAwIiwiZXhwIjoxNTM4NjI1MjA2LCJ1c2VySWQiOjIsImF1dGhvcml0aWVzIjpbIlJPTEVfREVWIiwiUk9MRV9VU0VSIl0sImp0aSI6ImJiNjlhN2M1LTUzOTctNDcxNS04NWVmLTVhMDExYjA5NTQ3YiIsImNsaWVudF9pZCI6InBpZyJ9.8gU8HPtwNgc_jh8GaiwH2GR_GZyhJg1GRkKQRv1iXv0%5D', '23', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824596484620290', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:53:39', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/55051536033221459', 'GET', '', '17', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824670115627010', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:53:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B66601536033232488%5D&code=%5B2npm%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '608', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824671873040386', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:53:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824690382503938', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:54:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824695415668738', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:54:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '218', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824750222639106', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:54:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824994419212290', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:55:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleMenuUpd', 'PUT', 'menuIds%5B%5D=%5B1%2C+2%2C+21%2C+22%2C+23%2C+3%2C+31%2C+32%2C+33%2C+4%2C+41%2C+42%2C+43%2C+45%2C+5%2C+51%2C+6%2C+61%2C+63%2C+64%2C+71%2C+72%2C+73%2C+100%2C+101%2C+102%2C+104%2C+111%2C+112%2C+113%5D&roleId=%5B15%5D', '1691', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036824995610394626', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:55:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825028892196866', '0', '', 'pig-auth', 'admin', '2018-09-04 11:55:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1MzYwNzY0MzksInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiI0MzVmYjExOS1kM2I3LTQ3NDQtYjc5OC01YTBmOTE3Y2UxYmIiLCJjbGllbnRfaWQiOiJwaWcifQ.X3XnoAPtl49DzISB5vBZPIwgSJSubhCArI4worfRodE%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJhdGkiOiI0MzVmYjExOS1kM2I3LTQ3NDQtYjc5OC01YTBmOTE3Y2UxYmIiLCJleHAiOjE1Mzg2MjUyMzksInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiIzYmZiNjNhZi04OWE2LTRiNjgtYTExZi03MWE2NzE5MTgwYmYiLCJjbGllbnRfaWQiOiJwaWcifQ.YDfY5HAvS6_LxrsR4l8Xc3V4NHFrT3gQ_FKi6R_T4_I%5D', '26', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825048366350338', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:55:27', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/74461536033329444', 'GET', '', '13', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825069933461506', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:55:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B74461536033329444%5D&code=%5Bxnc7%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Bpig%5D', '613', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825072626204674', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '7', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825086932975618', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825139428884482', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:49', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '130', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825153718878210', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '217', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825154771648514', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '8', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825160882749442', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '91', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825205883437058', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '94', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825207116562434', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '214', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825219934355458', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '102', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825222845202434', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '131', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825227337302018', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '6', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825233708449794', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:11', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/client/page', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '129', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825609983655938', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '83', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825680716398594', '0', '', 'pig-auth', 'pig', '2018-09-04 11:57:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJwaWciLCJzY29wZSI6WyJzZXJ2ZXIiXSwiZXhwIjoxNTM2MDc2NTM0LCJ1c2VySWQiOjIsImF1dGhvcml0aWVzIjpbIlJPTEVfREVWIiwiUk9MRV9VU0VSIl0sImp0aSI6IjA0NzI5OTUwLTI5NTktNDE1Ny1hOTAwLWU2NzMxMzkwZDY5YiIsImNsaWVudF9pZCI6InBpZyJ9.a2wPgVVNwFcW9q15p4kRtqSzRqh7xRrzH0sYrK7vpz4%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJwaWciLCJzY29wZSI6WyJzZXJ2ZXIiXSwiYXRpIjoiMDQ3Mjk5NTAtMjk1OS00MTU3LWE5MDAtZTY3MzEzOTBkNjliIiwiZXhwIjoxNTM4NjI1MzM0LCJ1c2VySWQiOjIsImF1dGhvcml0aWVzIjpbIlJPTEVfREVWIiwiUk9MRV9VU0VSIl0sImp0aSI6IjJkZDI3NGE5LWVlMzYtNDYzMi05MjQyLTk5YTJhNjQ4ZDU2YiIsImNsaWVudF9pZCI6InBpZyJ9.EQETYpSVvtu_Z8Pc68eQKuSKAl3M-oBOhikaR5BdBng%5D', '15', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825812530790402', '0', '', 'pig-auth', 'admin', '2018-09-04 11:58:29', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1MzYwNzY2OTUsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiI5YjU1ZDRjYS02MjYyLTQ5YzUtYTg2NC1mMWJjM2Q0NmFmYjQiLCJjbGllbnRfaWQiOiJwaWcifQ.c3xJVWwBQp798_BHoSq6JZuPXS5b48Zw1SBklw5jT6w%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJhdGkiOiI5YjU1ZDRjYS02MjYyLTQ5YzUtYTg2NC1mMWJjM2Q0NmFmYjQiLCJleHAiOjE1Mzg2MjU0OTQsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiI1Y2FjNGU1Yy1lMjEzLTRmMzYtOTUwOC1lOGIzZjVhMGJkYjIiLCJjbGllbnRfaWQiOiJwaWcifQ.f7mg0lqxU5VTGeRQ36vN8RHR5fzDC2bnZrTu2L5vKtU%5D', '48', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825841089806338', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:58:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/smsCode/15218725510', 'GET', '', '179', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036825939999883266', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:59:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B1234%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '2', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036826084531404802', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:59:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B9302%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '4', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036826402157658114', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 12:00:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B9302%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '2', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036826421073969154', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 12:00:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/smsCode/15218725510', 'GET', '', '120', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036826457480527874', '0', '', 'pig-upms-service', 'admin', '2018-09-04 12:01:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036826458516520962', '0', '', 'pig-upms-service', 'admin', '2018-09-04 12:01:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '10', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036833524421394434', '0', '', 'pig-upms-service', 'admin', '2018-09-04 12:29:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '208', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036858969183387650', '0', '', 'pig-auth', 'admin', '2018-09-04 14:10:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1MzYwNzY4NjQsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiI1YzM1NmM4Mi03ZDYxLTRjNGQtOTI2NS1kOTM1NWUwN2ZkYjUiLCJjbGllbnRfaWQiOiJwaWcifQ.8IH5GxVGD8conrGjjq0DVtK-1veTgKMVv-DKzpG4Z-w%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJhdGkiOiI1YzM1NmM4Mi03ZDYxLTRjNGQtOTI2NS1kOTM1NWUwN2ZkYjUiLCJleHAiOjE1Mzg2MjU2NjQsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiIyNTAzZjJmOC1mY2M0LTRiMmEtOTdkNS02ZjlmN2IwYzExNTYiLCJjbGllbnRfaWQiOiJwaWcifQ.5rmv2NTEObl_kdwDUK8DafW0z7hcOS6-5_OCX-VN_0Q%5D', '135', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036858970366181378', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:10:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/87811536041416850', 'GET', '', '104', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036864014381645826', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:30:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/68571536042619227', 'GET', '', '49', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036864119134388226', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:30:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/53531536042644435', 'GET', '', '73', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036867384643321858', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:43:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/56941536043422603', 'GET', '', '242', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036867929282084866', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:45:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/89111536043552876', 'GET', '', '52', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036868157569662978', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:46:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/64461536043607361', 'GET', '', '35', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036870087624785922', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 14:54:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B31421536044058933%5D&code=%5B3wwy%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '3713', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036870092410486786', '0', '', 'pig-upms-service', 'admin', '2018-09-04 14:54:27', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '343', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036879036935733250', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:29:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '414', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036879066195197954', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:30:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '1963', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036879069378674690', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:30:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '844', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036879113762799618', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:30:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '258', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896125905960962', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:37:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '429', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896131949953026', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:37:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '340', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896137943613442', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:37:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '129', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896140032376834', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:37:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '681', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896141328416770', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:37:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '242', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896184814960642', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '99', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896216171577346', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '160', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896217308233730', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '60', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896327408713730', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '140', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896334039908354', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '209', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896335176564738', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '54', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896336690708482', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:44', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '134', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896342206218242', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '178', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036896427832934402', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:39:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '9', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036897214294294530', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:42:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '232', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903252124925954', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 17:06:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/92461536051972565', 'GET', '', '735', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903276015681538', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:06:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '40', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903483314962434', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/9', 'GET', '', '109', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903531473960962', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/11', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903555083698178', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/11', 'GET', '', '96', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903592786296834', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/15', 'GET', '', '134', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903600185049090', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/15', 'GET', '', '96', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903681852342274', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '278', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903742388731906', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:08:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '96', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036903766132686850', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:08:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '20', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036914017632419842', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:48:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '59', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036914018827796482', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:48:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '43', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036956336377417730', '0', '', 'pig-upms-service', 'admin', '2018-09-04 20:37:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '242', '0', null);
INSERT INTO `sys_log_0` VALUES ('1036956353540509698', '0', '', 'pig-upms-service', 'admin', '2018-09-04 20:37:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/menu/allTree', 'GET', '', '117', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037656085019418626', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-06 18:57:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/50711536231453828', 'GET', '', '7978', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037657770567589890', '0', '', 'pig-auth', 'anonymousUser', '2018-09-06 19:04:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B7744%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '254', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037657802456883202', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-06 19:04:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/smsCode/15218725510', 'GET', '', '110', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037657885592182786', '0', '', 'pig-auth', 'anonymousUser', '2018-09-06 19:04:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B6410%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '5026', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037657892948992002', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:04:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '398', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037658536351031298', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:07:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '601', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037658557024755714', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:07:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '113', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037661438842953730', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:18:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '253', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037661475165626370', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '97', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037661502575403010', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '109', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037661514520780802', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '105', '0', null);
INSERT INTO `sys_log_0` VALUES ('1037661774861230082', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:20:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '130', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039427133331091458', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:15:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/78381536653697786', 'GET', '', '13653', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039427140432048130', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:15:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/61301536653716489', 'GET', '', '57', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039427666682982402', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:17:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/13171536653841682', 'GET', '', '20', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039427669409280002', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:17:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/59981536653842313', 'GET', '', '19', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039427801475330050', '0', '', 'pig-upms-service', 'admin', '2018-09-11 16:17:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '303', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039427925064691714', '0', '', 'pig-auth', 'admin', '2018-09-11 16:18:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1MzY2OTcwNzIsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiI0NDU5MjgwMy0xYWM4LTQ1NTYtOTg0Ny0xNmNmNzNiNTcwOGIiLCJjbGllbnRfaWQiOiJwaWcifQ.YZIFjQE3b9fxr2t3b3-MPRdhbihby0UhQQLLbMHy7K4%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJhdGkiOiI0NDU5MjgwMy0xYWM4LTQ1NTYtOTg0Ny0xNmNmNzNiNTcwOGIiLCJleHAiOjE1MzkyNDU4NzIsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiIzMmFkOGNjNC0wOWQ2LTQ4NjUtODhlZS02YWM3MmM2OWNkNjkiLCJjbGllbnRfaWQiOiJwaWcifQ.Lk906MSZTumwmvSmcYNeCZeL-mOFfEUTQi1uP18xajg%5D', '128', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039427926381703170', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:18:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/55561536653903653', 'GET', '', '19', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039429049482096642', '0', '', 'pig-auth', 'anonymousUser', '2018-09-11 16:23:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B0793%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '26', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039429182877741058', '0', '', 'pig-auth', 'anonymousUser', '2018-09-11 16:23:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B0246%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '2', '0', null);
INSERT INTO `sys_log_0` VALUES ('1039429183926317058', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:23:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/smsCode/15218725510', 'GET', '', '3789', '0', null);

-- ----------------------------
-- Table structure for sys_log_1
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_1`;
CREATE TABLE `sys_log_1` (
  `id` bigint(64) NOT NULL COMMENT '编号',
  `type` char(1) DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) DEFAULT '' COMMENT '日志标题',
  `service_id` varchar(32) DEFAULT NULL COMMENT '服务ID',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remote_addr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(1000) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(10) DEFAULT NULL COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `time` mediumtext COMMENT '执行时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  `exception` text COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='日志表';

-- ----------------------------
-- Records of sys_log_1
-- ----------------------------
INSERT INTO `sys_log_1` VALUES ('1036815984714481665', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:19:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/38251536031168159', 'GET', '', '34', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816014129135617', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:19:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B38251536031168159%5D&code=%5Byb8f%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '2417', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816017274863617', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:19:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '412', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816021896986625', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:19:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '962', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816058790084609', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:19:44', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '537', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816072354463745', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:19:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '158', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816093430841345', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:19:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '379', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816112221323265', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:19:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/route/page', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '140', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816120425381889', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:19:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/client/page', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '140', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036816127014633473', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:20:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '162', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036819167004229633', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:32:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/4', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036819168262520833', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:32:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/1', 'GET', '', '119', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036819189376647169', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:32:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/1', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036819208817246209', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:32:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/4', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036819511042015233', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:33:27', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/route/page', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '137', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036819548564258817', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:33:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/route/apply', 'GET', '', '97', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036819628734185473', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:33:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '11', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036819644940976129', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:33:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '155', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820356986994689', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:36:49', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '135', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820366797471745', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:36:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '107', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820426394337281', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '92', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820427489050625', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/1', 'GET', '', '113', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820473840304129', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/1', 'GET', '', '50', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820499039682561', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:37:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user', 'PUT', '', '823', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820713960013825', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820887679696897', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/1', 'GET', '', '50', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820901550260225', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '237', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820902573670401', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:38:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '10', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820908189843457', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '136', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820925898194945', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/1', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820980470284289', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '117', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036820996190535681', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:21', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '111', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821002104504321', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821060543741953', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/', 'PUT', '', '421', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821089165672449', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821125563842561', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821130311794689', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:39:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/7', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821217502986241', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/', 'PUT', '', '425', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821218543173633', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821237203632129', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/9', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821244568829953', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:20', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/9', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821259114676225', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/9', 'DELETE', '', '214', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821260138086401', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821262642085889', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/8', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821285471682561', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/8', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821349845860353', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:40:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821421199360001', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821472508280833', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821482117431297', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/1', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821485170884609', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/1', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821493307834369', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:20', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/5', 'GET', '', '48', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821501650305025', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/3', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821507400695809', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/1', 'GET', '', '48', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821578708058113', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:40', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821580947816449', '9', '', 'pig-upms-service', 'admin', '2018-09-04 11:41:40', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/null', 'GET', '', '125', '0', '{\"msg\":\"Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \\\"null\\\"\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_1` VALUES ('1036821679841116161', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821759126044673', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821763211296769', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821787588591617', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821791665455105', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821800238612481', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821811189940225', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821909835776001', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:42:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821938604507137', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '221', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821942899474433', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '132', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821953741750273', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821963912937473', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821976130945025', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/', 'PUT', '', '479', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036821977955467265', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '100', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822001418403841', '9', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:21', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/null', 'GET', '', '10', '0', '{\"msg\":\"Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \\\"null\\\"\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_1` VALUES ('1036822004962590721', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822038508634113', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '191', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822045181771777', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/1', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822046582669313', '9', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/null', 'GET', '', '8', '0', '{\"msg\":\"Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \\\"null\\\"\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_1` VALUES ('1036822064928555009', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user', 'PUT', '', '496', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822119324483585', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:49', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/2', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822123929829377', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/21', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822129294344193', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/2', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822132377157633', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:43:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '177', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822296915509249', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:44:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '94', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822690920038401', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822697484124161', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822714315866113', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:11', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '134', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822718233346049', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036822898210930689', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:46:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823001508249601', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '143', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823032210554881', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:27', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '221', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823092314931201', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '111', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823101424959489', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823121029136385', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:48', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '91', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823128067178497', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:49', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/1', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823146853466113', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:47:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/', 'PUT', '', '454', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823174514900993', '9', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/null', 'GET', '', '9', '0', '{\"msg\":\"Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \\\"null\\\"\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_1` VALUES ('1036823221927313409', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823396586520577', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '224', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823413296627713', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:48:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/1', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823426420604929', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:00', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '99', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823427934748673', '9', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/null', 'GET', '', '12', '0', '{\"msg\":\"Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \\\"null\\\"\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_1` VALUES ('1036823466723672065', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/1', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823468296536065', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/10', 'GET', '', '46', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823495865696257', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '133', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823531685052417', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/1', 'GET', '', '92', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823598651310081', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:49:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B96901536032976821%5D&code=%5Bgead%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '83', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823599825715201', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:49:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/54971536032983833', 'GET', '', '15', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823620663017473', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:49:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B54971536032983833%5D&code=%5Bpd2e%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '760', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823622781140993', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '10', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823636853030913', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823647456231425', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823658218815489', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823663465889793', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:49:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '130', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823704117084161', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/1', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823720038662145', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823831896555521', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '175', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823867061600257', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:46', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '132', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823874749759489', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:47', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '91', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823895679336449', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '217', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823908987863041', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823910447480833', '9', '', 'pig-upms-service', 'admin', '2018-09-04 11:50:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/null', 'GET', '', '12', '0', '{\"msg\":\"Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \\\"null\\\"\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_1` VALUES ('1036823942642958337', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823950154956801', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/10', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823958484844545', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823966122672129', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036823977485041665', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824002504065025', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824014336196609', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:21', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824020396965889', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/2', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824050998607873', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:29', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '132', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824105214181377', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824160025346049', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:51:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '133', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824316472885249', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '92', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824333984104449', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:37', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '149', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824379228061697', '9', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:48', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/null', 'GET', '', '10', '0', '{\"msg\":\"Failed to convert value of type \'java.lang.String\' to required type \'java.lang.Integer\'; nested exception is java.lang.NumberFormatException: For input string: \\\"null\\\"\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_1` VALUES ('1036824385171390465', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:49', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '89', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824392096186369', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:51', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824413759766529', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:56', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user', 'PUT', '', '597', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824424102920193', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:52:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '84', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824434999721985', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:53:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '132', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824441177931777', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:53:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824641573388289', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:53:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B55051536033221459%5D&code=%5B8sm7%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '4', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824642777153537', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:53:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/66601536033232488', 'GET', '', '15', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824672896450561', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:53:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '8', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824699949711361', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:54:04', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '159', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824748842713089', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:54:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/roleTree/ROLE_DEV', 'GET', '', '6', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036824996629610497', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:55:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/roleTree/ROLE_DEV', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825005160824833', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:55:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '248', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825030070796289', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:55:23', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/59501536033324836', 'GET', '', '14', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825071460188161', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '51', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825095640350721', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:38', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '218', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825136077635585', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:48', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825158131286017', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:55:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '175', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825226301308929', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '178', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825229837107201', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '90', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825428290600961', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/client/page', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '135', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825435412529153', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:56:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '216', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825440949010433', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '87', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825444736466945', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '130', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825447844446209', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:02', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '7', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825448968519681', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '276', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825451212472321', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '93', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825463849910273', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825484980813825', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:11', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/15', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825564181856257', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '223', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825575422590977', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825576450195457', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825608926691329', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:41', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '100', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825643848466433', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:49', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '88', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825645438107649', '0', '', 'pig-upms-service', 'pig', '2018-09-04 11:57:50', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825682306039809', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:57:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/87251536033480253', 'GET', '', '16', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825743224111105', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:58:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B87251536033480253%5D&code=%5B5ww4%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '622', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825744411099137', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:58:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825745442897921', '0', '', 'pig-upms-service', 'admin', '2018-09-04 11:58:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '8', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036825813713584129', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 11:58:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/55931536033511672', 'GET', '', '18', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036826039883038721', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:59:24', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B9302%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '2', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036826116005462017', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 11:59:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B9302%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '1', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036826456280956929', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 12:01:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/mobile/token', 'POST', 'mobile=%5B15218725510%5D&code=%5B6982%5D&grant_type=%5Bmobile%5D&scope=%5Bserver%5D', '670', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036833525721628673', '0', '', 'pig-upms-service', 'admin', '2018-09-04 12:29:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '99', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036833620735197185', '0', '', 'pig-upms-service', 'admin', '2018-09-04 12:29:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B17%5D&isAsc=%5Bfalse%5D', '421', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036858921238298625', '0', '', 'pig-upms-service', 'admin', '2018-09-04 14:10:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '211', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036858922509172737', '0', '', 'pig-upms-service', 'admin', '2018-09-04 14:10:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '451', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036866525222043649', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:40:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/51411536043217481', 'GET', '', '525', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036867536242245633', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:44:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/89181536043458450', 'GET', '', '104', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036867593842622465', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:44:31', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/55651536043472887', 'GET', '', '47', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036867601539170305', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:44:33', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/97121536043474677', 'GET', '', '106', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036867761275043841', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:45:11', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/34701536043512682', 'GET', '', '107', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036867860671660033', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:45:34', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/66321536043536550', 'GET', '', '90', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036867938790572033', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:45:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/57391536043555182', 'GET', '', '75', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036868146576392193', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:46:43', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/28211536043604688', 'GET', '', '62', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036868151051714561', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:46:44', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/20091536043605789', 'GET', '', '55', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036870050199011329', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 14:54:16', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B64461536043607361%5D&code=%5B268e%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '257', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036870051495051265', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 14:54:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/31421536044058933', 'GET', '', '48', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036870089113763841', '0', '', 'pig-upms-service', 'admin', '2018-09-04 14:54:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '279', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036879038659592193', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:29:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '888', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036879046981091329', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:30:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '204', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036879067398963201', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:30:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '2064', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036879070892818433', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:30:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '1221', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036879082464903169', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:30:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '203', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036879112030552065', '0', '', 'pig-upms-service', 'admin', '2018-09-04 15:30:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '129', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896130142208001', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:37:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/2', 'GET', '', '111', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896142494433281', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:37:57', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '112', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896144490921985', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:37:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/role/roleList/11', 'GET', '', '150', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896179433668609', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '132', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896183615389697', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '377', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896190020091905', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '213', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896203672551425', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '186', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896232126709761', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/21', 'GET', '', '119', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896239080865793', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:20', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/2', 'GET', '', '79', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896260018831361', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:25', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/24', 'GET', '', '107', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896277383249921', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:30', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/2', 'GET', '', '212', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896304109355009', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:38:36', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/1', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896426633363457', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:39:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dict/dictPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '140', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036896589716291585', '0', '', 'pig-upms-service', 'admin', '2018-09-04 16:39:44', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/client/page', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '352', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036897447338213377', '0', '', 'pig-auth', 'admin', '2018-09-04 16:43:08', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/authentication/removeToken', 'POST', 'accesstoken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1MzYwODcyNjcsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiJiMWMwY2U5NC04NDE1LTQ0YTktYTFlYi0wMjRhYjJmZDdiMjgiLCJjbGllbnRfaWQiOiJwaWcifQ.CT9WTDM7iE6HOLA6JFHfc0-DR_MjDE5xfbf07XqjcZ8%5D&refreshToken=%5BeyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInNlcnZlciJdLCJhdGkiOiJiMWMwY2U5NC04NDE1LTQ0YTktYTFlYi0wMjRhYjJmZDdiMjgiLCJleHAiOjE1Mzg2MzYwNjcsInVzZXJJZCI6MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9BRE1JTiIsIlJPTEVfVVNFUiJdLCJqdGkiOiI0ODIyNDBhOC03NDE5LTQwYWItOTA5NS0zOTk1MDRmNzBlNDAiLCJjbGllbnRfaWQiOiJwaWcifQ.Lot8jFfLPqbok-iuN2PpNzxSJmSuikFRwyg7S8uxY3g%5D', '150', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036897452191023105', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 16:43:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/85131536050590745', 'GET', '', '441', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036898313067724801', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 16:46:35', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/25581536050796986', 'GET', '', '48', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903249230856193', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 17:06:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/80121536051973063', 'GET', '', '136', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903272270168065', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 17:06:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B80121536051973063%5D&code=%5B27dp%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '1356', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903273973055489', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:06:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '263', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903465904406529', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/allTree', 'GET', '', '106', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903523332816897', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:17', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/10', 'GET', '', '85', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903561622618113', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:26', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/13', 'GET', '', '97', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903570422267905', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:07:28', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/14', 'GET', '', '231', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903715855564801', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:08:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '9', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036903762672386049', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:08:14', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/menu/userMenu', 'GET', '', '123', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036913807191605249', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:48:09', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '834', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036914011068334081', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:48:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '146', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036914014511857665', '0', '', 'pig-upms-service', 'admin', '2018-09-04 17:48:58', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '99', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036956239837122561', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-04 20:36:45', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/code/48741536064606898', 'GET', '', '693', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036956332648681473', '0', '', 'pig-auth', 'anonymousUser', '2018-09-04 20:37:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B48741536064606898%5D&code=%5B3eb2%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '1547', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036956334414483457', '0', '', 'pig-upms-service', 'admin', '2018-09-04 20:37:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/user/info', 'GET', '', '245', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036956345588109313', '0', '', 'pig-upms-service', 'admin', '2018-09-04 20:37:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '352', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036956360406585345', '0', '', 'pig-upms-service', 'admin', '2018-09-04 20:37:13', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/role/rolePage', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '196', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036956383018078209', '0', '', 'pig-upms-service', 'admin', '2018-09-04 20:37:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/log/logPage', 'GET', 'orderByField=%5Bcreate_time%5D&limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '331', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036956385694044161', '0', '', 'pig-upms-service', 'admin', '2018-09-04 20:37:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/dict/type/log_type', 'GET', '', '530', '0', null);
INSERT INTO `sys_log_1` VALUES ('1036956398302121985', '0', '', 'pig-upms-service', 'admin', '2018-09-04 20:37:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', '/admin/menu/allTree', 'GET', '', '114', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037656133744648193', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-06 18:57:53', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/smsCode/15218725510', 'GET', '', '250', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037657888674996225', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:04:52', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '170', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037658723358269441', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:08:11', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/route/page', 'GET', 'limit=%5B20%5D&page=%5B1%5D', '330', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037659726195384321', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:12:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '243', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037660111530287105', '9', '', 'pig-upms-service', 'admin', '2018-09-06 19:13:42', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/upload', 'POST', '', '1389', '0', '{\"msg\":\"无法获取服务端连接资源：can\'t create connection to/127.0.0.1:22122\",\"code\":1,\"data\":null}');
INSERT INTO `sys_log_1` VALUES ('1037661396195270657', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:18:48', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '256', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661442957565953', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:18:59', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/tree', 'GET', '', '105', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661451522334721', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:01', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '195', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661457583104001', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '104', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661460011606017', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '108', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661467888508929', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:05', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '102', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661470996488193', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:06', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '57', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661477678014465', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:07', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '65', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661487433965569', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '124', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661488545456129', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:10', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '126', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661494945964033', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '158', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661497504489473', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/2', 'GET', '', '86', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661510745907201', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:15', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '97', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661521080672257', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:19:18', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/10', 'GET', '', '122', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661779424632833', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:20:19', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/dept/11', 'GET', '', '94', '0', null);
INSERT INTO `sys_log_1` VALUES ('1037661788937314305', '0', '', 'pig-upms-service', 'admin', '2018-09-06 19:20:22', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '236', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039427201064906753', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:15:32', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/95781536653730657', 'GET', '', '40', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039427437690761217', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:16:29', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/smsCode/15218725510', 'GET', '', '783', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039427681325297665', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:17:27', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/79891536653845386', 'GET', '', '22', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039427738283945985', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:17:40', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/code/50001536653858744', 'GET', '', '41', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039427796018540545', '0', '', 'pig-auth', 'anonymousUser', '2018-09-11 16:17:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/auth/oauth/token', 'POST', 'password=%5BlBTqrKS0kZixOFXeZ0HRng%3D%3D%5D&randomStr=%5B50001536653858744%5D&code=%5Bbyen%5D&grant_type=%5Bpassword%5D&scope=%5Bserver%5D&username=%5Badmin%5D', '1888', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039427797322969089', '0', '', 'pig-upms-service', 'admin', '2018-09-11 16:17:54', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/info', 'GET', '', '278', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039427834841018369', '0', '', 'pig-upms-service', 'admin', '2018-09-11 16:18:03', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/user/userPage', 'GET', 'limit=%5B20%5D&page=%5B1%5D&isAsc=%5Bfalse%5D', '391', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039428121525891073', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:19:12', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/smsCode/15218725510', 'GET', '', '99', '0', null);
INSERT INTO `sys_log_1` VALUES ('1039428764667883521', '0', '', 'pig-upms-service', 'anonymousUser', '2018-09-11 16:21:55', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '/admin/smsCode/15218725510', 'GET', '', '20098', '0', null);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` int(11) NOT NULL COMMENT '菜单ID',
  `name` varchar(32) NOT NULL COMMENT '菜单名称',
  `permission` varchar(32) DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) DEFAULT NULL COMMENT '前端URL',
  `url` varchar(128) DEFAULT NULL COMMENT '请求链接',
  `method` varchar(32) DEFAULT NULL COMMENT '请求方法',
  `parent_id` int(11) DEFAULT NULL COMMENT '父菜单ID',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `component` varchar(64) DEFAULT NULL COMMENT 'VUE页面',
  `sort` int(11) DEFAULT '1' COMMENT '排序值',
  `type` char(1) DEFAULT NULL COMMENT '菜单类型 （0菜单 1按钮）',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '0--正常 1--删除',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', null, '/admin', null, null, '-1', 'icon-xitongguanli', 'Layout', '1', '0', '2017-11-07 20:56:00', '2018-05-14 21:53:22', '0');
INSERT INTO `sys_menu` VALUES ('2', '用户管理', null, 'user', '', null, '1', 'icon-yonghuguanli', 'views/admin/user/index', '2', '0', '2017-11-02 22:24:37', '2018-05-14 22:11:35', '0');
INSERT INTO `sys_menu` VALUES ('3', '菜单管理', null, 'menu', '', null, '1', 'icon-caidanguanli', 'views/admin/menu/index', '3', '0', '2017-11-08 09:57:27', '2018-05-14 22:11:21', '0');
INSERT INTO `sys_menu` VALUES ('4', '角色管理', null, 'role', null, null, '1', 'icon-jiaoseguanli', 'views/admin/role/index', '4', '0', '2017-11-08 10:13:37', '2018-05-14 22:11:19', '0');
INSERT INTO `sys_menu` VALUES ('5', '日志管理', null, 'log', null, null, '1', 'icon-rizhiguanli', 'views/admin/log/index', '5', '0', '2017-11-20 14:06:22', '2018-05-14 22:11:18', '0');
INSERT INTO `sys_menu` VALUES ('6', '字典管理', null, 'dict', null, null, '1', 'icon-zygl', 'views/admin/dict/index', '6', '0', '2017-11-29 11:30:52', '2018-05-14 22:12:48', '0');
INSERT INTO `sys_menu` VALUES ('7', '部门管理', null, 'dept', null, null, '1', 'icon-iconbmgl', 'views/admin/dept/index', '7', '0', '2018-01-20 13:17:19', '2018-05-14 22:11:16', '0');
INSERT INTO `sys_menu` VALUES ('8', '系统监控', null, '', null, null, '-1', 'icon-iconbmgl', null, '8', '0', '2018-01-22 12:30:41', '2018-05-14 20:41:16', '0');
INSERT INTO `sys_menu` VALUES ('9', '服务监控', null, 'http://139.224.200.249:5001', null, null, '8', 'icon-jiankong', null, '9', '0', '2018-01-23 10:53:33', '2018-04-21 03:51:56', '0');
INSERT INTO `sys_menu` VALUES ('10', 'zipkin监控', null, 'http://139.224.200.249:5002', null, null, '8', 'icon-jiankong', null, '11', '0', '2018-01-23 10:55:18', '2018-04-22 07:02:34', '0');
INSERT INTO `sys_menu` VALUES ('11', 'pinpoint监控', null, 'https://pinpoint.pig4cloud.com', null, null, '8', 'icon-xiazaihuancun', null, '10', '0', '2018-01-25 11:08:52', '2018-04-22 07:02:38', '0');
INSERT INTO `sys_menu` VALUES ('12', '缓存状态', null, 'http://139.224.200.249:8585', null, null, '8', 'icon-ecs-status', null, '12', '0', '2018-01-23 10:56:11', '2018-04-21 03:51:47', '0');
INSERT INTO `sys_menu` VALUES ('13', 'ELK状态', null, 'http://139.224.200.249:5601', null, null, '8', 'icon-ecs-status', null, '13', '0', '2018-01-23 10:55:47', '2018-04-21 03:51:40', '0');
INSERT INTO `sys_menu` VALUES ('14', '接口文档', null, 'http://139.224.200.249:9999/swagger-ui.html', null, null, '8', 'icon-wendangdocument72', null, '14', '0', '2018-01-23 10:56:43', '2018-04-21 03:50:47', '0');
INSERT INTO `sys_menu` VALUES ('15', '任务监控', null, 'http://139.224.200.249:8899', null, null, '8', 'icon-jiankong', null, '15', '0', '2018-01-23 10:55:18', '2018-04-21 03:51:34', '0');
INSERT INTO `sys_menu` VALUES ('21', '用户查看', '', null, '/admin/user/**', 'GET', '2', null, null, null, '1', '2017-11-07 20:58:05', '2018-02-04 14:28:49', '0');
INSERT INTO `sys_menu` VALUES ('22', '用户新增', 'sys_user_add', null, '/admin/user/*', 'POST', '2', null, null, null, '1', '2017-11-08 09:52:09', '2017-12-04 16:31:10', '0');
INSERT INTO `sys_menu` VALUES ('23', '用户修改', 'sys_user_upd', null, '/admin/user/**', 'PUT', '2', null, null, null, '1', '2017-11-08 09:52:48', '2018-01-17 17:40:01', '0');
INSERT INTO `sys_menu` VALUES ('24', '用户删除', 'sys_user_del', null, '/admin/user/*', 'DELETE', '2', null, null, null, '1', '2017-11-08 09:54:01', '2017-12-04 16:31:18', '0');
INSERT INTO `sys_menu` VALUES ('31', '菜单查看', null, null, '/admin/menu/**', 'GET', '3', null, null, null, '1', '2017-11-08 09:57:56', '2017-11-14 17:29:17', '0');
INSERT INTO `sys_menu` VALUES ('32', '菜单新增', 'sys_menu_add', null, '/admin/menu/*', 'POST', '3', null, null, null, '1', '2017-11-08 10:15:53', '2018-01-20 14:37:50', '0');
INSERT INTO `sys_menu` VALUES ('33', '菜单修改', 'sys_menu_edit', null, '/admin/menu/*', 'PUT', '3', null, null, null, '1', '2017-11-08 10:16:23', '2018-01-20 14:37:56', '0');
INSERT INTO `sys_menu` VALUES ('34', '菜单删除', 'sys_menu_del', null, '/admin/menu/*', 'DELETE', '3', null, null, null, '1', '2017-11-08 10:16:43', '2018-01-20 14:38:03', '0');
INSERT INTO `sys_menu` VALUES ('41', '角色查看', null, null, '/admin/role/**', 'GET', '4', null, null, null, '1', '2017-11-08 10:14:01', '2018-02-04 13:55:06', '0');
INSERT INTO `sys_menu` VALUES ('42', '角色新增', 'sys_role_add', null, '/admin/role/*', 'POST', '4', null, null, null, '1', '2017-11-08 10:14:18', '2018-04-20 07:21:38', '0');
INSERT INTO `sys_menu` VALUES ('43', '角色修改', 'sys_role_edit', null, '/admin/role/*', 'PUT', '4', null, null, null, '1', '2017-11-08 10:14:41', '2018-04-20 07:21:50', '0');
INSERT INTO `sys_menu` VALUES ('44', '角色删除', 'sys_role_del', null, '/admin/role/*', 'DELETE', '4', null, null, null, '1', '2017-11-08 10:14:59', '2018-04-20 07:22:00', '0');
INSERT INTO `sys_menu` VALUES ('45', '分配权限', 'sys_role_perm', null, '/admin/role/*', 'PUT', '4', null, null, null, '1', '2018-04-20 07:22:55', '2018-04-20 07:24:40', '0');
INSERT INTO `sys_menu` VALUES ('51', '日志查看', null, null, '/admin/log/**', 'GET', '5', null, null, null, '1', '2017-11-20 14:07:25', '2018-02-04 14:28:53', '0');
INSERT INTO `sys_menu` VALUES ('52', '日志删除', 'sys_log_del', null, '/admin/log/*', 'DELETE', '5', null, null, null, '1', '2017-11-20 20:37:37', '2017-11-28 17:36:52', '0');
INSERT INTO `sys_menu` VALUES ('61', '字典查看', null, null, '/admin/dict/**', 'GET', '6', null, null, null, '1', '2017-11-19 22:04:24', '2017-11-29 11:31:24', '0');
INSERT INTO `sys_menu` VALUES ('62', '字典删除', 'sys_dict_del', null, '/admin/dict/**', 'DELETE', '6', null, null, null, '1', '2017-11-29 11:30:11', '2018-01-07 15:40:51', '0');
INSERT INTO `sys_menu` VALUES ('63', '字典新增', 'sys_dict_add', null, '/admin/dict/**', 'POST', '6', null, null, null, '1', '2018-05-11 22:34:55', null, '0');
INSERT INTO `sys_menu` VALUES ('64', '字典修改', 'sys_dict_upd', null, '/admin/dict/**', 'PUT', '6', null, null, null, '1', '2018-05-11 22:36:03', null, '0');
INSERT INTO `sys_menu` VALUES ('71', '部门查看', '', null, '/admin/dept/**', 'GET', '7', null, '', null, '1', '2018-01-20 13:17:19', '2018-01-20 14:55:24', '0');
INSERT INTO `sys_menu` VALUES ('72', '部门新增', 'sys_dept_add', null, '/admin/dept/**', 'POST', '7', null, null, null, '1', '2018-01-20 14:56:16', '2018-01-20 21:17:57', '0');
INSERT INTO `sys_menu` VALUES ('73', '部门修改', 'sys_dept_edit', null, '/admin/dept/**', 'PUT', '7', null, null, null, '1', '2018-01-20 14:56:59', '2018-01-20 21:17:59', '0');
INSERT INTO `sys_menu` VALUES ('74', '部门删除', 'sys_dept_del', null, '/admin/dept/**', 'DELETE', '7', null, null, null, '1', '2018-01-20 14:57:28', '2018-01-20 21:18:05', '0');
INSERT INTO `sys_menu` VALUES ('100', '客户端管理', '', 'client', '', '', '1', 'icon-bangzhushouji', 'views/admin/client/index', '9', '0', '2018-01-20 13:17:19', '2018-05-15 21:28:10', '0');
INSERT INTO `sys_menu` VALUES ('101', '客户端新增', 'sys_client_add', null, '/admin/client/**', 'POST', '100', '1', null, null, '1', '2018-05-15 21:35:18', '2018-05-16 10:35:26', '0');
INSERT INTO `sys_menu` VALUES ('102', '客户端修改', 'sys_client_upd', null, '/admin/client/**', 'PUT', '100', null, null, null, '1', '2018-05-15 21:37:06', '2018-05-15 21:52:30', '0');
INSERT INTO `sys_menu` VALUES ('103', '客户端删除', 'sys_client_del', null, '/admin/client/**', 'DELETE', '100', null, null, null, '1', '2018-05-15 21:39:16', '2018-05-15 21:52:34', '0');
INSERT INTO `sys_menu` VALUES ('104', '客户端查看', null, null, '/admin/client/**', 'GET', '100', null, null, null, '1', '2018-05-15 21:39:57', '2018-05-15 21:52:40', '0');
INSERT INTO `sys_menu` VALUES ('110', '路由管理', null, 'route', null, null, '1', 'icon-luyou', 'views/admin/route/index', '8', '0', '2018-05-15 21:44:51', '2018-05-16 06:58:20', '0');
INSERT INTO `sys_menu` VALUES ('111', '路由查看', null, null, '/admin/route/**', 'GET', '110', null, null, null, '1', '2018-05-15 21:45:59', '2018-05-16 07:23:04', '0');
INSERT INTO `sys_menu` VALUES ('112', '路由新增', 'sys_route_add', null, '/admin/route/**', 'POST', '110', null, null, null, '1', '2018-05-15 21:52:22', '2018-05-15 21:53:46', '0');
INSERT INTO `sys_menu` VALUES ('113', '路由修改', 'sys_route_upd', null, '/admin/route/**', 'PUT', '110', null, null, null, '1', '2018-05-15 21:55:38', null, '0');
INSERT INTO `sys_menu` VALUES ('114', '路由删除', 'sys_route_del', null, '/admin/route/**', 'DELETE', '110', null, null, null, '1', '2018-05-15 21:56:45', null, '0');

-- ----------------------------
-- Table structure for sys_oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `sys_oauth_client_details`;
CREATE TABLE `sys_oauth_client_details` (
  `client_id` varchar(40) NOT NULL,
  `resource_ids` varchar(256) DEFAULT NULL,
  `client_secret` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `authorized_grant_types` varchar(256) DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) DEFAULT NULL,
  `authorities` varchar(256) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `autoapprove` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_oauth_client_details
-- ----------------------------
INSERT INTO `sys_oauth_client_details` VALUES ('app', null, 'app', 'server', 'password,refresh_token', null, null, null, null, null, 'true');
INSERT INTO `sys_oauth_client_details` VALUES ('pig', null, 'pig', 'server', 'password,refresh_token,authorization_code', null, null, null, null, null, 'false');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `role_code` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `role_desc` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_idx1_role_code` (`role_code`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'admin', 'ROLE_ADMIN', '超级管理员', '2017-10-29 15:45:51', '2018-04-22 11:40:29', '0');
INSERT INTO `sys_role` VALUES ('2', 'test', 'ROLE_DEMO', '测试角色', '2018-04-20 07:14:32', '2018-09-04 11:34:49', '0');
INSERT INTO `sys_role` VALUES ('15', 'dev', 'ROLE_DEV', '开发角色', '2018-09-04 11:52:36', null, '0');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `role_id` int(20) DEFAULT NULL COMMENT '角色ID',
  `dept_id` int(20) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色与部门对应关系';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('18', '2', '2');
INSERT INTO `sys_role_dept` VALUES ('19', '1', '10');
INSERT INTO `sys_role_dept` VALUES ('20', '15', '11');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `menu_id` int(11) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '1');
INSERT INTO `sys_role_menu` VALUES ('1', '2');
INSERT INTO `sys_role_menu` VALUES ('1', '3');
INSERT INTO `sys_role_menu` VALUES ('1', '4');
INSERT INTO `sys_role_menu` VALUES ('1', '5');
INSERT INTO `sys_role_menu` VALUES ('1', '6');
INSERT INTO `sys_role_menu` VALUES ('1', '7');
INSERT INTO `sys_role_menu` VALUES ('1', '8');
INSERT INTO `sys_role_menu` VALUES ('1', '9');
INSERT INTO `sys_role_menu` VALUES ('1', '10');
INSERT INTO `sys_role_menu` VALUES ('1', '11');
INSERT INTO `sys_role_menu` VALUES ('1', '12');
INSERT INTO `sys_role_menu` VALUES ('1', '13');
INSERT INTO `sys_role_menu` VALUES ('1', '14');
INSERT INTO `sys_role_menu` VALUES ('1', '15');
INSERT INTO `sys_role_menu` VALUES ('1', '21');
INSERT INTO `sys_role_menu` VALUES ('1', '22');
INSERT INTO `sys_role_menu` VALUES ('1', '23');
INSERT INTO `sys_role_menu` VALUES ('1', '24');
INSERT INTO `sys_role_menu` VALUES ('1', '31');
INSERT INTO `sys_role_menu` VALUES ('1', '32');
INSERT INTO `sys_role_menu` VALUES ('1', '33');
INSERT INTO `sys_role_menu` VALUES ('1', '34');
INSERT INTO `sys_role_menu` VALUES ('1', '41');
INSERT INTO `sys_role_menu` VALUES ('1', '42');
INSERT INTO `sys_role_menu` VALUES ('1', '43');
INSERT INTO `sys_role_menu` VALUES ('1', '44');
INSERT INTO `sys_role_menu` VALUES ('1', '45');
INSERT INTO `sys_role_menu` VALUES ('1', '51');
INSERT INTO `sys_role_menu` VALUES ('1', '52');
INSERT INTO `sys_role_menu` VALUES ('1', '61');
INSERT INTO `sys_role_menu` VALUES ('1', '62');
INSERT INTO `sys_role_menu` VALUES ('1', '63');
INSERT INTO `sys_role_menu` VALUES ('1', '64');
INSERT INTO `sys_role_menu` VALUES ('1', '71');
INSERT INTO `sys_role_menu` VALUES ('1', '72');
INSERT INTO `sys_role_menu` VALUES ('1', '73');
INSERT INTO `sys_role_menu` VALUES ('1', '74');
INSERT INTO `sys_role_menu` VALUES ('1', '100');
INSERT INTO `sys_role_menu` VALUES ('1', '101');
INSERT INTO `sys_role_menu` VALUES ('1', '102');
INSERT INTO `sys_role_menu` VALUES ('1', '103');
INSERT INTO `sys_role_menu` VALUES ('1', '104');
INSERT INTO `sys_role_menu` VALUES ('1', '110');
INSERT INTO `sys_role_menu` VALUES ('1', '111');
INSERT INTO `sys_role_menu` VALUES ('1', '112');
INSERT INTO `sys_role_menu` VALUES ('1', '113');
INSERT INTO `sys_role_menu` VALUES ('1', '114');
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '3');
INSERT INTO `sys_role_menu` VALUES ('2', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '5');
INSERT INTO `sys_role_menu` VALUES ('2', '6');
INSERT INTO `sys_role_menu` VALUES ('2', '7');
INSERT INTO `sys_role_menu` VALUES ('2', '8');
INSERT INTO `sys_role_menu` VALUES ('2', '9');
INSERT INTO `sys_role_menu` VALUES ('2', '10');
INSERT INTO `sys_role_menu` VALUES ('2', '11');
INSERT INTO `sys_role_menu` VALUES ('2', '12');
INSERT INTO `sys_role_menu` VALUES ('2', '13');
INSERT INTO `sys_role_menu` VALUES ('2', '14');
INSERT INTO `sys_role_menu` VALUES ('2', '15');
INSERT INTO `sys_role_menu` VALUES ('2', '21');
INSERT INTO `sys_role_menu` VALUES ('2', '31');
INSERT INTO `sys_role_menu` VALUES ('2', '41');
INSERT INTO `sys_role_menu` VALUES ('2', '51');
INSERT INTO `sys_role_menu` VALUES ('2', '61');
INSERT INTO `sys_role_menu` VALUES ('2', '71');
INSERT INTO `sys_role_menu` VALUES ('15', '1');
INSERT INTO `sys_role_menu` VALUES ('15', '2');
INSERT INTO `sys_role_menu` VALUES ('15', '3');
INSERT INTO `sys_role_menu` VALUES ('15', '4');
INSERT INTO `sys_role_menu` VALUES ('15', '5');
INSERT INTO `sys_role_menu` VALUES ('15', '6');
INSERT INTO `sys_role_menu` VALUES ('15', '21');
INSERT INTO `sys_role_menu` VALUES ('15', '22');
INSERT INTO `sys_role_menu` VALUES ('15', '23');
INSERT INTO `sys_role_menu` VALUES ('15', '31');
INSERT INTO `sys_role_menu` VALUES ('15', '32');
INSERT INTO `sys_role_menu` VALUES ('15', '33');
INSERT INTO `sys_role_menu` VALUES ('15', '41');
INSERT INTO `sys_role_menu` VALUES ('15', '42');
INSERT INTO `sys_role_menu` VALUES ('15', '43');
INSERT INTO `sys_role_menu` VALUES ('15', '45');
INSERT INTO `sys_role_menu` VALUES ('15', '51');
INSERT INTO `sys_role_menu` VALUES ('15', '61');
INSERT INTO `sys_role_menu` VALUES ('15', '63');
INSERT INTO `sys_role_menu` VALUES ('15', '64');
INSERT INTO `sys_role_menu` VALUES ('15', '71');
INSERT INTO `sys_role_menu` VALUES ('15', '72');
INSERT INTO `sys_role_menu` VALUES ('15', '73');
INSERT INTO `sys_role_menu` VALUES ('15', '100');
INSERT INTO `sys_role_menu` VALUES ('15', '101');
INSERT INTO `sys_role_menu` VALUES ('15', '102');
INSERT INTO `sys_role_menu` VALUES ('15', '104');
INSERT INTO `sys_role_menu` VALUES ('15', '111');
INSERT INTO `sys_role_menu` VALUES ('15', '112');
INSERT INTO `sys_role_menu` VALUES ('15', '113');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `salt` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '随机盐',
  `phone` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '简介',
  `avatar` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像',
  `dept_id` int(11) DEFAULT NULL COMMENT '部门ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_idx1_username` (`username`),
  UNIQUE KEY `user_idx2_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '$2a$10$vg5QNHhCknAqevx9vM2s5esllJEzF/pa8VZXtFYHhhOhUcCw/GWyS', null, '15218725510', null, '10', '2018-04-20 07:15:18', '2018-09-04 11:43:38', '0');
INSERT INTO `sys_user` VALUES ('2', 'pig', '$2a$10$vg5QNHhCknAqevx9vM2s5esllJEzF/pa8VZXtFYHhhOhUcCw/GWyS', null, '17034642118', null, '11', '2018-04-22 11:39:07', '2018-09-04 11:52:58', '0');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '15');

-- ----------------------------
-- Table structure for sys_zuul_route
-- ----------------------------
DROP TABLE IF EXISTS `sys_zuul_route`;
CREATE TABLE `sys_zuul_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'router Id',
  `path` varchar(255) NOT NULL COMMENT '路由路径',
  `service_id` varchar(255) NOT NULL COMMENT '服务名称',
  `url` varchar(255) DEFAULT NULL COMMENT 'url代理',
  `strip_prefix` char(1) DEFAULT '1' COMMENT '转发去掉前缀',
  `retryable` char(1) DEFAULT '1' COMMENT '是否重试',
  `enabled` char(1) DEFAULT '1' COMMENT '是否启用',
  `sensitiveHeaders_list` varchar(255) DEFAULT NULL COMMENT '敏感请求头',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='动态路由配置表';

-- ----------------------------
-- Records of sys_zuul_route
-- ----------------------------
INSERT INTO `sys_zuul_route` VALUES ('1', 'test', 'test', 'tsest', '1', '1', '1', '0', '2018-05-16 07:28:43', '2018-05-16 07:35:08', '1');
INSERT INTO `sys_zuul_route` VALUES ('2', 'sdfg', 'we', 'jjj', '1', '1', '1', 'jj', '2018-05-16 07:35:43', '2018-05-17 13:56:14', '1');
INSERT INTO `sys_zuul_route` VALUES ('3', '/demo/**', 'pig-demo-service', '', '1', '1', '1', '', '2018-05-17 14:09:06', '2018-05-17 14:32:36', '0');
INSERT INTO `sys_zuul_route` VALUES ('4', '/admin/**', 'pig-upms-service', '', '1', '1', '1', '', '2018-05-21 11:40:38', null, '0');
INSERT INTO `sys_zuul_route` VALUES ('5', '/auth/**', 'pig-auth', '', '1', '1', '1', '', '2018-05-21 11:41:08', null, '0');

-- ----------------------------
-- Table structure for zipkin_annotations
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_annotations`;
CREATE TABLE `zipkin_annotations` (
  `trace_id_high` bigint(20) NOT NULL DEFAULT '0' COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(20) NOT NULL COMMENT 'coincides with zipkin_spans.trace_id',
  `span_id` bigint(20) NOT NULL COMMENT 'coincides with zipkin_spans.id',
  `a_key` varchar(255) NOT NULL COMMENT 'BinaryAnnotation.key or Annotation.value if type == -1',
  `a_value` blob COMMENT 'BinaryAnnotation.value(), which must be smaller than 64KB',
  `a_type` int(11) NOT NULL COMMENT 'BinaryAnnotation.type() or -1 if Annotation',
  `a_timestamp` bigint(20) DEFAULT NULL COMMENT 'Used to implement TTL; Annotation.timestamp or zipkin_spans.timestamp',
  `endpoint_ipv4` int(11) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_ipv6` binary(16) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null, or no IPv6 address',
  `endpoint_port` smallint(6) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_service_name` varchar(255) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  UNIQUE KEY `trace_id_high` (`trace_id_high`,`trace_id`,`span_id`,`a_key`,`a_timestamp`) COMMENT 'Ignore insert on duplicate',
  UNIQUE KEY `trace_id_high_4` (`trace_id_high`,`trace_id`,`span_id`,`a_key`,`a_timestamp`) COMMENT 'Ignore insert on duplicate',
  KEY `trace_id_high_2` (`trace_id_high`,`trace_id`,`span_id`) COMMENT 'for joining with zipkin_spans',
  KEY `trace_id_high_3` (`trace_id_high`,`trace_id`) COMMENT 'for getTraces/ByIds',
  KEY `endpoint_service_name` (`endpoint_service_name`) COMMENT 'for getTraces and getServiceNames',
  KEY `a_type` (`a_type`) COMMENT 'for getTraces',
  KEY `a_key` (`a_key`) COMMENT 'for getTraces',
  KEY `trace_id` (`trace_id`,`span_id`,`a_key`) COMMENT 'for dependencies job',
  KEY `trace_id_high_5` (`trace_id_high`,`trace_id`,`span_id`) COMMENT 'for joining with zipkin_spans',
  KEY `trace_id_high_6` (`trace_id_high`,`trace_id`) COMMENT 'for getTraces/ByIds',
  KEY `endpoint_service_name_2` (`endpoint_service_name`) COMMENT 'for getTraces and getServiceNames',
  KEY `a_type_2` (`a_type`) COMMENT 'for getTraces',
  KEY `a_key_2` (`a_key`) COMMENT 'for getTraces',
  KEY `trace_id_2` (`trace_id`,`span_id`,`a_key`) COMMENT 'for dependencies job'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED;

-- ----------------------------
-- Records of zipkin_annotations
-- ----------------------------

-- ----------------------------
-- Table structure for zipkin_dependencies
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_dependencies`;
CREATE TABLE `zipkin_dependencies` (
  `day` date NOT NULL,
  `parent` varchar(255) NOT NULL,
  `child` varchar(255) NOT NULL,
  `call_count` bigint(20) DEFAULT NULL,
  UNIQUE KEY `day` (`day`,`parent`,`child`),
  UNIQUE KEY `day_2` (`day`,`parent`,`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED;

-- ----------------------------
-- Records of zipkin_dependencies
-- ----------------------------

-- ----------------------------
-- Table structure for zipkin_spans
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_spans`;
CREATE TABLE `zipkin_spans` (
  `trace_id_high` bigint(20) NOT NULL DEFAULT '0' COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `debug` bit(1) DEFAULT NULL,
  `start_ts` bigint(20) DEFAULT NULL COMMENT 'Span.timestamp(): epoch micros used for endTs query and to implement TTL',
  `duration` bigint(20) DEFAULT NULL COMMENT 'Span.duration(): micros used for minDuration and maxDuration query',
  UNIQUE KEY `trace_id_high` (`trace_id_high`,`trace_id`,`id`) COMMENT 'ignore insert on duplicate',
  UNIQUE KEY `trace_id_high_4` (`trace_id_high`,`trace_id`,`id`) COMMENT 'ignore insert on duplicate',
  KEY `trace_id_high_2` (`trace_id_high`,`trace_id`,`id`) COMMENT 'for joining with zipkin_annotations',
  KEY `trace_id_high_3` (`trace_id_high`,`trace_id`) COMMENT 'for getTracesByIds',
  KEY `name` (`name`) COMMENT 'for getTraces and getSpanNames',
  KEY `start_ts` (`start_ts`) COMMENT 'for getTraces ordering and range',
  KEY `trace_id_high_5` (`trace_id_high`,`trace_id`,`id`) COMMENT 'for joining with zipkin_annotations',
  KEY `trace_id_high_6` (`trace_id_high`,`trace_id`) COMMENT 'for getTracesByIds',
  KEY `name_2` (`name`) COMMENT 'for getTraces and getSpanNames',
  KEY `start_ts_2` (`start_ts`) COMMENT 'for getTraces ordering and range'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED;

-- ----------------------------
-- Records of zipkin_spans
-- ----------------------------
