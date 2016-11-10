import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;



public class DatabaseTester {
	public static void main(String args[]){

		Connection conn;

		try {
			conn = DriverManager.getConnection("jdbc:h2:file:./IftDb;FILE_LOCK=FS");
			conn.setAutoCommit(true);
			Statement stmt = conn.createStatement();
			String sqlString = "";

			sqlString = "select *  from t_businessType ";

					//"select agency_nme, t_agency_alias.agency_alias_nme from t_agency inner join t_agency_alias on t_agency.agency_id = t_agency_alias.agency_id ";



					//"select * from t_agency_alias als inner join t_agency agency on als.agency_id = agency.agency_id where agency.agency_nme = als.agency_alias_nme; ";
					/*"select agency_nme from t_agency where producer_num in "
					+ "(select producer_num from (select producer_num  , count(*) "
					+ "from t_agency where producer_num is not null group by producer_num having count(*) > 1 ))"
					+ " order by agency_nme; ";*/
					//"select agency_id, contact_id, contact_nme from t_contact where email_address_id = 'null';";
					//"select email_addr from t_email_addr where email_address_id = 14;";//"alter table t_contact alter column email_addr_id rename to email_address_id";
			//"Show Tables";


			//stmt.executeUpdate(sqlString);
			ResultSet rs = stmt.executeQuery(sqlString);
			ResultSetMetaData rsmd = rs.getMetaData();

			int numColumns = rsmd.getColumnCount();
			System.out.println("     " + rsmd.getTableName(1));
			for(int i=1;i<numColumns +1; i++){
				System.out.println(rsmd.getColumnName(i));
				System.out.println(rsmd.getColumnType(i));
			}
			System.out.println();
			String out;
			while( rs.next() ){
				out = "";
				for(int i=1;i<numColumns +1; i++){
					out += rs.getString(i) + "  ";
				}
				System.out.println(out);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
