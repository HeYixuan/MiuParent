package org.igetwell.system.activity.service.impl;

import com.github.pagehelper.PageHelper;
import org.igetwell.common.enums.*;
import org.igetwell.common.utils.DateUtils;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.activity.domain.Activity;
import org.igetwell.system.activity.domain.ActivityEnroll;
import org.igetwell.system.activity.mapper.ActivityEnrollMapper;
import org.igetwell.system.activity.mapper.ActivityMapper;
import org.igetwell.system.activity.retrieve.ActivityEnrollQuery;
import org.igetwell.system.activity.service.IActivityService;
import org.igetwell.system.pay.domain.Payment;
import org.igetwell.system.pay.mapper.PaymentMapper;
import org.igetwell.system.pay.retrieve.PaymentQuery;
import org.igetwell.system.pay.service.impl.LocalPay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.Map;

@Service
public class ActivityService implements IActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ActivityEnrollMapper activityEnrollMapper;

    @Autowired
    private PaymentMapper paymentMapper;

    @Autowired
    private LocalPay localPay;

    /**
     * 获取活动列表
     * @return
     */
    public ResponseEntity<Pagination<Activity>> getList(){
        PageHelper.startPage(1,10);
        Collection<Activity> activities = activityMapper.getList();
        Pagination<Activity> pagination = new Pagination<Activity>(activities);
        return new ResponseEntity<Pagination<Activity>>(pagination);
    }

    /**
     * 获取活动详情
     * @param activityId
     * @return
     */
    @Override
    public ResponseEntity<Activity> getActivity(Integer activityId) {
        if (null == activityId){
            return new ResponseEntity<Activity>(HttpStatus.BAD_REQUEST, "活动ID不能为空");
        }
        return new ResponseEntity<Activity>(activityMapper.selectByPrimaryKey(activityId));
    }

    /**
     * 报名活动
     * @param enroll
     * @return
     */
    public ResponseEntity apply(HttpServletRequest request, ActivityEnrollQuery enroll){
        boolean bool = activityEnrollMapper.getTotal(enroll);
        if (bool){
            return new ResponseEntity(HttpStatus.GONE,"已报名");
        }

        Activity record = new Activity();
        record.setId(enroll.getActivityId());
        Activity activity = activityMapper.selectOne(record);
        if (StringUtils.isEmpty(activity)){
            return new ResponseEntity(HttpStatus.GONE,"活动不存在");
        }

        //如果系统时间不在活动报名开始时间之内禁止报名
        if (!DateUtils.isAfter(DateUtils.now(), activity.getEnrollStartTime()) && !DateUtils.isBefore(DateUtils.now(), activity.getEnrollEndTime())){
            return new ResponseEntity(HttpStatus.GONE,"报名未开始");
        }

        if (DateUtils.isAfter(DateUtils.now(), activity.getEnrollEndTime())){
            return new ResponseEntity(HttpStatus.GONE,"报名已截止");
        }

        //如果系统时间在活动开始时间之后或结束时间之后
        if (DateUtils.isAfter(DateUtils.now(), activity.getEnrollStartTime()) && DateUtils.isAfter(DateUtils.now(), activity.getEnrollEndTime())){
            return new ResponseEntity(HttpStatus.GONE,"报名已截止");
        }

        //免费
        if (FeeType.FREE.value() == activity.getFeeType()){
            return this.applyEnroll(enroll);
        }else{
            return this.applyPay(request, enroll);
        }
    }

    /**
     * 判断是否支付
     * 未支付但存在订单，去处理
     * 已支付但未报名成功，去处理
     * 支付记录没有则调起微信支付
     * @param request
     * @param enroll
     * @return
     */
    private ResponseEntity applyPay(HttpServletRequest request, ActivityEnrollQuery enroll){
        PaymentQuery paymentQuery = new PaymentQuery();
        paymentQuery.setOpenId(enroll.getOpenId());
        paymentQuery.setPayType(PayType.ACTIVITY.value());
        Payment payment = paymentMapper.get(paymentQuery);
        if (!StringUtils.isEmpty(payment)){
            //TODO:如果有记录，对这个记录做已支付和未支付处理
            if (null != payment.getPayStatus() && PayStatus.WAITPAY.value() == payment.getPayStatus()){
                return new ResponseEntity<>(HttpStatus.ACCEPTED, "有待支付订单,请尽快处理.");
            }
            if (null != payment.getPayStatus() && PayStatus.PAY.value() == payment.getPayStatus()){
                //防止已支付,没有报名成功处理
                return this.applyEnroll(enroll);
            }
        }
        //TODO:如果没有记录，调用微信支付，支付成功跳转成功页面，开始报名
        Map<String, String> params = localPay.preOrder(request, enroll.getOpenId(),JsApiType.NATIVE, PayType.ACTIVITY, PayType.ACTIVITY.getMessage(), String.valueOf(enroll.getActivityId()), String.valueOf(10));
        return new ResponseEntity<>(params);
    }


    /**
     * 插入用户活动报名记录
     * @param enroll
     * @return
     */
     private ResponseEntity applyEnroll(ActivityEnrollQuery enroll){
        ActivityEnroll activityEnroll = new ActivityEnroll();
        activityEnroll.setOpenId(enroll.getOpenId());
        activityEnroll.setActivityId(enroll.getActivityId());
        activityEnrollMapper.insert(activityEnroll);
        return new ResponseEntity();
    }
}
