package postgre;

import static java.lang.System.out;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;


public class PostGre {

	public static void main(String[] argv) {

		System.out.println("-------- PostgreSQL "
				+ "JDBC Connection Testing ------------");
 
        TupleGenerator test = new TupleGeneratorImpl ();
        
        test.addRelSchema ("Student",
                           "id name address status",
                           "Integer String String String",
                           "id",
                           null);
        
        test.addRelSchema ("Professor",
                           "id name deptId",
                           "Integer String String",
                           "id",
                           null);
        
        test.addRelSchema ("Course",
                           "crsCode deptId crsName descr",
                           "String String String String",
                           "crsCode",
                           null);
        
        test.addRelSchema ("Teaching",
                           "crsCode semester profId",
                           "String String Integer",
                           "crcCode semester",
                           new String [][] {{ "profId", "Professor", "id" },
                                            { "crsCode", "Course", "crsCode" }});
        
        test.addRelSchema ("Transcript",
                           "studId crsCode semester grade",
                           "Integer String String String",
                           "studId crsCode semester",
                           new String [][] {{ "studId", "Student", "id"},
                                            { "crsCode", "Course", "crsCode" },
                                            { "crsCode semester", "Teaching", "crsCode semester" }});

        String [] tables = { "Student", "Professor", "Course", "Teaching", "Transcript" };
        String [] variables = {"id, name, address, status","id, name, deptId" , "crsCode, deptId, crsName, descr" , "crsCode,Semester, profid" , "studId, crsCode, semester, grade"};
        String [] types = {"Integer String String String",  "Integer String String",  "String String String String",  "String String Integer",  "Integer String String String"};
        int tups [] = new int [] { 10000, 1000, 2000, 50000, 5000 };
        Connection testing = null;
        Statement state = null;
        try {
             testing  = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/postgres", "postgres","password");
             state = testing.createStatement();
        } catch (SQLException e){}
        Comparable [][][] resultTest = test.generate (tups);
        String insert = "INSERT INTO Student(id, name, address, status) VALUES(";
        for (int i = 0; i < resultTest.length; i++) {
            out.println (tables [i]);
            String[] variable = types[i].split(" ");
            for (int j = 0; j < resultTest [i].length; j++) {
                insert = "INSERT INTO " + tables[i] + "( " + variables[i] + ") VALUES (";
                for (int k = 0; k < resultTest [i][j].length; k++) {
                    if (variable[k].equals("String"))
                    {
                        insert = insert +"\'"+ resultTest[i][j][k] + "\'";
                    } else {
                        insert = insert + resultTest[i][j][k];
                    }
                    insert = insert + ",";
                    
                } // for
                   insert = insert.substring(0,insert.length()-1) + ");";
                   try{ 
                       state.executeUpdate(insert);
                   } catch (SQLException e){
                       System.out.println(e);
                   }
            }
            } // for
        }
}