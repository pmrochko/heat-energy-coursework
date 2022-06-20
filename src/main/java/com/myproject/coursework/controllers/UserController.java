package com.myproject.coursework.controllers;

import com.myproject.coursework.DAO.TariffDAO;
import com.myproject.coursework.DAO.UserDAO;
import com.myproject.coursework.models.Tariff;
import com.myproject.coursework.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "UserController", value = "/user")
public class UserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if (action != null && !action.isEmpty()) {
            if (session.getAttribute("loginStatus") != null &&
                    !session.getAttribute("loginStatus").toString().isEmpty()) {
                switch (action) {
                    case "pay":
                        if (session.getAttribute("loginStatus").equals("success")) {
                            String tariffID = request.getParameter("tariffID");
                            if (tariffID != null && !tariffID.isEmpty()) {
                                int tID = Integer.parseInt(tariffID);
                                TariffDAO tariffDAO = new TariffDAO();
                                Tariff tariff = tariffDAO.findTariffByID(tID);
                                if (tariff != null) {
                                    session.setAttribute("selectedTariff", tariff);

                                    int index = tariff.getTitle().indexOf(']');
                                    String title = tariff.getTitle().substring(1, index);
                                    String description = tariff.getTitle().substring(index + 1);
                                    session.setAttribute("selectedTariff_title", title);
                                    session.setAttribute("selectedTariff_description", description);
                                }
                            }
                            session.setAttribute("openModalPay", "success");
                            response.sendRedirect("profile.jsp");
                        }
                        break;
                    case "goToProfile":
                        if (session.getAttribute("loginStatus").equals("success")) {
                            User currUser = (User) session.getAttribute("currentUser");
                            User updUser = new UserDAO().findUserByID(currUser.getID());
                            if (!currUser.equals(updUser)) {
                                session.setAttribute("currentUser", updUser);
                            }
                            request.getRequestDispatcher("profile.jsp").forward(request, response);
                        }
                        break;
                    case "logOut":
                        if (session.getAttribute("loginStatus").equals("success")) {
                            session.invalidate();
                            response.sendRedirect("index.jsp");
                        }
                        break;
                    default:
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            }
        } else {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        String month = req.getParameter("month");
        String value = req.getParameter("value");

        if (month != null && value != null && !month.isEmpty() && !value.isEmpty()) {
            double inputValue = Double.parseDouble(value);
            Tariff tariff = (Tariff) session.getAttribute("selectedTariff");
            double totalPrice = inputValue * tariff.getPrice();
            session.setAttribute("totalPrice", totalPrice);
            session.setAttribute("openModalPay", "success");
        }

        session.setAttribute("valueMonth", month);
        session.setAttribute("valueValue", value);
        resp.sendRedirect("profile.jsp");
    }
}
