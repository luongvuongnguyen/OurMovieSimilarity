package database;

import java.sql.*;

public interface iconnectionpool {
    public Connection getConnection() throws SQLException;
    public void releaseConnection(Connection con)throws SQLException;
}
