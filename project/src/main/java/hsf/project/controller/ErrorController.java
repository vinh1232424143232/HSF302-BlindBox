package hsf.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@Controller
public class ErrorController {

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handleException(Exception e) {
        return "redirect:/hsf/home";
    }
}
