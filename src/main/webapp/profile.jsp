<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HeatEnergyUA</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.png" type="image/png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/3.6.95/css/materialdesignicons.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css" rel='stylesheet'/>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <style>
        <%@ include file="/styles/index-styles.css" %>
    </style>
    <style>
        <%@ include file="/styles/profile-styles.css" %>
    </style>
</head>
<body>

    <header class="header drop-shadow">
        <div class="header-logo">
            <a href="index.jsp" id="onclickLogo">
                <img src="images/logo.png" alt="logo image">
                <span class="p">HeatEnergyUA</span>
            </a>
        </div>

        <div class="header-nav">
            <a href="index.jsp">Головна</a>
            <a href="${pageContext.request.contextPath}/tariffs">Тарифи</a>
            <a href="${pageContext.request.contextPath}/communityPage.jsp">Споживачам</a>
            <a href="${pageContext.request.contextPath}/contactPage.jsp">Контакти</a>
        </div>

        <div class="header-buttons">
            <c:if test="${sessionScope.currentUser.role.toString() == 'ADMIN'}">
                <button type="button" id="admin-panel-btn" class="btn-profile anim-button2" data-mdb-toggle="dropdown"
                        aria-expanded="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                         class="bi bi-person-lines-fill" viewBox="0 0 16 16">
                        <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z"></path>
                    </svg>
                </button>
                <ul class="dropdown-menu admin-menu-block">
                    <li class="admin-menu-title">Панель<br>Адміністратора</li>
                    <li><hr class="dropdown-divider"/></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin?page=users">Користувачі</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin?page=tariffs">Тарифи</a></li>
                </ul>
            </c:if>
            <button onclick="document.location='/user?action=goToProfile'" id="profile-btn" class="btn-profile anim-button2">Профіль <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"></path>
            </svg></button>
            <button onclick="document.location='/user?action=logOut'" id="logout-btn" class="btn-logout anim-button2">Вихід <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-left" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0v2z"></path>
                <path fill-rule="evenodd" d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z"></path>
            </svg></button>
        </div>
    </header>

    <!----------------------------------Profile modal windows---------------------------------->

    <div class="modal fade" id="modal-edit-password" tabindex="-1" aria-labelledby="modal-edit-password-label" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content modalWindow">
                <button class="btn-close close-modal-btn" style="margin-right: 23%" data-bs-dismiss="modal" aria-label="close"></button>
                <div class="modal-login col-lg-5" style="border-radius: 25px; border: 2px #FF8800 solid">
                    <div class="card-body p-md-3 mx-md-5">

                        <div class="text-center">
                            <h4 class="mt-1 mb-4">Зміна паролю</h4>
                        </div>

                        <form action="${pageContext.request.contextPath}/edit?form=passwordForm" method="post">
                            <div class="form-outline mb-3">
                                <input type="password" name="old-pass" id="pass1" class="form-control"/>
                                <label class="form-label" for="pass1">Старий пароль</label>
                            </div>
                            <div class="form-outline mb-3">
                                <input type="password" name="new-pass" id="pass2" class="form-control"/>
                                <label class="form-label" for="pass2">Новий пароль</label>
                            </div>
                            <div class="form-outline mb-3">
                                <input type="password" name="repeat-new-pass" id="pass3" class="form-control"/>
                                <label class="form-label" for="pass3">Повторіть новий пароль</label>
                            </div>

                            <c:if test="${not empty sessionScope.changePassword}">
                                <c:choose>
                                    <c:when test="${sessionScope.changePassword == 'success'}">
                                        <div class="progress-description text-green">Ви успішно змінили свій пароль!</div>
                                        <script>
                                            swal("Успіх", "Ви успішно змінили свій пароль!", "success");
                                        </script>
                                    </c:when>
                                    <c:when test="${sessionScope.changePassword == 'filed'}">
                                        <div class="progress-description text-red">Не вдалося змінити пароль!</div>
                                        <script>
                                            swal("Помилка", "Не вдалося змінити пароль!", "error");
                                        </script>
                                    </c:when>
                                    <c:when test="${sessionScope.changePassword == 'incorrectInput'}">
                                        <div class="progress-description text-red">Введені дані - неправильні!</div>
                                        <script type="text/javascript">
                                            $(document).ready(function(){
                                                $("#modal-edit-password").modal('show');
                                            });
                                        </script>
                                    </c:when>
                                    <c:when test="${sessionScope.changePassword == 'emptyInput'}">
                                        <div class="progress-description text-orange">Заповніть усі поля!</div>
                                        <script type="text/javascript">
                                            $(document).ready(function(){
                                                $("#modal-edit-password").modal('show');
                                            });
                                        </script>
                                    </c:when>
                                </c:choose>
                                <c:remove var="changePassword" scope="session"/>
                            </c:if>

                            <div class="text-center pt-1 mb-4">
                                <button class="btn btn-primary btn-block fa-lg mb-3 text-black"
                                        style="background-color: #FF8800; border: 1px grey solid" type="submit">Змінити</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${sessionScope.openModalPay == 'success'}">
        <script type="text/javascript">
            $(document).ready(function(){
                $("#modal-pay").modal('show');
            });
        </script>
        <c:remove var="openModalPay" scope="session"/>
    </c:if>
    <div class="modal fade" id="modal-pay" tabindex="-1" aria-labelledby="modal-pay-label" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content modalWindow"  id="editPassModal">
                <button class="btn-close close-modal-btn" style="margin-right: 23%" data-bs-dismiss="modal" aria-label="close"></button>
                <div class="modal-login col-lg-6" style="border-radius: 25px; border: 2px #007fd2 solid">
                    <div class="card-body p-md-3 mx-md-5">

                        <div class="text-center">
                            <h4 class="mt-1 mb-4">Оплата послуг</h4>
                        </div>

                        <div class="dropdown">
                            <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenu" data-bs-toggle="dropdown" aria-expanded="false">
                                Оберіть потрібну послугу
                            </button>
                            <ul class="dropdown-menu border-siteBlue" aria-labelledby="dropdownMenu">
                                <li><hr class="dropdown-divider"></li>
                                <p>Централізоване опалення</p>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user?action=pay&tariffID=1">Без приладів обліку теплової енергії</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user?action=pay&tariffID=2">З приладами обліку теплової енергії</a></li>
                                <li><hr class="dropdown-divider"></li>

                                <p>Послуга з постачання теплової енергії</p>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user?action=pay&tariffID=3">За наявності приладів обліку теплової енергії</a></li>
                                <li><hr class="dropdown-divider"></li>

                                <p>Централізоване постачання гарячої води</p>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user?action=pay&tariffID=4">За умови підключення рушникосушарки</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user?action=pay&tariffID=5">За умови відсутності рушникосушарки</a></li>
                                <li><hr class="dropdown-divider"></li>

                                <p>Послуга з постачання гарячої води</p>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user?action=pay&tariffID=6"> Без використання індивідуальних теплових пунктів</a></li>
                                <li><hr class="dropdown-divider"></li>
                            </ul>
                        </div>

                        <div class="modal-pay-content">
                            <p><strong>Вибрана послуга:</strong> ${sessionScope.selectedTariff_title}</p>
                            <p><strong>Умова послуги:</strong> ${sessionScope.selectedTariff_description}</p>
                            <p><strong>Тариф:</strong> 1(м<sup>3</sup>) = ${sessionScope.selectedTariff.price} грн з ПДВ</p>

                            <form action="${pageContext.request.contextPath}/user" method="post">
                                <label for="month"><strong>Виберіть місяць</strong></label>
                                <input name="month" id="month" type="month" value="${sessionScope.valueMonth}">

                                <label for="value"><strong>Введіть показники використання за місяць (м<sup>3</sup>)</strong></label>
                                <input name="value" id="value" type="number" value="${sessionScope.valueValue}">
                                <input type="submit" value="✓">
                            </form>

                            <p class="text-green"><strong>Всього до оплати:</strong> ${sessionScope.totalPrice} грн.</p>
                        </div>

                        <c:if test="${not empty sessionScope.totalPrice}">
                            <div class="rounded-bottom" style="background-color: #eee;">
                                <div class="card-body">
                                    <p class="mb-4">Дані вашої платіжної картки</p>

                                    <div class="form-outline mb-3">
                                        <input type="text" id="formControlLgXM8" class="form-control"
                                               placeholder="1111 2222 3333 4444" />
                                        <label class="form-label" for="formControlLgXM8">Номер картки</label>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <div class="form-outline">
                                                <input type="password" id="formControlLgExpk8" class="form-control"
                                                       placeholder="MM/YY" />
                                                <label class="form-label" for="formControlLgExpk8">Термін дії</label>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-outline">
                                                <input type="password" id="formControlLgcvv8" class="form-control" placeholder="CVV" />
                                                <label class="form-label" for="formControlLgcvv8">CVV</label>
                                            </div>
                                        </div>
                                    </div>

                                    <button onclick="success_pay()" class="btn btn-info btn-block">Оплатити</button>
                                </div>
                            </div>
                            <c:remove var="totalPrice" scope="session"/>
                            <c:remove var="selectedTariff" scope="session"/>
                            <c:remove var="selectedTariff_title" scope="session"/>
                            <c:remove var="selectedTariff_description" scope="session"/>
                            <c:remove var="valueMonth" scope="session"/>
                            <c:remove var="valueValue" scope="session"/>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!---------------------------------------------------------------------------------------->

    <main>
        <div class="page-content page-container" id="page-content">
            <div class="padding">
                <div class="row container d-flex justify-content-center">
                    <div class="col-xl-8">
                        <div class="card user-card-full">
                            <div class="row m-l-0 m-r-0">
                                <div class="col-sm-4 bg-c-lite-green user-profile">
                                    <div class="card-block text-center text-white">
                                        <div class="m-b-25">
                                            <img src="https://img.icons8.com/bubbles/100/000000/user.png" class="img-radius" alt="User-Profile-Image">
                                        </div>
                                        <h5 class="f-w-600">
                                            ${sessionScope.currentUser.surname} ${sessionScope.currentUser.name}
                                        </h5>
                                            <form action="${pageContext.request.contextPath}/edit?form=surnameForm" method="post" class="edit-form">
                                                <label>
                                                    <input style="display: none" name="surname" placeholder="Прізвище" class="edit-profile-box edit-field" type="text"/>
                                                    <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                                </label>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/edit?form=nameForm" method="post" class="edit-form">
                                                <label>
                                                    <input style="display: none" name="name" placeholder="Ім'я" class="edit-profile-box edit-field" type="text"/>
                                                    <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                                </label>
                                            </form>

                                        <c:choose>
                                            <c:when test="${sessionScope.currentUser.role.toString() == 'ADMIN'}">
                                                <p>Адміністратор</p>
                                            </c:when>
                                            <c:when test="${sessionScope.currentUser.role.toString() == 'CUSTOMER'}">
                                                <p>Користувач</p>
                                            </c:when>
                                        </c:choose>

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                                            <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"></path>
                                        </svg>
                                    </div>
                                </div>
                                <div class="col-sm-8">
                                    <div class="card-block">
                                        <h6 class="m-b-20 p-b-5 b-b-default f-w-600">Інформація</h6>
                                        <div class="row">

                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-600">Пошта</p>
                                                <h6 class="text-muted f-w-400">${sessionScope.currentUser.email}</h6>
                                                <form action="${pageContext.request.contextPath}/edit?form=emailForm" method="post" class="edit-form">
                                                    <label>
                                                        <input style="display: none" name="email" class="edit-profile-box edit-field" type="email"/>
                                                        <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                                    </label>
                                                </form>
                                            </div>

                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-600">Телефон</p>
                                                <h6 class="text-muted f-w-400">
                                                    <c:choose>
                                                        <c:when test="${not empty sessionScope.currentUser.phoneNumber}">
                                                            ${sessionScope.currentUser.phoneNumber}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ---
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h6>
                                                <form action="${pageContext.request.contextPath}/edit?form=telForm" method="post" class="edit-form">
                                                    <label>
                                                        <input style="display: none" name="tel" class="edit-profile-box edit-field" type="tel"/>
                                                        <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                                    </label>
                                                </form>
                                            </div>

                                        </div>

                                        <div class="row">

                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-600">Адреса</p>
                                                <h6 class="text-muted f-w-400">
                                                    <c:choose>
                                                        <c:when test="${not empty sessionScope.currentUser.address}">
                                                            ${sessionScope.currentUser.address}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ---
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h6>
                                                <form action="${pageContext.request.contextPath}/edit?form=addrForm" method="post" class="edit-form">
                                                    <label>
                                                        <input style="display: none" name="addr" class="edit-profile-box edit-field" type="text"/>
                                                        <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                                    </label>
                                                </form>
                                            </div>

                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-600">Статус</p>
                                                <h6 class="text-muted f-w-400">${sessionScope.currentUser.role.toString()}</h6>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <button onclick="trigger_show()">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"></path>
                                                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"></path>
                                                </svg>
                                                Редагувати
                                            </button>
                                        </div>

                                        <h6 class="m-b-20 m-t-40 p-b-5 b-b-default f-w-600">Можливості</h6>
                                        <div class="row">
                                            <button data-bs-toggle="modal" data-bs-target="#modal-pay">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-credit-card-2-back-fill" viewBox="0 0 16 16">
                                                    <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v5H0V4zm11.5 1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h2a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-2zM0 11v1a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-1H0z"></path>
                                                </svg>
                                                Оплатити послугу
                                            </button>
                                        </div>
                                        <div class="row">
                                            <button onclick="document.location='contactPage.jsp'">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-flag-fill" viewBox="0 0 16 16">
                                                    <path d="M14.778.085A.5.5 0 0 1 15 .5V8a.5.5 0 0 1-.314.464L14.5 8l.186.464-.003.001-.006.003-.023.009a12.435 12.435 0 0 1-.397.15c-.264.095-.631.223-1.047.35-.816.252-1.879.523-2.71.523-.847 0-1.548-.28-2.158-.525l-.028-.01C7.68 8.71 7.14 8.5 6.5 8.5c-.7 0-1.638.23-2.437.477A19.626 19.626 0 0 0 3 9.342V15.5a.5.5 0 0 1-1 0V.5a.5.5 0 0 1 1 0v.282c.226-.079.496-.17.79-.26C4.606.272 5.67 0 6.5 0c.84 0 1.524.277 2.121.519l.043.018C9.286.788 9.828 1 10.5 1c.7 0 1.638-.23 2.437-.477a19.587 19.587 0 0 0 1.349-.476l.019-.007.004-.002h.001"></path>
                                                </svg>
                                                Написати в підтримку
                                            </button>
                                        </div>
                                        <div class="row">
                                            <button data-bs-toggle="modal" data-bs-target="#modal-edit-password">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key-fill" viewBox="0 0 16 16">
                                                    <path d="M3.5 11.5a3.5 3.5 0 1 1 3.163-5H14L15.5 8 14 9.5l-1-1-1 1-1-1-1 1-1-1-1 1H6.663a3.5 3.5 0 0 1-3.163 2zM2.5 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
                                                </svg>
                                                Змінити пароль
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="inner-shadow bg-light text-center text-white">
        <div class="container p-4 pb-0">
            <section class="mb-4">
                <a
                        class="btn btn-primary btn-floating m-1"
                        style="background-color: #3b5998;"
                        href="https://www.facebook.com/"
                        target="_blank"
                        role="button"
                ><i class="fab fa-facebook-f"></i
                ></a>
                <a
                        class="btn btn-primary btn-floating m-1"
                        style="background-color: #55acee;"
                        href="https://twitter.com/?lang=uk"
                        target="_blank"
                        role="button"
                ><i class="fab fa-twitter"></i
                ></a>
                <a
                        class="btn btn-primary btn-floating m-1"
                        style="background-color: #dd4b39;"
                        href="https://www.google.com.ua/"
                        target="_blank"
                        role="button"
                ><i class="fab fa-google"></i
                ></a>
                <a
                        class="btn btn-primary btn-floating m-1"
                        style="background-color: #ac2bac;"
                        href="https://www.instagram.com/"
                        target="_blank"
                        role="button"
                ><i class="fab fa-instagram"></i
                ></a>
            </section>
        </div>

        <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
            © 2022 Copyright:
            <a class="text-white" href="#">HeatEnergyUA</a>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.js"
            type="text/javascript"></script>
    <script src="scripts/edit-profile-script.js"></script>
    <script src="scripts/pay-script.js"></script>
</body>
</html>