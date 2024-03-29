<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="head.jsp" %>
<!DOCTYPE html>
<html>

<style>
    body, h1, h2, h3, h4, h5, h6 {
        font-family: 'Roboto', sans-serif;
    }

    .w3-bar-block .w3-bar-item {
        padding: 20px
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
</style>

<script>
    function test(parent, isOver) {
        if (isOver) {
            parent.getElementById("imageOne").style.display = "none";
            parent.getElementById("imageTwo").style.display = "block";
        } else {
            parent.getElementById("imageOne").style.display = "block";
            parent.getElementById("imageTwo").style.display = "none";
        }
    }
</script>

<body>
<div class="w3-main w3-content w3-padding" style="max-width:1200px">

    <!-- для компенсации размера шапки -->
    <div class="w3-hide-medium w3-hide-small" style="margin-top:110px">
    </div>
    <div class="w3-hide-large" style="margin-top:70px">
    </div>

    <p id="emptyList" class="w3-text-grey"
       style="display: ${jewelryList.size() == 0 ? 'display' : 'none'};margin-top:20px;margin-bottom:350px;font-size:12px">
        В данном разделе украшения пока отсутствуют</p>
    <spring:form method="get" action="/menu?type=all" modelAttribute="jewelryList">
        <c:forEach items="${jewelryList}" var="list">
            <div class="w3-row-padding w3-padding-16 w3-center" id="row">
                <c:forEach items="${list}" var="item">
                    <div class="w3-quarter">
                        <a href="${pageContext.request.contextPath}/jewelry?id=${item.id}"
                           class="jewelry-item-class">
                                <%--                            <img src="${imageHelper.getMainImageFullPath(item)}"--%>
                                <%--                                 onmouseover="this.src='https://www.gracefuljewelry.ru/shop/image?name=IMG_0557_Facetune_19-07-2020-23-05-23%202-min.jpg'"--%>
                                <%--                                 onmouseout="this.src='${imageHelper.getMainImageFullPath(item)}'"--%>
                                <%--                                 alt="${item.name}"--%>
                                <%--                                 style="width:100%">--%>
                            <img id="imageOne" src="${imageHelper.getMainImageFullPath(item)}"
                                 alt="${item.name}"
                                 style="width:100%"
                                 onmouseover="test(this.parent, true)" onmouseout="test(this.parent, false)">
<%--                                    TODO нужен иф в случае когда нет второго изоб-ия--%>
                            <img id="imageTwo" src="https://www.gracefuljewelry.ru/shop/image?name=IMG_0557_Facetune_19-07-2020-23-05-23%202-min.jpg"
                                 alt="${item.name}"
                                 style="width:100%;display:none">
                        </a>
                        <a href="${pageContext.request.contextPath}/jewelry?id=${item.id}"
                           class="jewelry-item-class"><h3>${item.name}</h3></a>
                        <a href="${pageContext.request.contextPath}/jewelry?id=${item.id}"
                           class="jewelry-item-class"><p>${item.description}</p></a>
                        <p class="w3-text-grey">${item.isSold ? 'Нет в наличии' : item.formatPrice}</p>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>

        <div class="w3-center w3-padding-32">
            <div class="w3-bar">
                <a href="${pageContext.request.contextPath}/menu?type=${type}&page=${currentPage - 1}"
                   class="w3-bar-item w3-button w3-hover-black">&laquo;</a>
                <c:forEach items="${pages}" var="page">
                    <c:choose>
                        <c:when test="${page == '...'}">
                            <a class="w3-bar-item">...</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/menu?type=${type}&page=${page}"
                               class="w3-bar-item w3-button ${currentPage == page ? 'w3-black' : 'w3-hover-black'}">${page}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/menu?type=${type}&page=${currentPage + 1}"
                   class="w3-bar-item w3-button w3-hover-black">&raquo;</a>
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
</body>
</html>