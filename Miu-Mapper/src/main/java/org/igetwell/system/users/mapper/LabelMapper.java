package org.igetwell.system.users.mapper;

import org.igetwell.system.users.domain.Label;
import org.igetwell.system.users.retrieve.UserLabelQuery;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface LabelMapper extends Mapper<Label> {

    List<String> getLables(UserLabelQuery query);
}