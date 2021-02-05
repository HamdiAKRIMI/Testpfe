package com.example.handlingformsubmission;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class FormController {

    @GetMapping("/form")
    public String greetingForm(Model model) {

        model.addAttribute("data", new DataForm());
        return "form";
    }

    @PostMapping("/form")
    public String greetingSubmit(@ModelAttribute DataForm data, Model model) {

    	long id = data.getId();

    	if(id==1){
    		data.setIMEI("78MMDH7478dhhdbc");
		} else {
			data.setIMEI("jjjwiejfi*34343543");

		}

        model.addAttribute("data", data);
        return "result";
    }

}
