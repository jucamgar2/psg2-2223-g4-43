<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  

<petclinic:layout pageName="userProfile">
    <a class="btn btn-default"  href="/users/changePlan">Cambiar plan</a>

    <h2>User Profile</h2>

    <h2>Plan Type: ${plan.name}</h2>
        <c:if test="${type == 'veterinarian'}">
            <table class="table table-striped">
                <tr>
                    <th>Nombre</th>
                    <td><b><c:out value="${user.username} "/></b></td>
                </tr>
                <tr>
                    <th>Dirección</th>
                    <td><c:out value="${vet.firstName}"/></td>
                </tr>
                <tr>
                    <th>Ciudad</th>
                    <td><c:out value="${vet.lastName}"/></td>
                </tr>
            </table>
            
            <br/>
            <br/>
            <br/>
                <h2>Especialidades</h2>

                <c:forEach var="sp" items="${vet.specialties}">
            
                        <tr>
                            <td valign="top">
                                <dl class="dl-horizontal">
                                    <tr>
                                        <td><b><c:out value="${sp} "/></b></td>
                                    </tr>
                                </dl>
                            </td>
                        </tr>
            
                    </c:forEach>
            </c:if>
     
        <c:if test="${type == 'owner'}">
            <table class="table table-striped">
                <tr>
                    <th>Nombre</th>
                    <td><b><c:out value="${user.username} "/></b></td>
                </tr>
                <tr>
                    <th>Dirección</th>
                    <td><c:out value="${owner.address}"/></td>
                </tr>
                <tr>
                    <th>Ciudad</th>
                    <td><c:out value="${owner.city}"/></td>
                </tr>
                <tr>
                    <th>Número de teléfono</th>
                    <td><c:out value="${owner.telephone}"/></td>
                </tr>
            </table>
            
            <br/>
            <br/>
            <br/>
            <h2>Macotas</h2>
        
            <table class="table table-striped">
                <c:forEach var="pet" items="${owner.pets}">
        
                    <tr>
                        <td valign="top">
                            <dl class="dl-horizontal">
                                <dt>Nombre</dt>
                                <dd><c:out value="${pet.name}"/></dd>
                                <dt>Cumpleaños</dt>
                                <dd><petclinic:localDate date="${pet.birthDate}" pattern="yyyy-MM-dd"/></dd>
                                <dt>Tipo de mascota</dt>
                                <dd><c:out value="${pet.type.name}"/></dd>
                            </dl>
                        </td>
                    </tr>
        
                </c:forEach>
            </table>
        </c:if>

        <h2>Divisa preferida: ${user.preferedCurrency}</h2>

        <div style="text-align: center; align-items: center;">
            <form action="/users/${user.username}" method="post">
                <label for="currency">Cambiar divisa preferida:</label>
                <select name="currency" id="currency">
                  <c:forEach items="${options}" var="option">
                    <option value="${option}">${option}</option>
                  </c:forEach>
                </select>
                <button type="submit">Aceptar</button>
            </form>
        </div>

    


</petclinic:layout>
