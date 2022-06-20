package com.myproject.coursework.controllers;

import com.myproject.coursework.DAO.TariffDAO;
import com.myproject.coursework.DAO.UserDAO;
import com.myproject.coursework.models.Tariff;
import com.myproject.coursework.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminPanelController", value = "/admin")
public class AdminPanelController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String page = request.getParameter("page");
        HttpSession session = request.getSession();
        User currUser = (User) session.getAttribute("currentUser");

        if (action != null && !action.isEmpty()) {
            String userID = request.getParameter("userID");
            if (userID != null && !userID.isEmpty()) {
                UserDAO userDAO = new UserDAO();
                switch (action) {
                    case "ban":
                        userDAO.updateUserBanStatus("banned", Integer.parseInt(userID));
                        break;
                    case "unblock":
                        userDAO.updateUserBanStatus("", Integer.parseInt(userID));
                        break;
                }
            }
            response.sendRedirect("/admin?page=users");
        } else if (page != null && !page.isEmpty() && currUser != null && currUser.getRole().toString().equals("ADMIN")) {
            switch (page) {
                case "users":
                    UserDAO userDAO = new UserDAO();
                    List<User> usersList = userDAO.findAllUsers();
                    request.setAttribute("usersList", usersList);
                    request.getRequestDispatcher("WEB-INF/admin_pages/adminUsersPage.jsp").forward(request, response);
                    break;
                case "tariffs":
                    TariffDAO tariffDAO = new TariffDAO();
                    List<Tariff> tariffsList = tariffDAO.findAllTariffs();
                    request.setAttribute("tariffsList", tariffsList);
                    request.getRequestDispatcher("WEB-INF/admin_pages/adminTariffsPage.jsp").forward(request, response);
                    break;
            }
        } else response.sendRedirect("index.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String update = req.getParameter("update");
        String form = req.getParameter("form");
        int id = Integer.parseInt(req.getParameter("id"));

        if (update != null && !update.isEmpty() && form != null && !form.isEmpty() && id != 0) {
            if (update.equals("tariff")) {
                if (form.equals("price")) {
                    String newPrice = req.getParameter("price");
                    if (newPrice != null && !newPrice.isEmpty()) {
                        TariffDAO tariffDAO = new TariffDAO();
                        tariffDAO.updateTariffPrice(newPrice, id);
                    }
                }
                resp.sendRedirect("/admin?page=tariffs");
            } else if (update.equals("user")) {
                switch (form) {
                    case "email":
                        String newEmail = req.getParameter("email");
                        if (newEmail != null && !newEmail.isEmpty()) {
                            UserDAO userDAO = new UserDAO();
                            userDAO.updateUserEmail(newEmail, id);
                        }
                    case "address":
                        String newAddr = req.getParameter("address");
                        if (newAddr != null && !newAddr.isEmpty()) {
                            UserDAO userDAO = new UserDAO();
                            userDAO.updateUserAddress(newAddr, id);
                        }
                    case "tel":
                        String newTel = req.getParameter("tel");
                        if (newTel != null && !newTel.isEmpty()) {
                            UserDAO userDAO = new UserDAO();
                            userDAO.updateUserTel(newTel, id);
                        }
                }
                resp.sendRedirect("/admin?page=users");
            }
        } else {
            resp.sendRedirect("index.jsp");
        }

    }
}