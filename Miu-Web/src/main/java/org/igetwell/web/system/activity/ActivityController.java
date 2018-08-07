package org.igetwell.web.system.activity;

import org.igetwell.common.utils.ResponseEntity;
import org.igetwell.system.Pagination;
import org.igetwell.system.activity.domain.Activity;
import org.igetwell.system.activity.service.IActivityService;
import org.igetwell.web.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/activity")
public class ActivityController extends BaseController {

    @Autowired
    private IActivityService activityService;

    @PostMapping("/getList")
    @ResponseBody
    public ResponseEntity<Pagination<Activity>> getList(){
        return activityService.getList();
    }
}
