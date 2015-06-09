package com.microservices.rentaloffer;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import com.google.gson.Gson;

public class NeedPacket {

    public final String NEED = "car_rental_offer";
    private final List<Object> solutions = new ArrayList<>();

    public String toJson() {
        Map<String, Object> message = new HashMap<>();
        message.put("json_class", NeedPacket.class.getName());
        message.put("need", NEED);
        message.put("solutions", solutions);
        return new Gson().toJson(message);
    }

    public void proposeSolution(Object solution) {
        solutions.add(solution);
    }
}
