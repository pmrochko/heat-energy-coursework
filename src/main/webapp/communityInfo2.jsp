<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HeatEnergyUA</title>
    <link rel="shortcut icon" href="images/logo.png" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css" rel='stylesheet'/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>

    <style>
        <%@ include file="/styles/index-styles.css" %>
    </style>
    <style>
        <%@ include file="/styles/community-page-styles.css" %>
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
        <a href="communityPage.jsp">Споживачам</a>
        <a href="contactPage.jsp">Контакти</a>
    </div>

    <div class="header-buttons">
        <c:choose>
            <c:when test="${sessionScope.loginStatus == 'success'}">
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
            </c:when>
            <c:otherwise>
                <button id="login-btn" class="btn-login anim-button2" data-bs-toggle="modal" data-bs-target="#modal-login">Вхід</button>
                <button id="reg-btn" class="btn-register anim-button2" data-bs-toggle="modal" data-bs-target="#modal-registration">Реєстрація</button>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<!----------------------------------Account modal window---------------------------------->

<div class="modal fade" id="modal-login" tabindex="-1" aria-labelledby="modal-login-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modalWindow">
            <button class="btn-close close-modal-btn" style="margin-right: 23%" data-bs-dismiss="modal" aria-label="close"></button>
            <div class="modal-login col-lg-5" style="border-radius: 25px; border: 2px #FF8800 solid">
                <div class="card-body p-md-3 mx-md-5">

                    <div class="text-center">
                        <img class="mt-3" src="${pageContext.request.contextPath}/images/logo.png" style="width: 80px;" alt="logo">
                        <h6 class="mt-3">Вхід в особистий кабінет</h6>
                        <h3 class="mb-5">HeatEnergyUA</h3>
                    </div>

                    <form action="${pageContext.request.contextPath}/login" method="post">

                        <c:choose>
                            <c:when test="${sessionScope.loginStatus == 'empty'}">
                                <div class="progress-description text-orange">Потрібно заповнити всі поля!</div>
                                <script type="text/javascript">
                                    $(document).ready(function(){
                                        $("#modal-login").modal('show');
                                    });
                                </script>
                                <c:remove var="loginStatus" scope="session"/>
                            </c:when>
                            <c:when test="${sessionScope.loginStatus == 'failed'}">
                                <div class="progress-description text-red">Введені дані - неправильні!</div>
                                <script type="text/javascript">
                                    $(document).ready(function(){
                                        $("#modal-login").modal('show');
                                    });
                                </script>
                                <c:remove var="loginStatus" scope="session"/>
                            </c:when>
                            <c:when test="${sessionScope.loginStatus == 'banned'}">
                                <div class="progress-description text-red">Ваш обліковий запис заблоковано!</div>
                                <script type="text/javascript">
                                    $(document).ready(function(){
                                        $("#modal-login").modal('show');
                                    });
                                </script>
                                <c:remove var="loginStatus" scope="session"/>
                            </c:when>
                            <c:otherwise>
                                <p>Будь ласка, увійдіть у свій обліковий запис</p>
                            </c:otherwise>
                        </c:choose>

                        <div class="form-outline mb-3">
                            <input type="email" name="email" id="form2Example11" class="form-control"
                                   placeholder="Номер телефону або адреса пошти" />
                            <label class="form-label" for="form2Example11">Пошта/Номер тел.</label>
                        </div>

                        <div class="form-outline mb-3">
                            <input type="password" name="pass" id="form2Example22" class="form-control" />
                            <label class="form-label" for="form2Example22">Пароль</label>
                        </div>

                        <div class="text-center pt-1 mb-5 pb-3">
                            <button class="btn btn-primary btn-block fa-lg mb-3 text-black"
                                    style="background-color: #FF8800; border: 1px grey solid" type="submit">Вхід</button>
                            <a class="forgot-password" href="#">Забули пароль?</a>
                        </div>

                        <div class="login-confirm d-flex align-items-center justify-content-center mb-3">
                            <p class="mb-0 me-2">Немає облікового запису?</p>
                            <button type="button" class="btn btn-outline-danger"
                                    data-bs-toggle="modal" data-bs-dismiss="modal" data-bs-target="#modal-registration">Створити новий</button>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-registration" tabindex="-1" aria-labelledby="modal-registration-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modalWindow">
            <button class="btn-close close-modal-btn" data-bs-dismiss="modal" aria-label="close"></button>
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-lg-12 col-xl-11">
                        <div class="card text-black" style="border-radius: 25px; border: 2px #18A0FB solid">
                            <div class="card-body p-md-5">
                                <div class="row justify-content-center">
                                    <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

                                        <p class="text-center h2 fw-bold mb-5 mx-1 mx-md-4 mt-4">
                                            <img class="logo-image" src="${pageContext.request.contextPath}/images/logo.png" alt="logo image">
                                            РЕЄСТРАЦІЯ
                                        </p>

                                        <form action="${pageContext.request.contextPath}/registration" method="post" class="mx-1 mx-md-4">

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="name" type="text" id="form3Example1c" class="form-control" />
                                                    <label class="form-label" for="form3Example1c">Ваше ім'я</label>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="email" type="email" id="form3Example3c" class="form-control" />
                                                    <label class="form-label" for="form3Example3c">Ваша пошта</label>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="password" type="password" id="form3Example4c" class="form-control" />
                                                    <label class="form-label" for="form3Example4c">Пароль</label>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input name="repeat_password" type="password" id="form3Example4cd" class="form-control" />
                                                    <label class="form-label" for="form3Example4cd">Повторіть пароль</label>
                                                </div>
                                            </div>

                                            <div class="form-check d-flex justify-content-center mb-5">
                                                <input name="checkbox" class="form-check-input me-2" type="checkbox" value="" id="form2Example3c" />
                                                <label class="reg-text-checkbox form-check-label" for="form2Example3c">
                                                    Я погоджуюсь з <a href="#">Умовами надання послуг</a>
                                                </label>
                                            </div>

                                            <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                                <button type="submit" class="btn bg-color-siteBlue btn-lg text-white">Зареєструватися</button>
                                            </div>

                                        </form>

                                        <c:choose>
                                            <c:when test="${sessionScope.registrationStatus == 'success'}">
                                                <div class="progress-description text-green">Ви успішно зареєструвалися!</div>
                                                <script>
                                                    swal("Успіх", "Ви успішно зареєструвалися!", "success");
                                                </script>
                                            </c:when>
                                            <c:when test="${sessionScope.registrationStatus == 'failed'}">
                                                <div class="progress-description text-red">Помилка: некоректно введені дані!</div>
                                                <script>
                                                    swal("Помилка", "Некоректно введені дані!", "error");
                                                </script>
                                            </c:when>
                                            <c:when test="${sessionScope.registrationStatus == 'emailError'}">
                                                <div class="progress-description text-red">Помилка: користувач з такою поштою вже існує!</div>
                                                <script>
                                                    swal("Помилка", "Користувач з такою поштою вже існує!", "error");
                                                </script>
                                            </c:when>
                                        </c:choose>

                                        <c:if test="${not empty sessionScope.registrationStatus}">
                                            <c:remove var="registrationStatus" scope="session"/>
                                        </c:if>

                                    </div>
                                    <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                                        <img src="${pageContext.request.contextPath}/images/main-banner.png"
                                             class="img-fluid" alt="main image">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!---------------------------------------------------------------------------------------->

<main class="main">
    <div class="community-content-block">

        <button onclick="document.location='communityPage.jsp'" class="community-out">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"></path>
            </svg>
        </button>

        <div class="info-2">
            <h2>Нормативно-правова база</h2>
            <hr>
            <ol>
                <li><a target="_blank" class="info-link" href="https://zakon.rada.gov.ua/laws/show/2189-19?fbclid=IwAR3CV3xn2j3m00ofExFNKcmPOWyaCwbNZF7F3TFDfrFYdTVe7u2bM1iaI6U#Text">Закон України про житлово-комунальні послуги</a></li>
                <li><a target="_blank" class="info-link" href="https://zakon.rada.gov.ua/laws/show/2633-15#Text">Закон України про теплопостачання</a></li>
                <li><a target="_blank" class="info-link" href="https://zakon.rada.gov.ua/laws/show/2119-19?fbclid=IwAR3HfKzMzoJHOZi2xb4ZWTIjKWNTW7MF25LkfisD1D62qnKbqAcEogqip4I#Text">Закон України про комерційний облік теплової енергії та водопостачання</a></li>
                <li><a target="_blank" class="info-link" href="http://search.ligazakon.ua/l_doc2.nsf/link1/RE32954.html?fbclid=IwAR1YqUZ78hfD0HMXIIGA2udofK32V7IK-A_fOVPKBPqEyk_LHyAzE1JfSCo">Методика розподілу між споживачами обсягів спожитих у будівлі комунальних послуг</a></li>
                <li><a target="_blank" class="info-link" href="https://www.nerc.gov.ua/index.php?id=42232&amp;fbclid=IwAR0RgxhAZLaWs1DSAZHurx3VB7Hso5MnKi_xk5_zVRgU3QOUviF4X2HLvuE">Про затвердження Порядку формування тарифів на теплову енергію, її виробництво, транспортування та постачання </a></li>
                <li><a target="_blank" class="info-link" href="https://teplo.od.ua/wp-content/uploads/2021/02/ustav_2018.pdf">Статут підприємства</a></li>
            </ol>

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
<script
        type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.1.0/mdb.min.js"
></script>
</body>
</html>