package com.alena.jewelryproject.controller.admin;

import com.alena.jewelryproject.model.EmailMessage;
import com.alena.jewelryproject.model.enums.EmailMessageToType;
import com.alena.jewelryproject.service.EmailMessagesService;
import com.alena.jewelryproject.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;

@Controller
@SessionAttributes(value = "email")
@RequestMapping("/admin/emails")
public class EmailAdminController {
    private static final Logger log = LoggerFactory.getLogger(EmailAdminController.class);

    @Autowired
    private EmailMessagesService emailMessagesService;
    @Autowired
    private OrderService orderService;

    @GetMapping("/list")
    public ModelAndView getAllEmailMessages() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("emailsList", emailMessagesService.getAllEmailMessages());
        modelAndView.addObject("orders", orderService.getAllOrders());
        modelAndView.setViewName("admin/email_messages_list");
        return modelAndView;
    }

    @GetMapping("/edit")
    public ModelAndView editEmailMessage(@RequestParam(value = "id", required = false) Long id) {
        ModelAndView modelAndView = new ModelAndView();
        EmailMessage emailMessage = id != null ? emailMessagesService.getEmailMessage(id) : new EmailMessage();
        modelAndView.addObject("emailMsg", emailMessage);
        modelAndView.addObject("toTypes", EmailMessageToType.values());
        modelAndView.setViewName("admin/email_message_edit");
        return modelAndView;
    }

    @PostMapping("/save")
    public ModelAndView saveEmailMessage(@RequestParam(value = "id") Long id,
                                         @ModelAttribute("emailMsg") EmailMessage emailMessage) {
        if (id == null) {
            emailMessagesService.save(emailMessage);
        } else {
            emailMessagesService.update(emailMessage);
        }
        return new ModelAndView("redirect:/admin/emails/list", new HashMap<>());
    }

    @DeleteMapping("/delete")
    public @ResponseBody String deleteEmailMessage(@RequestParam(value = "id") Long id) {
        emailMessagesService.deleteEmailMessage(id);
        return "ok";
    }

    @PutMapping("/sendEmail")
    public @ResponseBody String sendEmail(@RequestParam(value = "id") Long emailId,
                                          @RequestParam(value = "email") String email,
                                          @RequestParam(value = "orderId") Long orderId) {
        emailMessagesService.sendEmail(emailId, orderService.getOrder(orderId));
        return "ok";
    }
}
