/*
Navicat MySQL Data Transfer

Source Server         : test@jiyue
Source Server Version : 50718
Source Host           : rm-2ze1oz4pi4woc067syo.mysql.rds.aliyuncs.com:3306
Source Database       : miu

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-10-16 15:11:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TITLE` varchar(50) NOT NULL COMMENT '活动名称',
  `ENROLL_START_TIME` datetime DEFAULT NULL COMMENT '报名开始时间',
  `ENROLL_END_TIME` datetime DEFAULT NULL COMMENT '报名结束时间',
  `ACTIVITY_START_TIME` datetime DEFAULT NULL COMMENT '活动开始时间',
  `ACTIVITY_END_TIME` datetime DEFAULT NULL COMMENT '活动结束时间',
  `ACTIVITY_COVER` varchar(256) DEFAULT NULL COMMENT '活动封面',
  `ACTIVITY_DESC` text COMMENT '活动介绍',
  `DISPLAY_LOCATION` varchar(100) DEFAULT NULL COMMENT '活动地点',
  `FEE_TYPE` int(1) DEFAULT '0' COMMENT '0免费；1付费',
  `ACTIVITY_FEE` int(10) DEFAULT '0' COMMENT '活动费',
  `VIEWS` int(11) DEFAULT '0' COMMENT '浏览次数',
  `ACTIVITY_STATUS` int(1) DEFAULT '1' COMMENT '0已删除；1草稿；2审核中；3报名中；4报名结束；5进行中；6已完成；7审核通过；8审核拒绝',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ACTIVITY_ID_UINDEX` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动表';

-- ----------------------------
-- Records of activity
-- ----------------------------

-- ----------------------------
-- Table structure for activity_enroll
-- ----------------------------
DROP TABLE IF EXISTS `activity_enroll`;
CREATE TABLE `activity_enroll` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OPEN_ID` varchar(32) NOT NULL COMMENT '用户OPEN_ID',
  `ACTIVITY_ID` int(12) NOT NULL COMMENT '活动ID',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `AUTO_ACTIVITY_ENROLL_ID_UINDEX` (`ID`),
  KEY `INDEX_ACID_UID` (`ACTIVITY_ID`,`OPEN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动报名表';

-- ----------------------------
-- Records of activity_enroll
-- ----------------------------

-- ----------------------------
-- Table structure for label
-- ----------------------------
DROP TABLE IF EXISTS `label`;
CREATE TABLE `label` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `LABEL_NAME` varchar(32) NOT NULL COMMENT '标签名称',
  `LABEL_TYPE` int(1) DEFAULT NULL COMMENT '标签类型: 1电影标签 2音乐标签 3运动标签 4美食标签 5个性标签',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `LABEL_ID_UINDEX` (`ID`),
  UNIQUE KEY `LABEL_LABEL_NAME_UINDEX` (`LABEL_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='标签库';

-- ----------------------------
-- Records of label
-- ----------------------------
INSERT INTO `label` VALUES ('1', '喜剧', '1');
INSERT INTO `label` VALUES ('2', '爱情', '1');
INSERT INTO `label` VALUES ('3', '动作', '1');
INSERT INTO `label` VALUES ('4', '轻音乐', '2');
INSERT INTO `label` VALUES ('5', '流行', '2');
INSERT INTO `label` VALUES ('6', '游泳', '3');
INSERT INTO `label` VALUES ('7', '击剑', '3');
INSERT INTO `label` VALUES ('8', '射击', '3');
INSERT INTO `label` VALUES ('9', '拳击', '3');
INSERT INTO `label` VALUES ('10', '滑雪', '3');
INSERT INTO `label` VALUES ('11', '骑马', '3');
INSERT INTO `label` VALUES ('12', '高尔夫', '3');
INSERT INTO `label` VALUES ('13', '粤菜', '4');
INSERT INTO `label` VALUES ('14', '川菜', '4');
INSERT INTO `label` VALUES ('15', '湘菜', '4');
INSERT INTO `label` VALUES ('16', '浪漫', '5');
INSERT INTO `label` VALUES ('17', '体贴', '5');
INSERT INTO `label` VALUES ('18', '理性', '5');
INSERT INTO `label` VALUES ('19', '阳光', '5');

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OPEN_ID` varchar(32) NOT NULL COMMENT '用户OPEN_ID',
  `PRODUCT_ID` varchar(32) NOT NULL COMMENT '商品ID',
  `TRADE_NO` varchar(64) DEFAULT NULL COMMENT '订单号',
  `PREPAY_ID` varchar(64) NOT NULL COMMENT '预付款ID',
  `PAYMENT_NO` varchar(128) DEFAULT NULL COMMENT '微信支付单号',
  `FEE` int(9) DEFAULT NULL COMMENT '支付金额',
  `PAY_TYPE` int(1) NOT NULL DEFAULT '1' COMMENT '支付类型: 1实名认证费用 2活动费 3其他',
  `PAY_STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '支付状态: 0未支付 1已支付',
  `LOGIN_TYPE` int(1) NOT NULL DEFAULT '0' COMMENT '支付方式：1微信 2支付宝',
  `PAY_TIME` varchar(14) DEFAULT NULL COMMENT '支付完成时间',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PAYMENT_ID_UINDEX` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付记录表';

-- ----------------------------
-- Records of payment
-- ----------------------------

-- ----------------------------
-- Table structure for planet_comment
-- ----------------------------
DROP TABLE IF EXISTS `planet_comment`;
CREATE TABLE `planet_comment` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PLANET_ID` int(12) NOT NULL COMMENT '星球说ID',
  `OPEN_ID` varchar(32) NOT NULL COMMENT '评论用户OPEN_ID',
  `PARENT_ID` varchar(32) DEFAULT NULL COMMENT '评论用户的父节点用户',
  `PARENT_NAME` varchar(32) DEFAULT NULL COMMENT '评论用户父节点用户昵称',
  `TEXT` text COMMENT '评论内容',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PLANET_COMMENT_ID_UINDEX` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='星球说评论';

-- ----------------------------
-- Records of planet_comment
-- ----------------------------

-- ----------------------------
-- Table structure for planet_said
-- ----------------------------
DROP TABLE IF EXISTS `planet_said`;
CREATE TABLE `planet_said` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OPEN_ID` varchar(32) NOT NULL COMMENT '发表用户OPEN_ID',
  `LABEL_NAME` varchar(32) DEFAULT NULL COMMENT '标签',
  `TEXT` text COMMENT '文本内容',
  `AXIS` varchar(32) DEFAULT NULL COMMENT '坐标轴',
  `LIKE` int(10) DEFAULT '0' COMMENT '点赞数',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发表时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PLANET_SAID_ID_UINDEX` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='星球说';

-- ----------------------------
-- Records of planet_said
-- ----------------------------
INSERT INTO `planet_said` VALUES ('1', 'WX11', '#深圳#', '深圳真的很美', '112.23,29.12', '1', '2018-08-12 12:00:26');
INSERT INTO `planet_said` VALUES ('2', 'WX22', '#北京#', '北京雾霾天多了', '23.78,55.27', '10', '2018-08-12 12:01:18');
INSERT INTO `planet_said` VALUES ('3', 'WX11', '#北京#', '我到北京啦,见我最爱的小仙女啦', null, '22', '2018-08-14 11:03:23');
INSERT INTO `planet_said` VALUES ('4', 'WX11', '#北京#', '北京的地铁真的脏乱差', null, '0', '2018-08-14 11:04:11');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OPEN_ID` varchar(32) NOT NULL COMMENT '微信OPEN_ID',
  `NICK_NAME` varchar(32) DEFAULT NULL COMMENT '昵称',
  `AVATAR` varchar(255) DEFAULT NULL COMMENT '头像',
  `USER_NAME` varchar(32) DEFAULT NULL COMMENT '真实姓名',
  `ID_CARD` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `BIRTH_DAY` varchar(10) DEFAULT NULL COMMENT '出生日期',
  `SEX` char(1) DEFAULT 'N' COMMENT '性别: N未知 M男 F女',
  `MOBILE` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `SECRET` varchar(20) DEFAULT NULL COMMENT '账户密码：手机账户注册时填写该字段',
  `LOGIN_TYPE` int(1) DEFAULT NULL COMMENT '登陆类型：1微信  2支付宝 3手机号登陆',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USERS_ID_UINDEX` (`ID`),
  UNIQUE KEY `USERS_OPEN_ID_UINDEX` (`OPEN_ID`),
  UNIQUE KEY `USERS_ID_CARD_UINDEX` (`ID_CARD`),
  UNIQUE KEY `user_MOBILE_uindex` (`MOBILE`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='用户基础信息表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('17', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '条子', 'avatar/3dzdYQf6dgaBYGAkDN9nVOzIzWgw01', '何壹轩', '420624199305122213', '1993-05-12', 'M', '15218725510', null, '3');

-- ----------------------------
-- Table structure for user_image
-- ----------------------------
DROP TABLE IF EXISTS `user_image`;
CREATE TABLE `user_image` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OPEN_ID` varchar(32) NOT NULL COMMENT '用户OPEN_ID',
  `IMG_URL` text NOT NULL COMMENT '图片地址',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `user_image_ID_uindex` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='用户相册';

-- ----------------------------
-- Records of user_image
-- ----------------------------

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OPEN_ID` varchar(32) NOT NULL COMMENT '用户微信OPEN_ID',
  `SCHOOL` varchar(50) DEFAULT NULL COMMENT '学校(学籍)',
  `COMPANY_NAME` varchar(50) DEFAULT NULL COMMENT '企业名称',
  `EDUCATION` int(1) DEFAULT NULL COMMENT '学历:1高中及以下 2大专 3本科 4硕士 5博士',
  `HEIGHT` int(3) DEFAULT NULL COMMENT '身高',
  `WEIGHT` int(3) DEFAULT NULL COMMENT '体重',
  `LOCATION` varchar(50) DEFAULT NULL COMMENT '定位城市',
  `MARITAL_STATUS` int(1) DEFAULT NULL COMMENT '婚姻状况:1未婚 2离异',
  `WAGE_STATUS` int(1) DEFAULT NULL COMMENT '收入状况:1.5K及以下 2.5K-1W 3.1W-3W 4.3W+',
  `ID_CERT` int(1) DEFAULT '0' COMMENT '个人认证:0未认证 1已认证 2认证失败',
  `EDUCATION_CERT` int(1) DEFAULT '0' COMMENT '学历认证:0未认证 1已认证 2认证失败',
  `CORPORATE_CERT` int(1) DEFAULT '0' COMMENT '企业认证:0未认证 1已认证 2认证失败',
  `PROPERTY_CERT` int(1) DEFAULT '0' COMMENT '房产认证:0未认证 1已认证 2认证失败',
  `VEHICLE_CERT` int(1) DEFAULT '0' COMMENT ' 车辆认证:0未认证 1已认证 2认证失败',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_INFO_ID_UINDEX` (`ID`),
  UNIQUE KEY `USER_INFO_OPEN_ID_UINDEX` (`OPEN_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='用户基础信息表';

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('4', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', null, null, null, '175', '58', '深圳市', '1', '3', '1', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for user_label
-- ----------------------------
DROP TABLE IF EXISTS `user_label`;
CREATE TABLE `user_label` (
  `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OPEN_ID` varchar(32) NOT NULL COMMENT '用户OPEN_ID',
  `LABEL_ID` int(12) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `user_label_ID_uindex` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='用户标签关联';

-- ----------------------------
-- Records of user_label
-- ----------------------------
INSERT INTO `user_label` VALUES ('1', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '1');
INSERT INTO `user_label` VALUES ('2', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '2');
INSERT INTO `user_label` VALUES ('3', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '4');
INSERT INTO `user_label` VALUES ('4', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '5');
INSERT INTO `user_label` VALUES ('5', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '6');
INSERT INTO `user_label` VALUES ('6', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '7');
INSERT INTO `user_label` VALUES ('7', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '8');
INSERT INTO `user_label` VALUES ('8', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '9');
INSERT INTO `user_label` VALUES ('9', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '10');
INSERT INTO `user_label` VALUES ('10', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '11');
INSERT INTO `user_label` VALUES ('11', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '12');
INSERT INTO `user_label` VALUES ('12', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '13');
INSERT INTO `user_label` VALUES ('13', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '14');
INSERT INTO `user_label` VALUES ('14', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '16');
INSERT INTO `user_label` VALUES ('15', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '17');
INSERT INTO `user_label` VALUES ('16', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '18');
INSERT INTO `user_label` VALUES ('17', '2HEanPaqNO3IjEGmmYXGQTgI5r7kLVZF', '19');
