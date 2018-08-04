package org.igetwell.common.exhandler.ctroller;

import lombok.extern.slf4j.Slf4j;
import org.igetwell.common.enums.HttpStatus;
import org.igetwell.common.exhandler.exception.BaseException;
import org.igetwell.common.utils.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.servlet.http.HttpServletRequest;
import java.nio.file.AccessDeniedException;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 业务异常处理
     * @param req
     * @param e
     * @return
     * @throws Exception
     */
    /*@ExceptionHandler(value = BaseException.class)
    public Object baseErrorHandler(HttpServletRequest req, Exception e) throws Exception {
        logger.error("---BaseException Handler---Host {} invokes url {} ERROR: {}", req.getRemoteHost(), req.getRequestURL(), e.getMessage());
        return e.getMessage();
    }*/

    @ExceptionHandler
    public ResponseEntity defaultErrorHandler(HttpServletRequest req, Exception e) {
        log.error("---DefaultException Handler---Host {} invokes url {} ERROR: {}", req.getRemoteHost(), req.getRequestURL(), e.getMessage());

        if (e instanceof IllegalArgumentException || e instanceof MethodArgumentTypeMismatchException){
            //400 非法请求参数
            return new ResponseEntity<String>(HttpStatus.FORBIDDEN, e.getMessage());
        } else if (e instanceof AccessDeniedException){
            //401
            return new ResponseEntity<String>(HttpStatus.UNAUTHORIZED, e.getMessage());
        } else if (e instanceof NoHandlerFoundException){
            //404
            return new ResponseEntity<String>(HttpStatus.NOT_FOUND, e.getMessage());
        } else if (e instanceof BaseException){
            //服务器异常
            return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
        }

        if (log.isErrorEnabled()){
            log.error("系统异常! {}", e);
        }
        return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
    }
}
