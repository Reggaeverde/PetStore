package PetStore;

import java.io.FileNotFoundException;
import java.io.FileReader;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.*;

public class ListadoMascotasVendidas {
    Map<Long, String> map;

    public ListadoMascotasVendidas(){
        map = new HashMap<Long, String>();
        String filePath = System.getProperty("user.dir")+ File.separator + "src" + File.separator + "test" + File.separator + "resources" + File.separator + "mascotas.json";
        System.out.println(filePath);
        File file = new File(filePath);
        Gson gson = new Gson();
        Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
        try {
            List<Map<String, Object>> list = gson.fromJson(new FileReader(file), listType);
            for (Map<String, Object> item : list) {
                Long id = ((Double) item.get("id")).longValue();
                String name = (String) item.get("name");
                map.put(id, name);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void listadoDuplicadas(){
        Map<String, Integer> countMap = new HashMap<>();
        Set<String> repeatedValues = new HashSet<>();

        for (String value : map.values()) {
            int count = countMap.getOrDefault(value, 0);
            countMap.put(value, count + 1);

            if (count == 1) {
                repeatedValues.add(value);
            }
        }

        for (Map.Entry<Long, String> entry : map.entrySet()) {
            if (repeatedValues.contains(entry.getValue())) {
                System.out.println("Key: " + entry.getKey() + ", Value: " + entry.getValue());
            }
        }
    }
}
