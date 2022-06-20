package com.myproject.coursework.DAO;

import com.myproject.coursework.models.Roles;
import com.myproject.coursework.models.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private final ConnectionPool pool;

    public UserDAO() {
        pool = ConnectionPool.getInstance();
    }

    private static final String SQL_FIND_ALL_USERS = "SELECT * FROM users";
    private static final String SQL_FIND_USER_BY_ID = "SELECT * FROM users WHERE id=?";
    private static final String SQL_FIND_USER_BY_EMAIL = "SELECT * FROM users WHERE email=?";
    private final static String SQL_INSERT_USER = "INSERT INTO users (ID, email, password, name, role, banStatus) " +
            "VALUES (DEFAULT, ?, ?, ?, 'CUSTOMER', '')";

    private final static String SQL_UPDATE_USER_SURNAME = "UPDATE users SET surname=? WHERE ID=?";
    private final static String SQL_UPDATE_USER_NAME = "UPDATE users SET name=? WHERE ID=?";
    private final static String SQL_UPDATE_USER_EMAIL = "UPDATE users SET email=? WHERE ID=?";
    private final static String SQL_UPDATE_USER_TEL = "UPDATE users SET phoneNumber=? WHERE ID=?";
    private final static String SQL_UPDATE_USER_ADDRESS = "UPDATE users SET address=? WHERE ID=?";
    private final static String SQL_UPDATE_USER_PASSWORD = "UPDATE users SET password=? WHERE ID=?";
    private final static String SQL_UPDATE_BANSTATUS = "UPDATE users SET banStatus=? WHERE ID=?";

    public boolean updateUserSurname(String newSurname, int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_USER_SURNAME);
            pstmt.setString(1, newSurname);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }
    public boolean updateUserName(String newName, int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_USER_NAME);
            pstmt.setString(1, newName);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }
    public boolean updateUserEmail(String newEmail, int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_USER_EMAIL);
            pstmt.setString(1, newEmail);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }
    public boolean updateUserTel(String newTel, int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_USER_TEL);
            pstmt.setString(1, newTel);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }
    public boolean updateUserAddress(String newAddress, int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_USER_ADDRESS);
            pstmt.setString(1, newAddress);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }
    public boolean updateUserPassword(String newPassword, int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_USER_PASSWORD);
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }
    public boolean updateUserBanStatus(String newStatus, int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_BANSTATUS);
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, id);

            check = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }

    public List<User> findAllUsers() {
        List<User> userList = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            stmt = con.createStatement();
            rs = stmt.executeQuery(SQL_FIND_ALL_USERS);
            while (rs.next()) {
                userList.add(extractUser(rs));
            }

            con.commit();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ConnectionPool.rollback(con);
        } finally {
            ConnectionPool.close(rs, stmt, con);
        }

        return userList;
    }

    public boolean insertUser(String email, String password, String name) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_INSERT_USER);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            pstmt.setString(3, name);
            check = pstmt.executeUpdate();

            if (check != 0) {
                con.commit();
            } else {
                ConnectionPool.rollback(con);
            }

        } catch (SQLException e1) {
            e1.printStackTrace();
            ConnectionPool.rollback(con);
        } finally {
            ConnectionPool.close(pstmt);
            ConnectionPool.close(con);
        }

        return (check > 0);
    }

    public User findUserByID(long id) {
        User user = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_FIND_USER_BY_ID);
            pstmt.setLong(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = extractUser(rs);
            }

            con.commit();
        } catch (SQLException ex) {
            ConnectionPool.rollback(con);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return user;
    }

    public User findUserByEmail(String email) {
        User user = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_FIND_USER_BY_EMAIL);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = extractUser(rs);
            }

            con.commit();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ConnectionPool.rollback(con);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return user;
    }

    private User extractUser(ResultSet rs) throws SQLException {
        User user = new User();

        user.setID(rs.getInt("ID"));
        user.setEmail(rs.getString("email"));
        user.setName(rs.getString("name"));
        user.setSurname(rs.getString("surname"));
        user.setRole(Roles.valueOf(rs.getString("role")));
        user.setPassword(rs.getString("password"));
        user.setPhoneNumber(rs.getString("phoneNumber"));
        user.setAddress(rs.getString("address"));
        user.setBanStatus(rs.getString("banStatus"));

        return user;
    }
}