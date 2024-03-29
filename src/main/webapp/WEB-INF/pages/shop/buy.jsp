<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="head.jsp" %>

<!DOCTYPE html>

<html>
<script>
    function addEvent(field, fieldError, createOrderError) {
        if (field !== null) {
            field.addEventListener("input", function (event) {
                if (!field.validity.valueMissing) {
                    fieldError.innerHTML = "";
                    fieldError.className = "error";
                    createOrderError.innerHTML = "";
                    createOrderError.className = "messageError";
                }
            }, false);
        }
    }

    function createOrderErrorActivate() {
        createOrderError.innerHTML = "Проверьте правильность заполнения полей ниже";
        createOrderError.className = "messageError active";
    }

    window.onload = function () {
        var length = document.getElementById('jewelriesTable').rows.length;
        if (length === 0) {
            hideOrder();
        }

        var btn = document.getElementById('createOrderButton');
        var pickUpMoscowRadioBtn = document.getElementById('pickUpMoscowRadioBtn');
        var pickUpSamaraRadioBtn = document.getElementById('pickUpSamaraRadioBtn');

        var name = document.getElementById('nameInput');
        var lastName = document.getElementById('lastNameInput');
        var phone = document.getElementById('phoneInput');
        var email = document.getElementById('emailInput');
        var country = document.getElementById('countryInput');
        var city = document.getElementById('cityInput');
        var postOfficeAddress = document.getElementById('postOfficeAddressInput');
        var boxberryAddress = document.getElementById('boxberryAddressInput');
        var index = document.getElementById('indexInput');

        var createOrderError = document.getElementById('createOrderError');
        var nameError = document.getElementById('nameError');
        var lastNameError = document.getElementById('lastNameError');
        var phoneError = document.getElementById('phoneError');
        var emailError = document.getElementById('emailError');
        var countryError = document.getElementById('countryError');
        var cityError = document.getElementById('cityError');
        var postOfficeAddressError = document.getElementById('postOfficeAddressError');
        var boxberryAddressError = document.getElementById('boxberryAddressError');
        var indexError = document.getElementById('indexError');

        addEvent(name, nameError, createOrderError);
        addEvent(lastName, lastNameError, createOrderError);
        addEvent(phone, phoneError, createOrderError);
        addEvent(email, emailError, createOrderError);
        addEvent(country, countryError, createOrderError);
        addEvent(city, cityError, createOrderError);
        addEvent(postOfficeAddress, postOfficeAddressError, createOrderError);
        addEvent(boxberryAddress, boxberryAddressError, createOrderError);
        addEvent(index, indexError, createOrderError);

        if (pickUpMoscowRadioBtn !== null) {
            pickUpMoscowRadioBtn.addEventListener("click", function (event) {
                postOfficeAddressError.innerHTML = "";
                postOfficeAddressError.className = "error";

                if (boxberryAddressError !== null) {
                    boxberryAddressError.innerHTML = "";
                    boxberryAddressError.className = "error";
                }

                indexError.innerHTML = "";
                indexError.className = "error";
            }, false);
        }

        if (pickUpSamaraRadioBtn !== null) {
            pickUpSamaraRadioBtn.addEventListener("click", function (event) {
                postOfficeAddressError.innerHTML = "";
                postOfficeAddressError.className = "error";

                if (boxberryAddressError !== null) {
                    boxberryAddressError.innerHTML = "";
                    boxberryAddressError.className = "error";
                }

                indexError.innerHTML = "";
                indexError.className = "error";
            }, false);
        }

        btn.addEventListener("click", function (event) {
            if (name.validity.valueMissing) {
                createOrderErrorActivate();
                nameError.innerHTML = "Введите имя";
                nameError.className = "error active";
                event.preventDefault();
            } else if (lastName.validity.valueMissing) {
                createOrderErrorActivate();
                lastNameError.innerHTML = "Введите фамилию";
                lastNameError.className = "error active";
                event.preventDefault();
            } else if (phone.validity.valueMissing) {
                createOrderErrorActivate();
                phoneError.innerHTML = "Введите телефон";
                phoneError.className = "error active";
                event.preventDefault();
            } else if (email.validity.valueMissing) {
                createOrderErrorActivate();
                emailError.innerHTML = "Введите адрес электронной почты";
                emailError.className = "error active";
                event.preventDefault();
            } else if (country.validity.valueMissing) {
                createOrderErrorActivate();
                countryError.innerHTML = "Введите страну";
                countryError.className = "error active";
                event.preventDefault();
            } else if (city.validity.valueMissing) {
                createOrderErrorActivate();
                cityError.innerHTML = "Введите город";
                cityError.className = "error active";
                event.preventDefault();
            } else if (postOfficeAddress.validity.valueMissing) {
                createOrderErrorActivate();
                postOfficeAddressError.innerHTML = "Введите адрес";
                postOfficeAddressError.className = "error active";
                event.preventDefault();
            } else if (boxberryAddress !== null && boxberryAddress.validity.valueMissing) {
                createOrderErrorActivate();
                boxberryAddressError.innerHTML = "Введите адрес";
                boxberryAddressError.className = "error active";
                event.preventDefault();
            } else if (index.validity.valueMissing) {
                createOrderErrorActivate();
                indexError.innerHTML = "Введите индекс";
                indexError.className = "error active";
                event.preventDefault();
            }
        }, false);

        var promocodeBtn = document.getElementById('promocodeBtn');
        var promocode = document.getElementById('promocodeInput');
        var promocodeError = document.getElementById('promocodeError');

        promocode.addEventListener("input", function (event) {
            if (!promocode.validity.valueMissing) {
                promocodeError.innerHTML = "";
                promocodeError.className = "messageError";
            }
        }, false);

        promocodeBtn.addEventListener("click", function (event) {
            if (promocode.validity.valueMissing) {
                promocodeError.innerHTML = "Введите промокод";
                promocodeError.className = "messageError active";
            }
        }, false);

        let countryInput = document.getElementById('countryInput');
        let cityInput = document.getElementById('cityInput');
        countryInput.addEventListener('blur', (event) => {
            checkDeliveryType()
        }, true);
        cityInput.addEventListener('blur', (event) => {
            let isDisabled = cityInput.value == null || !cityInput.value.toLowerCase().includes("москва");
            setBoxberryMoscowDisabled(isDisabled);
            setPickUpMoscowDisabled(isDisabled);
            isDisabled = cityInput.value == null || !cityInput.value.toLowerCase().includes("самара");
            setPickUpSamaraDisabled(isDisabled)
            if (isDisabled === true) {
                document.getElementById("postOfficeRadioBtn").checked = true;
                setPostOfficeState(true);
                setCashPaymentDisabled(true)
            }
        }, true);
    }
</script>

<style>
    body, h1, h2, h3, h4, h5, h6 {
        font-family: 'Roboto', sans-serif;
    }

    .w3-bar-block .w3-bar-item {
        padding: 20px
    }

    input, button:active, button:focus {
        outline: none;
    }

    button:hover {
        background-color: white;
    }

    a.jewelry-item-class { /*для создания кликабельного украшения*/
        display: block;
        height: 100%;
        width: 100%;
        text-decoration: none;
    }

    a.jewelry-item-class:hover { /*подчеркивание текста при наведении мышки*/
        text-decoration: underline;
    }

    .w3-input {
        padding: 2px;
        display: block;
        border: none;
        border-bottom: 1px solid #ccc;
        width: 100%
    }

    .error {
        width: 100%;
        padding: 0;

        font-size: 80%;
        color: white;
        background-color: #ff7180;
        border-radius: 0 0 5px 5px;

        -moz-box-sizing: border-box;
        box-sizing: border-box;
    }

    .error.active {
        padding: 0.3em;
    }

    .messageError {
        width: 100%;
        padding: 0;

        font-size: 80%;
        color: #ff7180;
    }

    .messageError.active {
        padding: 0.3em;
    }

    .img-size img {
        width: 90px;
        height: 90px
    }

    @media screen and (min-width: 0px) and (max-width: 992px) {
        .img-size img {
            width: 45px;
            height: 45px
        }
    }
</style>
<body>

<div class="w3-main w3-content w3-padding" style="max-width:1200px">

    <!-- для компенсации размера шапки -->
    <div class="w3-hide-medium w3-hide-small" style="margin-top:120px">
    </div>
    <div class="w3-hide-large" style="margin-top:80px">
    </div>

    <p id="emptyOrder" class="w3-text-grey" style="display: none;margin-top: 20px;margin-bottom: 350px;font-size: 12px">
        Ваша корзина пуста</p>
    <spring:form method="post" action="${pageContext.request.contextPath}/buy/createOrder" modelAttribute="order"
                 id="createOrderForm" novalidate="true">
        <div class="w3-row-padding w3-center" id="mainDiv">

            <h4 style="margin:0px 0px">Оформление заказа</h4>

            <div class="w3-container">
                <table id="jewelriesTable" class="w3-table w3-bordered">
                    <c:forEach items="${order.jewelries}" var="jewelry">
                        <tr>
                            <td>
                                <div class="w3-cell img-size">
                                    <img src="${imageHelper.getMainImageFullPath(jewelry)}"
                                         alt="jewelry"
                                         class="w3-margin-right">
                                </div>
                                <div class="w3-cell w3-cell-middle">
                                    <a href="${pageContext.request.contextPath}/jewelry?id=${jewelry.id}"
                                       class="jewelry-item-class"><p
                                            style="margin:0;font-weight:600">${jewelry.name}</p></a>
                                    <p style="margin:0;font-size:12px">${jewelry.description}</p>
                                </div>
                            </td>
                            <td style="text-align:right;font-size:18px;width:80px;white-space:nowrap">
                                <p>${jewelry.formatPrice}</p>
                                <button type="button" style="border:none;background-color:white;cursor:pointer;"
                                        onclick="deleteItem(this, ${jewelry.id})">
                                    <i class="fa fa-trash" aria-hidden="true"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <div class="w3-cell-row">
                    <div class="w3-cell w3-mobile w3-cell-middle" style="text-align:left;width:33%">
                        <p>Промокод</p>
                        <div class="w3-cell-row">
                            <div class="w3-cell w3-half" style="padding:4px 0; width: 50%; min-width:50px">
                                <input class="w3-input" type="text" id="promocodeInput" required="required"
                                       value="${order.promocode != null ? order.promocode.code : ''}"/>
                                <span id="promocodeError" class="messageError" aria-live="polite"></span>
                            </div>
                            <button type="button" onclick="checkPromocode()" id="promocodeBtn"
                                    class="w3-btn w3-cell w3-half w3-white w3-border w3-round-large"
                                    style="border-color:#ff7180!important;padding:4px 0; width: 50%">
                                <span style="color:#ff7180">Применить</span>
                            </button>
                        </div>
                    </div>
                    <div class="w3-cell w3-mobile w3-cell-middle" style="margin:8px 0;width:33%">
                        <button type="submit" class="w3-btn w3-round-large w3-black"
                                form="createOrderForm" id="createOrderButton">Оформить заказ
                        </button>
                        <br>
                        <span id="createOrderError" class="messageError" aria-live="polite"></span>
                    </div>
                    <div class="w3-cell w3-mobile" style="padding:8px 0;text-align:right;width:33%">
                        <p class="w3-text-grey" style="font-size:14px;margin:0">Скидка:
                            <span id="formatDiscountSpan">${order.formatDiscount}</span>
                        </p>
                        <p class="w3-text-grey" style="font-size:14px;margin:8px 0">Доставка:
                            <span id="formatDeliveryCostSpan">${order.formatDeliveryCost}</span>
                        </p>
                        <p style="font-weight:600;font-size:18px;margin:8px 0">ИТОГО:
                            <span id="formatCostWithoutDiscountSpan"
                                  style="text-decoration:line-through">${order.formatCostWithoutDiscount}</span>
                            <span id="formatTotalCostSpan" style="color:#ff7180"> ${order.formatTotalCost}</span>
                        </p>
                    </div>
                </div>
            </div>


            <div class="w3-row-padding w3-padding-16 w3-center">
                <div class="w3-half w3-justify">
                    <h5>Контактная информация</h5>
                    <p>
                        <label style="font-size:12px">Имя <span class="required">*</span></label>
                        <spring:input class="w3-input" value="${order.userData.firstName}"
                                      path="userData.firstName" id="nameInput" required="required"/>
                        <span id="nameError" class="error" aria-live="polite"></span>
                    </p>
                    <p>
                        <label style="font-size:12px">Фамилия <span class="required">*</span></label>
                        <spring:input class="w3-input" value="${order.userData.lastName}"
                                      path="userData.lastName" id="lastNameInput" required="required"/>
                        <span id="lastNameError" class="error" aria-live="polite"></span>
                    </p>
                    <p>
                        <label style="font-size:12px">Телефон <span class="required">*</span></label>
                        <spring:input class="w3-input" value="${order.userData.phone}"
                                      path="userData.phone" id="phoneInput" required="required"/>
                        <span id="phoneError" class="error" aria-live="polite"></span>
                    </p>
                    <p>
                        <label style="font-size:12px">Электонная почта <span class="required">*</span></label>
                        <spring:input class="w3-input" value="${order.userData.email}"
                                      path="userData.email" id="emailInput" required="required"/>
                        <span id="emailError" class="error" aria-live="polite"></span>
                    </p>
                    <p>
                        <label style="font-size:12px">Страна <span class="required">*</span></label>
                        <spring:input class="w3-input" value="${order.userData.country}"
                                      path="userData.country" id="countryInput" required="required"/>
                        <span id="countryError" class="error" aria-live="polite"></span>
                    </p>
                    <p>
                        <label style="font-size:12px">Город <span class="required">*</span></label>
                        <spring:input class="w3-input" value="${order.userData.city}"
                                      path="userData.city" id="cityInput" required="required"/>
                        <span id="cityError" class="error" aria-live="polite"></span>
                    </p>
                </div>

                <div class="w3-half w3-justify">
                    <h5>Способ доставки</h5>
                    <div class="w3-container w3-justify w3-light-grey" style="margin-bottom: 10px">

                        <p>
                            <spring:radiobutton class="w3-radio" path="deliveryType" value="POST_OFFICE"
                                                id="postOfficeRadioBtn"
                                                checked="${order.deliveryType != null && order.deliveryType.id == 'postOffice' ? 'checked' : '' }"
                                                onclick="checkDeliveryType()"/>
                            <label>Почта</label>
                        </p>

                        <div style="margin-left: 10%; margin-right: 10%">
                            <p>
                                <label id="postOfficeAddressLabel"
                                       style="font-size:12px;color: ${order.deliveryType != null && order.deliveryType.id == 'pickup' ? 'gray' : 'black' }">Адрес
                                    <span
                                            class="required">*</span></label>
                                <spring:input class="w3-input w3-light-grey" value="${order.userData.address}"
                                              path="userData.address" id="postOfficeAddressInput" required="required"
                                              disabled="${order.deliveryType != null && order.deliveryType.id == 'pickup' ? 'true' : 'false'}"/>
                                <span id="postOfficeAddressError" class="error" aria-live="polite"></span>
                            </p>
                            <p>
                                <label id="indexLabel"
                                       style="font-size:12px;color: ${order.deliveryType != null && order.deliveryType.id == 'pickup' ? 'gray' : 'black' }">Индекс
                                    <span
                                            class="required">*</span></label>
                                <spring:input class="w3-input w3-light-grey" value="${order.userData.postIndex}"
                                              path="userData.postIndex" id="indexInput" required="required"
                                              disabled="${order.deliveryType != null && order.deliveryType.id == 'pickup' ? 'true' : 'false'}"/>
                                <span id="indexError" class="error" aria-live="polite"></span>
                            </p>
                        </div>
                    </div>

                    <c:if test="${boxberryAvailable}">
                        <div class="w3-container w3-justify w3-light-grey" style="margin-bottom: 10px">

                            <p>
                                <spring:radiobutton class="w3-radio" path="deliveryType" value="BOXBERRY_MOSCOW"
                                                    id="boxberryRadioBtn"
                                                    checked="${order.deliveryType != null && order.deliveryType.id == 'boxberryMoscow' ? 'checked' : '' }"
                                                    disabled="true"
                                                    onclick="checkDeliveryType()"/>
                                <label>Boxberry по г. Москва</label>
                            </p>

                            <div style="margin-left: 10%; margin-right: 10%">
                                <p>
                                    <label id="boxberryAddressLabel"
                                           style="font-size:12px;color: ${order.deliveryType == null && order.deliveryType.id == 'boxberryMoscow' ? 'black' : 'gray' }">Адрес
                                        <span
                                                class="required">*</span></label>
                                    <spring:input class="w3-input w3-light-grey" value="${order.userData.address}"
                                                  path="userData.address" id="boxberryAddressInput" required="required"
                                                  disabled="${order.deliveryType != null && order.deliveryType.id == 'boxberryMoscow' ? 'false' : 'true'}"/>
                                    <span id="boxberryAddressError" class="error" aria-live="polite"></span>
                                </p>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${deliveryPickupAvailableMoscow}">
                        <div class="w3-container w3-justify w3-light-grey">
                            <p>
                                <spring:radiobutton class="w3-radio" path="deliveryType" value="PICKUP"
                                                    id="pickUpMoscowRadioBtn"
                                                    checked="${order.deliveryType != null && order.deliveryType.id == 'pickup' ? 'checked' : '' }"
                                                    disabled="true"
                                                    onclick="checkDeliveryType()"/>
                                <label>Самовывоз по г. Москва</label>
                            </p>
                        </div>
                    </c:if>

                    <c:if test="${deliveryPickupAvailableSamara}">
                        <div class="w3-container w3-justify w3-light-grey">
                            <p>
                                <spring:radiobutton class="w3-radio" path="deliveryType" value="PICKUP"
                                                    id="pickUpSamaraRadioBtn"
                                                    checked="${order.deliveryType != null && order.deliveryType.id == 'pickup' ? 'checked' : '' }"
                                                    disabled="true"
                                                    onclick="checkDeliveryType()"/>
                                <label>Самовывоз по г. Самара</label>
                            </p>
                        </div>
                    </c:if>

                    <h5>Способ оплаты</h5>

                    <div class="w3-container w3-justify">
                        <p>
                            <spring:radiobutton class="w3-radio" value="TRANSFER_TO_BANK_CARD" path="paymentType"
                                                id="transferPaymentRadioBtn"
                                                checked="${order.paymentType != null && order.paymentType.id == 'transferToBankCard' ? 'checked' : '' }"/>
                            <label>Перевод на карту банка</label>
                        </p>

                        <p>
                            <spring:radiobutton class="w3-radio" value="CASH" path="paymentType"
                                                id="cashPaymentRadioBtn"
                                                checked="${order.paymentType != null && order.paymentType.id == 'cash' ? 'checked' : '' }"
                                                disabled="${order.deliveryType != null && order.deliveryType.id == 'postOffice' ? 'true' : 'false'}"/>
                            <label id="cashPaymentLabel"
                                   style="color: ${order.deliveryType != null && order.deliveryType.id == 'postOffice' ? 'gray' : 'black' }">Наличными
                                при получении</label>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </spring:form>

    <hr>

    <footer class="w3-padding-16 w3-small w3-center" id="footer">
        <div class="w3-row-padding">

            <div class="w3-col s4 w3-justify w3-text-grey">
                <p><a class="jewelry-item-class" href="${pageContext.request.contextPath}/about">О нас</a></p>
                <p><a class="jewelry-item-class" href="${pageContext.request.contextPath}/delivery">Способы доставки</a>
                </p>
                <p><a class="jewelry-item-class" href="${pageContext.request.contextPath}/payment">Оплата заказа</a></p>
            </div>

            <div class="w3-col s4 w3-justify w3-text-grey">
                <p><a class="jewelry-item-class" href="${pageContext.request.contextPath}/return">Обмен и возврат</a>
                </p>
                <p><a class="jewelry-item-class" href="${pageContext.request.contextPath}/contacts">Контакты</a></p>
            </div>

            <div class="w3-col s4 w3-right-align">
                <a class="fa fa-envelope-o w3-hover-opacity w3-large" href="mailto:admin@gracefuljewelry.ru"></a>
            </div>
        </div>
    </footer>
</div>

<script type="text/javascript">
    function setPostOfficeState(state) {
        document.getElementById("postOfficeAddressLabel").style.color = state === false ? "gray" : "black";
        document.getElementById("postOfficeAddressInput").disabled = !state;
        document.getElementById("indexLabel").style.color = state === false ? "gray" : "black";
        document.getElementById("indexInput").disabled = !state;
    }

    function setBoxberryMoscowState(state) {
        let boxberryAddressLabel = document.getElementById("boxberryAddressLabel");
        let boxberryAddressInput = document.getElementById("boxberryAddressInput");
        if (boxberryAddressLabel !== null) {
            boxberryAddressLabel.style.color = state === false ? "gray" : "black";
            boxberryAddressInput.disabled = !state;
        }
    }

    function setBoxberryMoscowDisabled(disabled) {
        let boxberryRadioBtn = document.getElementById("boxberryRadioBtn");
        if (boxberryRadioBtn != null) {
            setBoxberryMoscowState(!disabled);
            boxberryRadioBtn.disabled = disabled;
            if (disabled === true) {
                boxberryRadioBtn.checked = false;
            }
        }
    }

    function setPickUpMoscowDisabled(disabled) {
        let pickUpMoscowBtn = document.getElementById("pickUpMoscowRadioBtn");
        if (pickUpMoscowBtn !== null) {
            pickUpMoscowBtn.disabled = disabled;
            if (disabled === true) {
                pickUpMoscowBtn.checked = false;
            }
        }
    }

    function setPickUpSamaraDisabled(disabled) {
        let pickUpSamaraBtn = document.getElementById("pickUpSamaraRadioBtn");
        if (pickUpSamaraBtn !== null) {
            pickUpSamaraBtn.disabled = disabled;
            if (disabled === true) {
                pickUpSamaraBtn.checked = false;
            }
        }
    }

    function setCashPaymentDisabled(disabled) {
        document.getElementById("cashPaymentLabel").style.color = disabled === true ? "gray" : "black";
        document.getElementById("cashPaymentRadioBtn").disabled = disabled;
        if (disabled === true) {
            document.getElementById("transferPaymentRadioBtn").checked = true;
            document.getElementById("cashPaymentRadioBtn").checked = false;
        }
    }

    function checkDeliveryType() {
        let checkedPostOffice = document.getElementById("postOfficeRadioBtn").checked;
        let boxberryBtn = document.getElementById("boxberryRadioBtn");
        let checkedBoxberry = false;
        if (boxberryBtn !== null) {
            checkedBoxberry = boxberryBtn.checked
        }
        let pickUpMoscowRadioBtn = document.getElementById("pickUpMoscowRadioBtn");
        let checkedPickUpMoscow = false;
        if (pickUpMoscowRadioBtn !== null) {
            checkedPickUpMoscow = pickUpMoscowRadioBtn.checked;
        }
        let pickUpSamaraRadioBtn = document.getElementById("pickUpSamaraRadioBtn");
        let checkedPickUpSamara = false;
        if (pickUpSamaraRadioBtn !== null) {
            checkedPickUpSamara = pickUpSamaraRadioBtn.checked;
        }

        if (checkedPostOffice) {
            setPostOfficeState(true);
            setBoxberryMoscowState(false);
            setCashPaymentDisabled(true);
        }
        if (checkedBoxberry) {
            setBoxberryMoscowState(true);
            setPostOfficeState(false);
            setCashPaymentDisabled(true);
        }
        if (checkedPickUpMoscow) {
            setPostOfficeState(false);
            setBoxberryMoscowState(false);
            setCashPaymentDisabled(false);
        }
        if (checkedPickUpSamara) {
            setPostOfficeState(false);
            setBoxberryMoscowState(false);
            setCashPaymentDisabled(false);
        }

        let country = document.getElementById("countryInput").value;

        var request = new XMLHttpRequest();
        request.responseType = "text";
        request.onreadystatechange = function () {
            if (this.status === 200 && this.responseText !== '') {
                var responseMessage = JSON.parse(this.responseText);
                recalculatePrice(responseMessage);
            }
        };
        request.open("GET", "buy/checkDelivery?type=" + (checkedPostOffice === true ? "postOffice" :
            (checkedBoxberry === true ? "boxberryMoscow" : "pickup")) +
            "&country=" + country, true);
        request.send();
    }

    function checkPromocode() {
        var code = document.getElementById('promocodeInput').value;
        var promocodeError = document.getElementById('promocodeError');

        if (code !== '') {
            var request = new XMLHttpRequest();
            request.responseType = "text";
            request.onreadystatechange = function () {
                if (this.status === 200 && this.responseText !== '') {
                    var responseMessage = JSON.parse(this.responseText);
                    if (responseMessage.validPromocode === true) {
                        var msg = "Промокод успешно применен";
                        if (responseMessage.promocodeLimit !== null) {
                            msg += ". Действует на " + responseMessage.promocodeLimit + " позицию(и)";
                        }
                        promocodeError.innerHTML = msg;
                    } else {
                        promocodeError.innerHTML = "Промокод не был найден или не активен";
                    }
                    recalculatePrice(responseMessage);
                }
            };
            request.open("GET", "buy/checkPromoCode?code=" + code, true);
            request.send();
        }
    }

    function deleteItem(r, jewelryId) {
        var length = document.getElementById('jewelriesTable').rows.length;
        var i = r.parentNode.parentNode.rowIndex;
        document.getElementById("jewelriesTable").deleteRow(i);
        var request = new XMLHttpRequest();
        request.responseType = "text";
        request.onreadystatechange = function () {
            if (this.status === 200 && this.responseText !== '') {
                if (length !== 1) {
                    var responseMessage = JSON.parse(this.responseText);
                    recalculatePrice(responseMessage);
                } else {
                    hideOrder();
                }
            }
        };
        request.open("GET", "buy/deleteItem?itemId=" + jewelryId, true);
        request.send();
    }

    function recalculatePrice(responseMessage) {
        var formatDiscountSpan = document.getElementById('formatDiscountSpan');
        var formatDeliveryCostSpan = document.getElementById('formatDeliveryCostSpan');
        var formatCostWithoutDiscountSpan = document.getElementById('formatCostWithoutDiscountSpan');
        var formatTotalCostSpan = document.getElementById('formatTotalCostSpan');

        formatDiscountSpan.innerHTML = responseMessage.formatPromocode + " \u20BD";
        formatDeliveryCostSpan.innerHTML = responseMessage.formatDeliveryPrice !== null ?
            responseMessage.formatDeliveryPrice + " \u20BD" : "Неопределена";
        if (responseMessage.formatCostWithoutDiscount !== '0') {
            formatCostWithoutDiscountSpan.innerHTML = responseMessage.formatCostWithoutDiscount + " \u20BD";
        } else {
            formatCostWithoutDiscountSpan.innerHTML = "";
        }
        formatTotalCostSpan.innerHTML = responseMessage.formatTotalCost + " \u20BD";
    }

    function hideOrder() {
        document.getElementById('mainDiv').style.display = 'none';
        document.getElementById('emptyOrder').style.display = 'block';
    }
</script>
</body>
</html>