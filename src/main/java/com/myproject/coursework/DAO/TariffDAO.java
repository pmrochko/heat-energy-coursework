package com.myproject.coursework.DAO;

import com.myproject.coursework.models.Tariff;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TariffDAO {

    private final ConnectionPool pool;

    public TariffDAO() {
        pool = ConnectionPool.getInstance();
    }

    private static final String SQL_FIND_ALL_TARIFFS = "SELECT * FROM tariffs";
    private static final String SQL_FIND_TARIFF_BY_ID = "SELECT * FROM tariffs WHERE ID=?";
    private static final String SQL_UPDATE_TARIFF_PRICE_BY_ID = "UPDATE tariffs SET price=? WHERE ID=?";

    public Tariff findTariffByID(int id) {
        Tariff tariff = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;
        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            pstmt = con.prepareStatement(SQL_FIND_TARIFF_BY_ID);
            pstmt.setLong(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                tariff = extractTariff(rs);
            }

            con.commit();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ConnectionPool.rollback(con);
        } finally {
            ConnectionPool.close(rs, pstmt, con);
        }
        return tariff;
    }

    public boolean updateTariffPrice(String newPrice, int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int check = 0;

        try {
            con = pool.getConnection();

            pstmt = con.prepareStatement(SQL_UPDATE_TARIFF_PRICE_BY_ID);
            pstmt.setDouble(1, Double.parseDouble(newPrice));
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

    public List<Tariff> findAllTariffs() {
        List<Tariff> tariffsList = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = pool.getConnection();
            con.setAutoCommit(false);

            stmt = con.createStatement();
            rs = stmt.executeQuery(SQL_FIND_ALL_TARIFFS);
            while (rs.next()) {
                tariffsList.add(extractTariff(rs));
            }

            con.commit();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ConnectionPool.rollback(con);
        } finally {
            ConnectionPool.close(rs, stmt, con);
        }

        return tariffsList;
    }

    private Tariff extractTariff(ResultSet rs) throws SQLException {
        Tariff tariff = new Tariff();

        tariff.setID(rs.getInt("ID"));
        tariff.setTitle(rs.getString("title"));
        tariff.setPrice(rs.getDouble("price"));

        return tariff;
    }
}