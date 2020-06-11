package database;

import java.sql.*;
import java.util.*;
/**
 * Lop SimpleConnectionPool se tu tao doi tuong ket noi moi neu ket noi cua co
 */
public class simpleconnectionpool implements iconnectionpool{
    protected Stack pool;
    protected String connectionURL;
    protected String userName;
    protected String password;
    /**
     * tao ket noi luu vao pool
     */
    public simpleconnectionpool(String aConnectionURL,String aUserName,String aPassword){
        connectionURL=aConnectionURL;
        userName=aUserName;
        password=aPassword;
        //tao Stack luu tru cac phan tu Pool
        pool=new Stack();
    }
    /**
     * Lay ket noi tu pool hoac tao moi new Pool rong
     */
    public synchronized Connection getConnection()throws SQLException{
        //neu pool khong rong lay ket noi tu pool  va tra ve cho noi goi
        if(!pool.empty()){
            return (Connection) pool.pop();
        }else{
            //neu pool rong tao moi ket noi
            return DriverManager.getConnection(connectionURL,userName, password);
        }
    }
    /**
     * Tra lai ket noi cho pool
     */
    public synchronized void releaseConnection(Connection con)throws SQLException{
        pool.push(con);
    }
}
