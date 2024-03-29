<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>

<petclinic:layout pageName="adoptionRequest">
    <div style="font-size: 20px;color: black;">
        <div>
            <p>Propietario de la mascota:</p><c:out value="${adoptionRequest.author.user.username}"/>
        </div>
        <div>
            <p>Mensaje del propietario: </p><c:out value="${adoptionRequest.message}"/>
        </div>
        <div>
            <p>Nombre de la mascota:</p><c:out value= "${adoptionRequest.pet.name}"/>
        </div>
    </div>

    <table id="adoptionRequestTable" class="table table-striped">
        <thead style="background-color: lightgray;">
            <tr>
                <th>Autor </th>
                <th>Mensaje</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${adoptionRequest.responses}" var="adoptionResponse">
            <tr>
                <td>
                    <c:out value="${adoptionResponse.owner.user.username}"/>
                </td>
                <td>
                    <c:out value="${adoptionResponse.description}"/>
                </td>
                <c:if test="${adoptionResponse.owner.user.username == principal}">
                    <td>
                        <a href="/adoptionResponse/delete/${adoptionRequest.id}/${adoptionResponse.id}">   
                            <span class="glyphicon glyphicon-trash" aria-hidden="true" style=" margin-left: 20%"></span>     
                        </a>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
        </tbody>        
    </table>

    <c:if test = "${adoptionRequest.author.user.username != principal}">
        <spring:url value="/adoptionResponse/new/${adoptionRequest.id}" htmlEscape="true" var="newAR"/>
        <a class="btn btn-default" href="${newAR}">Enviar respuesta</a>
    </c:if>

    <c:if test = "${adoptionRequest.author.user.username == principal}">
        <spring:url value="/adoptionResponse/${adoptionRequest.id}/resp" htmlEscape="true" var="selectAR"/>
        <a class="btn btn-default" href="${selectAR}">Escoger respuesta</a>
    </c:if>

</petclinic:layout>