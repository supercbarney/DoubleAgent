package doubleagent;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
//Integer maxAge, String name
public class FileLoader {
    public ArrayList<AgentDetails> GetDoubleAgents() {
        ArrayList<AgentDetails> result = new ArrayList<AgentDetails>();
        String filePath = ".\\lib\\cc-maps-data-set.csv";
        //C:\Users\CHRIS\IdeaProjects\DoubleAgent\src\java\doubleagent\FileLoader.java
        BufferedReader br = null;
        String line;
        try {

            br = new BufferedReader(new FileReader(filePath));
            while ((line = br.readLine()) != null) {

                String[] splitLine = line.split(",");
                AgentDetails agent = new AgentDetails();
                agent.setName(splitLine[0]);
                agent.setLatitude(Double.parseDouble(splitLine[1]));
                agent.setLongitude(Double.parseDouble(splitLine[2]));
                agent.setAge(Integer.parseInt(splitLine[3]));
                agent.setGender(splitLine[4]);
                result.add(agent);
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return result;
    }
}
