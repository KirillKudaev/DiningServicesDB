import java.sql.*;
import java.util.*;

/**
 * Created by Kirill and Gavin on 11/15/2016.
 */
public class InsertData {
    public static final int batchSize = 100; // insert batch size
    public static final int numberOfDishes = 1000; // Min: batchSize. Must be multiple of batchSize


    static void makeDishes(Connection cnc, int numDishes) {
        try {
            ResultSet rst = null;
            PreparedStatement pst = null;
            String stmt = "", name;
            Formatter fmt;
            int foodType, institution, price, j;
            Random r = new Random();



            for (int i = 0; i < numDishes / batchSize; i++) {
                stmt = "insert into Dish(foodTypeId, institutionId, name, price) values";
                //j = 0;
                for (j = 0; j < batchSize - 1; j++) {
                    foodType = (j % 3) + 1; // Every 3rd row will have the same foodTypeId
                    institution = (j % 4) + 1; // Every 4th row will have the same institutionId
                    name = "Dish " + (i * batchSize + j); //Every Dish will be "Dish 1", "Dish 2" ...
                    price = (r.nextInt(4) + 1); // 1 - 5 dollars


                    stmt += " (" + foodType + ", " + institution + ", '" + name + "', " + price + "), ";

                }
                j = j + 1;
                foodType = (j % 3) + 1; // Every 3rd row will have the same foodTypeId
                institution = (j % 4) + 1; // Every 4th row will have the same institutionId
                name = "Dish " + (i * batchSize + j); //Every Dish will be "Dish 1", "Dish 2" ...
                price = (r.nextInt(4) + 1); // 1 - 5 dollars

                stmt += " (" + foodType + ", " + institution + ", '" + name + "', " + price + ")";

                pst = cnc.prepareStatement(stmt);
                pst.executeUpdate();
            }



        } catch (SQLException err) {
            System.out.println(err.getMessage());
        }
        finally {
            closeEm(cnc);
        }
    }


    static void closeEm(Object... toClose) {
        for (Object obj: toClose)
            if (obj != null)
                try {
                    obj.getClass().getMethod("close").invoke(obj);
                } catch (Throwable t) {System.out.println("Log bad close");}
    }

    public static void main(String[] args) {
        Connection cnc = null;
        List<Integer> ids;
        Scanner in = new Scanner(System.in);
        Map<String, Integer> purchases = new TreeMap<String, Integer>();
        String dbUrl = "jdbc:mysql://localhost:3306/DiningServices";
        try {
            cnc = DriverManager.getConnection(dbUrl, "root", "Neut4535");

            makeDishes(cnc, numberOfDishes);

//            ResultSet rst = null;
//            PreparedStatement pst = null;
//
//
//            pst = cnc.prepareStatement("select id, firstName from User");
//            rst = pst.executeQuery();
//
//            while (rst.next())
//                System.out.println(rst.getString(1) + " " + rst.getString(2));

        } catch (SQLException err) {
            System.out.println(err.getMessage());
        }
        finally {
            closeEm(cnc, in);
        }
    }
}
