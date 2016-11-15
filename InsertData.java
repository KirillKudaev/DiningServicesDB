import java.sql.*;
import java.util.*;

/**
 * Created by Kirill and Gavin on 11/15/2016.
 */
public class InsertData {



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
           // List<> rtn = new LinkedList<>();
            ResultSet rst = null;
            PreparedStatement pst = null;


            pst = cnc.prepareStatement("select id, firstName from User");
            rst = pst.executeQuery();

            while (rst.next())
                System.out.println(rst.getString(1) + " " + rst.getString(2));

        } catch (SQLException err) {
            System.out.println(err.getMessage());
        }
        finally {
            closeEm(cnc, in);
        }
    }
}
