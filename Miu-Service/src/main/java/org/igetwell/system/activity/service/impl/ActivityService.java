package org.igetwell.system.activity.service.impl;

import com.github.pagehelper.PageHelper;
import org.igetwell.common.constans.LoginType;
import org.igetwell.common.enums.FeeType;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.enums.PayStatus;
import org.igetwell.common.enums.PayType;
import org.igetwell.common.utils.DateUtils;
import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.activity.domain.Activity;
import org.igetwell.system.activity.mapper.ActivityEnrollMapper;
import org.igetwell.system.activity.mapper.ActivityMapper;
import org.igetwell.system.activity.retrieve.ActivityEnrollQuery;
import org.igetwell.system.activity.service.IActivityService;
import org.igetwell.system.pay.domain.Payment;
import org.igetwell.system.pay.mapper.PaymentMapper;
import org.igetwell.system.pay.retrieve.PaymentQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Collection;

@Service
public class ActivityService implements IActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ActivityEnrollMapper activityEnrollMapper;

    @Autowired
    private PaymentMapper paymentMapper;

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
     * 报名活动
     * @param enroll
     * @return
     */
    public ResponseEntity apply(ActivityEnrollQuery enroll){
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



        }else{
            PaymentQuery paymentQuery = new PaymentQuery();
            paymentQuery.setOpenId(enroll.getOpenId());
            paymentQuery.setPayStatus(PayStatus.WAITPAY.value());
            paymentQuery.setPayType(PayType.AUTH.value());
            Payment payment = paymentMapper.get(paymentQuery);
            if (!StringUtils.isEmpty(payment)){
                //TODO:如果有存在未支付的记录，对这个未支付的记录做处理
            }

        }




        return null;
    }
}
