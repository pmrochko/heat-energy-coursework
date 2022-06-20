package com.myproject.coursework.controllers;

import com.myproject.coursework.DAO.TariffDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.DecimalFormat;

@WebServlet(name = "TariffsPageController", value = "/tariffs")
public class TariffsPageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        TariffDAO tariffDAO = new TariffDAO();

        DecimalFormat decimalFormat = new DecimalFormat( "#.##" );

        request.setAttribute("priceTariff1", decimalFormat.format(tariffDAO.findTariffByID(1).getPrice()));
        request.setAttribute("priceTariff1_b", decimalFormat.format(
                tariffDAO.findTariffByID(1).getPrice() - tariffDAO.findTariffByID(1).getPrice() * 0.05));
        request.setAttribute("priceTariff2", decimalFormat.format(tariffDAO.findTariffByID(2).getPrice()));
        request.setAttribute("priceTariff2_b", decimalFormat.format(
                tariffDAO.findTariffByID(2).getPrice() - tariffDAO.findTariffByID(2).getPrice() * 0.05));
        request.setAttribute("priceTariff3", decimalFormat.format(tariffDAO.findTariffByID(3).getPrice()));
        request.setAttribute("priceTariff4", decimalFormat.format(tariffDAO.findTariffByID(4).getPrice()));
        request.setAttribute("priceTariff4_b", decimalFormat.format(
                tariffDAO.findTariffByID(4).getPrice() - tariffDAO.findTariffByID(4).getPrice() * 0.05));
        request.setAttribute("priceTariff5", decimalFormat.format(tariffDAO.findTariffByID(5).getPrice()));
        request.setAttribute("priceTariff5_b", decimalFormat.format(
                tariffDAO.findTariffByID(5).getPrice() - tariffDAO.findTariffByID(5).getPrice() * 0.05));
        request.setAttribute("priceTariff6", decimalFormat.format(tariffDAO.findTariffByID(6).getPrice()));

        request.getRequestDispatcher("/tariffsPage.jsp").forward(request, response);
    }

}
