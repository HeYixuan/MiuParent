package org.igetwell.system.pay.mapper;

import org.igetwell.system.pay.domain.Payment;
import org.igetwell.system.pay.retrieve.PaymentQuery;
import tk.mybatis.mapper.common.Mapper;

public interface PaymentMapper extends Mapper<Payment> {

    Payment get(PaymentQuery payment);
}