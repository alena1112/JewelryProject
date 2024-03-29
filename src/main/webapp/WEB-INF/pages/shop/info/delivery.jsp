<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>

<html>
<style>
    body, h1, h2, h3, h4, h5, h6 {
        font-family: 'Roboto', sans-serif;
    }

    .w3-bar-block .w3-bar-item {
        padding: 20px
    }
</style>
<body>

<div class="w3-main w3-content w3-padding" style="max-width:1200px">

    <!-- для компенсации размера шапки -->
    <div class="w3-hide-medium w3-hide-small" style="margin-top:110px">
    </div>
    <div class="w3-hide-large" style="margin-top:70px">
    </div>

    <div style="font-size: 15px; padding: 10px 0">
        <c:choose>
            <c:when test="${deliveryPickupAvailableMoscow}">
                <p style="font-weight: bold">
                    САМОВЫВОЗ (г. Москва)
                </p>
                <p style="letter-spacing:1px">
                    Забрать заказ самостоятельно и примерить украшения можно в г.Москва.
                </p>
            </c:when>
            <c:when test="${deliveryPickupAvailableSamara}">
                <p style="font-weight: bold">
                    САМОВЫВОЗ (г. Самара)
                </p>
                <p style="letter-spacing:1px">
                    Забрать заказ самостоятельно и примерить украшения можно в г.Самара, ТРК Космопорт.
                </p>
            </c:when>
        </c:choose>
        <c:choose>
            <c:when test="${boxberryAvailable && boxberryFree}">
                <p style="font-weight: bold">
                    BOXBERRY (г. Москва)
                </p>
                <p style="letter-spacing:1px">
                    Действует БЕСПЛАТНАЯ доставка в любой пункт выдачи Boxberry по г.Москва.
                </p>
            </c:when>
            <c:when test="${boxberryAvailable}">
                <p style="font-weight: bold">
                    BOXBERRY (г. Москва)
                </p>
                <p style="letter-spacing:1px">
                    Забрать заказ можно в любом пункте выдачи Boxberry по г.Москва. Стоимость доставки ${boxberryCost}
                    руб.
                </p>
            </c:when>
        </c:choose>
        <p style="font-weight: bold">
            ДОСТАВКА ПО РОССИИ
        </p>
        <c:choose>
            <c:when test="${deliveryFree}">
                <p style="letter-spacing:1px">
                    Доставка осуществляется БЕСПЛАТНО в любой город Почтой России.
                </p>
            </c:when>
            <c:otherwise>
                <p style="letter-spacing:1px">
                    Доставка осуществляется Почтой России в любой город страны. Стоимость доставки ${deliveryCost} руб.
                </p>
            </c:otherwise>
        </c:choose>
        <p style="font-weight: bold">
            ДОСТАВКА ПО МИРУ
        </p>
        <p style="letter-spacing:1px">
            Доставка украшений осуществляется в любую точку мира. Стоимость доставки для Украины ${ukraineDeliveryCost}
            руб.,
            Казахстана ${kazakhstanDeliveryCost} руб.
            Стоимость доставки для других стран рассчитывается отдельно в момент формирования заказа.
        </p>
    </div>

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
</body>
</html>