package org.igetwell.web.system.activity;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.activity.domain.Activity;
import org.igetwell.system.activity.retrieve.ActivityEnrollQuery;
import org.igetwell.system.activity.service.IActivityService;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/activity")
public class ActivityController extends BaseController {

    @Autowired
    private IActivityService activityService;

    /**
     * 获取活动列表
     * @return
     */
    @PostMapping("/getList")
    @ResponseBody
    public ResponseEntity<Pagination<Activity>> getList(){
        return activityService.getList();
    }

    /**
     * 查看活动详情
     * @param activityId
     * @return
     */
    @PostMapping("/getActivity")
    @ResponseBody
    public ResponseEntity<Activity> getActivity(Integer activityId){
        return activityService.getActivity(activityId);
    }

    @PostMapping("/apply")
    @ResponseBody
    public ResponseEntity<Activity> apply(@RequestBody @Validated ActivityEnrollQuery query){
        return activityService.apply(request.get(), query);
    }
}
