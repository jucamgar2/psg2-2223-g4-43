package org.springframework.samples.petclinic.cause;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.samples.petclinic.exchange.Currency;
import org.springframework.samples.petclinic.exchange.ExchangeCurrency;
import org.springframework.samples.petclinic.user.PricingPlan;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/causes")
public class CauseController {

    private static final String LIST_CAUSES = "cause/causeList";

	private final CauseService causeService;

	@Autowired
	public CauseController(CauseService causeService) {
		this.causeService = causeService;
	}

    @GetMapping()
    public ModelAndView causeList(Principal principal, Currency currency){
        Map<Cause,List<ExchangeCurrency>> causeBudgets = causeService.findAllCausesByExchangeCurrency(currency);
        ModelAndView res = new ModelAndView(LIST_CAUSES);
        causeService.checkCauses();
        res.addObject("causeBudgets", causeBudgets);
        res.addObject("options", Currency.values());
        return res;
    }

    @PostMapping()
    public ModelAndView changeCurrency(@Valid Currency currency, BindingResult br, Principal principal){
        ModelAndView res = new ModelAndView(LIST_CAUSES);
        Map<Cause,List<ExchangeCurrency>> causeBudgets = causeService.findAllCausesByExchangeCurrency(Currency.USD);

        if(br.hasErrors()){
            res.addObject("mesage", "Currency couldn´t be changed");
        }else{
            res.addObject("causeBudgets", causeBudgets);
            causeBudgets = causeService.findAllCausesByExchangeCurrency(currency);
        }
        
        return res;
    }

    @GetMapping("/new")
    public ModelAndView createCause(Map<String,Object> model){
        PricingPlan plan = (PricingPlan)model.get("currentPlan");
        if(plan==null||plan==PricingPlan.BASIC||plan ==PricingPlan.ADVANCED){
            model.put("message","Con tu plan no puedes crear una causa");
            return new ModelAndView("redirect:/");
        }else{
            Cause cause = new Cause();
            ModelAndView result = new ModelAndView("cause/createCause");
            result.addObject("cause", cause);
            return result;
        }
    }

    @PostMapping("/new")
    public ModelAndView saveNewCause(@Valid Cause cause, BindingResult br,Map<String,Object> model){
        PricingPlan plan = (PricingPlan)model.get("currentPlan");
        if(plan==null||plan==PricingPlan.BASIC||plan ==PricingPlan.ADVANCED){
            model.put("message","Con tu plan no puedes crear una causa");
            return new ModelAndView("redirect:/");
        }else{    
            if(br.hasErrors()){
                return new ModelAndView("cause/createCause", br.getModel());
            }
            causeService.save(cause);
            ModelAndView result = new ModelAndView("redirect:/causes");
            result.addObject("message", "The cause was succesfully added");
            return result;
        }
    }

    @GetMapping("details/{id}")
    public ModelAndView causeDetails(@PathVariable("id") Integer id,Map<String,Object> model){
            ModelAndView result = new ModelAndView("cause/causeDetails");
            Cause cause = causeService.getCauseById(id).orElse(null);
            if(!cause.equals(null)){
                result.addObject("cause", cause);
            }
            return result;
    }


    
}
