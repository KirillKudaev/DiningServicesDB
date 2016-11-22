import java.sql.*;
import java.util.*;

/**
 * Created by Kirill and Gavin on 11/15/2016.
 */
public class InsertData {
    public static final int batchSize           = 100; // insert batch size
    public static final int numberOfDishes      = 1000; // Min: batchSize. Should be multiple of batchSize
    public static final int numberOfMenuWeeks   = 10; // Keep at 100
    public static final int numberOfUsers       = 1000;
    public static final int numberOfCheckins    = 100;
    public static final int numberOfRatings     = 100;
    public static final int numOpHours          = 84;
    public static final int numDishesPerMeal    = 2;

    static void makeDishes(Connection cnc, int numDishes) throws SQLException {

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

    }

    static void makeMenu(Connection cnc, int numMenuWeeks) throws SQLException{

        ResultSet rst = null;
        PreparedStatement pst;
        String stmt;
        Formatter fmt;



        for (int i = 0; i < numMenuWeeks; i++) {
            stmt = "INSERT INTO Menu (operationHoursId, date) VALUES";



            for (int k = 1; k < numOpHours ; k++) {
                stmt += " (" + k + ", now()),";
            }
            stmt += " (" + (numOpHours) + ", now())";




            pst = cnc.prepareStatement(stmt);
            pst.executeUpdate();


        }
    }

    static void makeDishXMenu(Connection cnc) throws SQLException{

        ResultSet rst = null;
        PreparedStatement pst;
        String stmt;
        Formatter fmt;
        int dishId, menuId;

        stmt = "INSERT INTO DishXMenu (dishId, menuId) VALUES";

        for (int i = 0; i < numDishesPerMeal; i++) {
            dishId = numOpHours * i + 1; // offset the dishes by number of OperationHour divisions

            if (!(dishId < numberOfDishes)) {
                break;

            }

            for (menuId = 1; menuId < (numberOfMenuWeeks * numOpHours) + 1; menuId++, dishId++) {
                if (dishId > numberOfDishes)
                    dishId = 1;
                stmt += " (" + dishId + ", " + menuId + "),";
            }

        }


        stmt += " (" + 1 + ", " + 1 + ")";
        //System.out.println(stmt);
        pst = cnc.prepareStatement(stmt);
        pst.executeUpdate();

    }

    static public void makeUsers(Connection cnc, int numberOfUsers) throws SQLException {
        ResultSet rst = null;
        PreparedStatement pst = null;
        String stmt = "", name;
        Formatter fmt;
        String lastName, firstName, middleName, gender, password, email;
        int fbId, institution, price, j;
        Random r = new Random();

        for (int i = 0; i < numberOfUsers / batchSize; i++) {
            stmt = "INSERT INTO `User`(lastName, firstName, middleName, fbId, gender, password, firstSignIn, email, role) VALUES ";
            //j = 0;
            for (j = 0; j < batchSize - 1; j++) {
                lastName = "LastName " + (i * batchSize + j);
                firstName = "FirstName " + (i * batchSize + j);
                middleName = "MiddleName " + (i * batchSize + j);
                fbId = 1000 + (i * batchSize + j);

                if (j % 2 == 0)
                    gender = "M";
                else
                    gender = "F";

                password = "password" + (i * batchSize + j);
                email = "email" + (i * batchSize + j);

                stmt += " ('" + lastName + "', '" + firstName + "', '" + middleName + "', " + fbId
                        + ", '" + gender + "', '" + password + "', now() " + ", '" + email +
                        "', " + "0), ";
            }

            lastName = "LastName " + (i * batchSize + j);
            firstName = "FirstName " + (i * batchSize + j);
            middleName = "MiddleName " + (i * batchSize + j);
            fbId = 1000 + (i * batchSize + j);

            if (j % 2 == 0)
                gender = "M";
            else
                gender = "F";

            password = "password" + (i * batchSize + j);
            email = "email" + (i * batchSize + j);


            stmt += " ('" + lastName + "', '" + firstName + "', '" + middleName + "', " + fbId
                    + ", '" + gender + "', '" + password + "', now() " + ", '" + email +
                    "', " + "0) ";


            pst = cnc.prepareStatement(stmt);
            pst.executeUpdate();
        }
    }

    static public void makeCheckins(Connection cnc, int numberOfCheckIns) throws SQLException {
        ResultSet rst = null;
        PreparedStatement pst = null;
        String stmt = "", name;
        Formatter fmt;
        String comment;
        int locationId, userId, sponsor, j;
        Random r = new Random();


        for (int i = 0; i < numberOfCheckins / batchSize; i++) {
            stmt = "INSERT INTO `CheckIn`(locationId, userId, comment, sponsor, date) VALUES ";
            //j = 0;
            for (j = 0; j < batchSize - 1; j++) {
                if (j % 2 == 0)
                    locationId = 1;
                else
                    locationId = 2;

                userId = i * batchSize + j + 1;

                comment = "Comment " + (i * batchSize + j + 1);

                if (j % 3 == 0)
                    sponsor = 0;
                else
                    sponsor = 1;


                stmt += " (" + locationId + ", " + userId + ", '" + comment + "', " + sponsor
                        + ", now()), ";
            }

            if (j % 2 == 0)
                locationId = 1;
            else
                locationId = 2;

            userId = i * batchSize + j + 1;

            comment = "Comment " + (i * batchSize + j + 1);

            if (j % 3 == 0)
                sponsor = 0;
            else
                sponsor = 1;

            stmt += " (" + locationId + ", " + userId + ", '" + comment + "', " + sponsor
                    + ", now());";

            pst = cnc.prepareStatement(stmt);
            pst.executeUpdate();
        }
    }

    static public void makeRatings(Connection cnc, int numberOfRatings) throws SQLException {
        ResultSet rst = null;
        PreparedStatement pst = null;
        String stmt = "", name;
        Formatter fmt;
        String comment;
        int userId, dishId, score, j;
        Random r = new Random();


        for (int i = 0; i < numberOfCheckins / batchSize; i++) {
            stmt = "INSERT INTO `Rating`(userId, dishId, score, comment, date) VALUES ";
            //j = 0;
            for (j = 0; j < batchSize - 1; j++) {
                userId = 2*(i * batchSize + j + 1);
                dishId = 4*(i * batchSize + j + 1);
                if (dishId > numberOfDishes)
                    System.out.println("Went passed end of dishes!");
                score = (r.nextInt(4) + 1); // 1 - 5
                comment = "Comment " + (i * batchSize + j + 1);

                stmt += " (" + userId + ", " + dishId + ", " + score + ", '" + comment + "', now()), ";
            }

            userId = 2*(i * batchSize + j + 1);
            dishId = 4*(i * batchSize + j + 1);
            if (dishId > numberOfDishes)
                System.out.println("Went passed end of dishes!");
            score = (r.nextInt(4) + 1); // 1 - 5
            comment = "Comment " + (i * batchSize + j + 1);

            stmt += " (" + userId + ", " + dishId + ", " + score + ", '" + comment + "', now()); ";

            //System.out.println(stmt);
            pst = cnc.prepareStatement(stmt);
            pst.executeUpdate();
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
        //Map<String, Integer> purchases = new TreeMap<String, Integer>();
        String dbUrl = "jdbc:mysql://localhost:3306/DiningServices";
        try {
            cnc = DriverManager.getConnection(dbUrl, "root", "Neut4535");

            System.out.println("Inserting Dishes...");
            makeDishes(cnc, numberOfDishes);
            System.out.println("Inserting Menus...");
            makeMenu(cnc, numberOfMenuWeeks);
            System.out.println("Inserting DishXMenu Items...");
            makeDishXMenu(cnc);
            System.out.println("Inserting Users...");
            makeUsers(cnc, numberOfUsers);
            System.out.println("Inserting Checkin Info...");
            makeCheckins(cnc, numberOfCheckins);
            System.out.println("Inserting Ratings...");
            makeRatings(cnc, numberOfRatings);


        } catch (SQLException err) {
            System.out.println("main: ");
            System.out.println(err.getMessage());
        }
        finally {
            closeEm(cnc, in);
        }
    }
}
