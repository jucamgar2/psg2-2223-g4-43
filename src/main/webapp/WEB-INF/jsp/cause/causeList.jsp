<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>

<petclinic:layout pageName="causes">
    <h2>Causes</h2>

    <br/>        

    <h2>Select currency:</h2>

    <div style="text-align: center; align-items: center;">
        <form:form modelAttribute="currency" class="form-horizontal">
            <div class="form-group has-feedback">
                <div>
    
                    <select name="options" style="width: 150px;height: 50px;margin-bottom: 100 px;">
                        <c:forEach items="${options}" var="option">
                            <option value="${option}">${option}</option>
                         </c:forEach>
                    </select>
                </div>    
                <button class="btn btn-default" style="font-size: 20px; font-family: sans-serif; "  type="submit">Change currency</button>
            </div>
        </form:form>
        </div>

    <table id="causesList" class="table table-striped">
        <thead style="background-color: lightgray;">
        <tr>
            <th style="width: 150px;">Name</th>
            <th style=" width: 200px;">Current Amount</th>
            <th>Target Amount</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${causeBudgets}" var="causeBudget">
            <tr>
                <td>
                    <c:out value="${causeBudget.key.name}"/>
                </td>
                <td>
                    <c:out value="${causeBudget.value.get(1).value}"/>
                </td>
                <td>
                    <c:out value="${causeBudget.value.get(0).value}"/>
                </td>
                <td>
                    <div>
                        <a class="btn btn-default" style="font-size: 15px; font-family: sans-serif; margin-left: 75%; margin-right: 10%;"  href="/causes/details/${causeBudget.key.id}">Detalles</a>
                        <c:if test="${!causeBudget.key.isClosed}">
                            <a class="btn btn-default" style="font-size: 15px; font-family: sans-serif; margin-left: 75%; margin-right: 10%;"  href="/donation/new/${causeBudget.key.id}">Donar</a>
                        </c:if>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div style="position: relative;">
        <a class="btn btn-default" style="font-size: 15px; font-family: sans-serif; margin-left: 75%; margin-right: 10%;"  href="/causes/new">Crear nueva causa</a>
    </div>
    
</petclinic:layout>
