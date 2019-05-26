package org.igetwell.common.utils;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ResponseText {

        public static void renderXml(HttpServletResponse response, String renderText){
            try {
                response.setCharacterEncoding("UTF-8");
                response.setContentType("text/xml; charset=UTF8");
                response.getWriter().print(renderText);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        public static void renderJson(HttpServletResponse response, String renderText){
            try {
                response.setCharacterEncoding("UTF-8");
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write(renderText);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }



        public static void render(HttpServletResponse response, String renderText){
            try {
                response.getWriter().print(renderText);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
}
